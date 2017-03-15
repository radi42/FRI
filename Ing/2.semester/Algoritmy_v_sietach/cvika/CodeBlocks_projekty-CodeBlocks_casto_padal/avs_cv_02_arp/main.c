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

// makra uzatvarat do zatvoriek, lebo nikdy neviem, ako sa to rozbali do kodu
#define SUCCESS (0)
#define ERROR (1)
#define IFACE "wlan0"

#define HW_LEN 6        // symbolicka konstanta na dlzku MAC adresy
#define myMAC "d0:df:9a:73:f3:8e"
#define myIP "192.168.1.107"

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

int main(int argc, char **argv) {
    int sock;
    struct sockaddr_ll addr;
    size_t msgLen = sizeof(struct ethHdr) + sizeof(struct arpHdr);   // velkost spravy
    struct ethHdr *eth;     // adresa zaciatku ethernetoveho ramca
    struct arpHdr *arp;

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

    if(inet_aton(myIP, &ipAddr) == 0) {
        fprintf(stderr, "inet_aton(): Bad IP address input format");
        close(sock);
        free(eth);
        exit(ERROR);
    }

    // vyplnime zdrojovu MAC adresu
    memcpy(arp->srcHwAddr, eth->srcMAC, HW_LEN);
    arp->srcIpAddr = ipAddr.s_addr;


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

    // odcitavaci for je lepsi ako scitavaci for cyklus, pretoze pri odcitavacom cykle
    // nam staci odoslat jedinu spravu, cyklus je len na testovanie ;)
    //for(int i = 1000; i >= 0; i--) {
        if(write(sock, eth, msgLen) < 0) {
            perror("write(): Error writing to socket\n");
            close(sock);
            free(eth);
            exit(ERROR);
        }
    //}

    // Prijimanie ARP odpovede
    struct ethHdr *respEthHdr;
    struct arpHdr *respArpHdr;

    if((respEthHdr = (struct ethHdr *)malloc(msgLen)) == NULL) {
        fprintf(stderr, "malloc(): Can't allocate enough memory");
        close(sock);
        free(eth);
        exit(ERROR);
    }

    for(;;) {
        memset(respEthHdr, 0, msgLen);
        if((read(sock, respEthHdr, msgLen)) < 0) {
            perror("read()\n\n");
            close(sock);
            free(eth);
            free(respEthHdr);
            exit(ERROR);
        }

        // overime podmienky
        respArpHdr = (struct arpHdr *) respEthHdr->payload;

        if(respArpHdr->opcode != htons(ARP_REPLY)) {
            continue;
        }

        if(respArpHdr->srcIpAddr != arp->destIpAddr) {
            continue;
        }

        // overit, ci odpoved patri mne
        if(respArpHdr->destIpAddr != arp->srcIpAddr) {
            continue;
        }

        printf("[IP] %s\t\t[MAC] %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n", argv[1],      //02 - chcem 2 znaky, ale ak je mensi, nech ju doplni zlava nulou (podobne ako 'hhx')
            respArpHdr->srcHwAddr[0],
            respArpHdr->srcHwAddr[1],
            respArpHdr->srcHwAddr[2],
            respArpHdr->srcHwAddr[3],
            respArpHdr->srcHwAddr[4],
            respArpHdr->srcHwAddr[5]);
            break;
    }

    close(sock);
    free(eth);

    return SUCCESS;
}

