#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>     // zatvorenie suboru
#include <stdint.h>     // jednotne
#include <string.h>     // pracovanie s pamatou na urovni bajtov

#include <sys/types.h>
#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>
#include <errno.h>
#include <net/if.h>
#include <netinet/in.h>

#include <stdbool.h>

#include <pthread.h>

// makra uzatvarat do zatvoriek, lebo nikdy neviem, ako sa to rozbali do kodu
#define SUCCESS (0)
#define ERROR (1)
#define IFACE "wlan0"

#define HW_LEN 6        // symbolicka konstanta na dlzku MAC adresy
#define myMAC "d0:df:9a:73:f3:8e"
#define mojaIP "192.168.1.107"

//#define DEST_IP "192.168.1.1"
#define ARP_TYPE 0x0806  // alebo 0x806

#define ARP_REQUEST 1
#define ARP_REPLY 2

struct ethHdr {
    uint8_t dstMAC[6];
    uint8_t srcMAC[6];
    uint16_t etherType;
    uint8_t payload[0];         // trik na zistenie pociatocnej adresy zaciatku ethernetoveho ramca
} __attribute__((packed));

struct arpHdr {
    uint16_t hwType;
    uint16_t protoType; // typ protokolu
    uint8_t hwLen;
    uint8_t protoLen;
    uint16_t opcode;
    uint8_t srcHwAddr[HW_LEN];
    uint32_t srcIpAddr;
    uint8_t destHwAddr[HW_LEN];
    uint32_t destIpAddr;
} __attribute__((packed));

//===== GLOBALNE PREMENNE =====
int sock;
size_t msgLen = sizeof(struct ethHdr) + sizeof(struct arpHdr);   // velkost spravy
uint32_t myIP;
char dstIP_str[16]; //12 cislic, 3 bodky, null terminator

// Prijimanie ARP odpovede
// pretoze prijimanie sprav je blokujuce
void *reqProcess(void *arg) {
    struct ethHdr *resp;
    struct arpHdr *respArp;

    uint32_t dstIP = *((uint32_t *)arg);

    if((resp = (struct ethHdr *)malloc(msgLen)) == NULL) {
        fprintf(stderr, "malloc(): Can't allocate enough memory");
        exit(ERROR);
    }

    for(;;) {
        memset(resp, 0, msgLen);
        if((read(sock, resp, msgLen)) < 0) {
            perror("read()\n\n");
            close(sock);
            free(resp);
            free(resp);
            exit(ERROR);
        }

        // overime podmienky
        respArp = (struct arpHdr *) resp->payload;

        if(respArp->opcode != htons(ARP_REPLY)) {
            continue;
        }

        if(respArp->srcIpAddr != dstIP) {
            continue;
        }

        // overit, ci odpoved patri mne
        if(respArp->destIpAddr != myIP) {
            continue;
        }

        // sformujeme cielovu IP
        struct in_addr tmp;
        tmp.s_addr = dstIP;

        printf("[IP] %s\t\t[MAC] %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
            inet_ntoa(tmp),
            respArp->srcHwAddr[0],
            respArp->srcHwAddr[1],
            respArp->srcHwAddr[2],
            respArp->srcHwAddr[3],
            respArp->srcHwAddr[4],
            respArp->srcHwAddr[5]);
    }
}

int main(int argc, char **argv) {
    struct sockaddr_ll addr;
    struct ethHdr *eth;     // adresa zaciatku ethernetoveho ramca
    struct arpHdr *arp;

    //vytvorime vlakno na prijem sprav
    pthread_t readerID;

    if(argc < 2) {
        fprintf(stderr, "\nZadaj IP (IPv4) adresu!\n\n");
        exit(ERROR);
    }

    if((sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))) < 0) {
        // vyhodime chybovu hlasku z errno funkciou errno
        perror("ERROR CREATING SOCKET");
        return ERROR;
    }

    memset(&addr, 0, sizeof(struct sockaddr_ll));
    addr.sll_family = AF_PACKET;
    addr.sll_protocol = htons(ETH_P_ALL);
    addr.sll_ifindex = if_nametoindex(IFACE);

    if(addr.sll_ifindex == 0) {
        perror("ERROR BINDING TO INTERFACE");
        close(sock);
        exit(ERROR);
    }

    if (bind(sock, (struct sockaddr *)&addr, sizeof(struct sockaddr_ll)) < 0) {
        perror("ERROR ON BIND");
        exit(ERROR);
    }

    if((eth = (struct ethHdr *)malloc(msgLen)) == NULL) {
        fprintf(stderr, "malloc(): Can't allocate enough memory");
        close(sock);
        exit(ERROR);
    }

    memset(eth, 0, msgLen);     // nespoliehame sa na system, ale vynulujeme si ju sami

    memset(&(eth->dstMAC), 0xFF, HW_LEN);   // nastav cielovu MAC adresu na broadcast

    // ulozime svoju MAC adresu do zdrojovej MAC adresy v ethernetovom ramci - nemusime konvertovat to Network Byte Order, lebo najvyznamnejsi bajt v MAC adrese je prave prvy zlava
    sscanf(myMAC, "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",       // hhx - dva znaky bude brat ako jeden byte - FUNGUJE IBA PRE HEXA CISLA
                &(eth->srcMAC[0]),
                &(eth->srcMAC[1]),
                &(eth->srcMAC[2]),
                &(eth->srcMAC[3]),
                &(eth->srcMAC[4]),
                &(eth->srcMAC[5]));

    eth->etherType = htons(ARP_TYPE);

    arp = (struct arpHdr *)eth->payload;    // pretypujem to na ARP hlavicku
    arp->hwType = htons(0x0001);
    arp->protoType = htons(0x0800);
    arp->hwLen = HW_LEN;
    arp->protoLen = 4;
    arp->opcode = htons(ARP_REQUEST);

    struct in_addr ipAddr;      /* address in network byte order */
    memset(&ipAddr, 0, sizeof(struct in_addr));

    if(inet_aton(mojaIP, &ipAddr) == 0) {
        fprintf(stderr, "inet_aton(): Bad IP address input format");
        close(sock);
        free(eth);
        exit(ERROR);
    }

    // vyplnime zdrojovu MAC adresu
    memcpy(arp->srcHwAddr, eth->srcMAC, HW_LEN);
    arp->srcIpAddr = ipAddr.s_addr;
    myIP = ipAddr.s_addr;   //spristupni moju IPcku globalne


    // vyplnime cielovu MAC adresu - ziskame zo vstupneho argumentu
    memset(&ipAddr, 0, sizeof(struct in_addr));
    if(inet_aton(argv[1], &ipAddr) == 0) {
        fprintf(stderr, "inet_aton(): Bad IP address input format");
        close(sock);
        free(eth);
        exit(ERROR);
    }

    memcpy(arp->destHwAddr, eth->dstMAC, HW_LEN);
    arp->destIpAddr = ipAddr.s_addr;


    pthread_create(&readerID, NULL, reqProcess, (void *)&(arp->destIpAddr));

    // odcitavaci for je lepsi ako scitavaci for cyklus, pretoze pri odcitavacom cykle
    // nam staci odoslat jedinu spravu, cyklus je len na testovanie ;)
    for(;;) {
        if(write(sock, eth, msgLen) < 0) {
            perror("write(): Error writing to socket\n");
            close(sock);
            free(eth);
            exit(ERROR);
        }
        sleep(2);
    }



    close(sock);
    free(eth);

    return SUCCESS;
}


