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

#include <stdbool.h>

// makra uzatvarat do zatvoriek, lebo nikdy neviem, ako sa to rozbali do kodu
#define SUCCESS (0)
#define ERROR (1)
#define IFACE "wlan0"
#define HELLO "breathe!"

// __attribute__(packed) - zakaze vyplnanie do 4 bajtov pre 32 bit resp do 8 bajtov pre 64 bitove procesory
struct frameHdr {
    uint8_t dstMAC[6];
    uint8_t srcMAC[6];
    uint16_t etherType;
} __attribute__((packed));

struct frame {
    uint8_t dstMAC[6];
    uint8_t srcMAC[6];
    uint16_t etherType;
    uint8_t payload[1500];
} __attribute__((packed));

int main() {
    // VYTVOR SOCKET
    // socket je iba integer (file descriptor). socket je nieco podobne ako subor

    // socket(domena, typ, protokol - 2. a vyssej)
    int sock = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    if(sock < 0) {
        // vyhodime chybovu hlasku z errno funkciou errno
        perror("ERROR CREATING SOCKET");
        return ERROR;
    }

    // PREPOJ SOCKET S ROZHRANIM
    // bind(socket, adresa, velkost adresy)
    struct sockaddr_ll addr;
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

    // vytvorime ramec:
    //sourceMAC - 6B
    //destMAC - 6B
    //etherType - 2B
    //payload - 465 - 1500
    struct frame ramec;
    memset(&ramec, 0, sizeof(struct frame));

    // destination MAC -> broadcast
//    for(int i = 0; i < 6; i++) {
//        ramec.dstMAC[i] = 0xFF;
//    }

    memset(ramec.dstMAC, 0xFF, 6);

    // source MAC
    // nastavime jej specialny bit, ktory hovori, ci je MAC adresa testovacia - 2. bit najvyssieho bajtu
    // najvyssi bajt sa nachadza na zaciatku pola
    memset(&ramec.srcMAC[0], 0x2, sizeof(ramec.srcMAC[0]));
    memset(&ramec.srcMAC[5], 0x13, sizeof(ramec.srcMAC[5]));

    // nastavenie ethertype (length / type)
    // ak je <= 1500 -> vtedy je to velkost; ak je >1500, potom je to typ
    memset(&ramec.etherType, htons(0xDEAD), sizeof(ramec.etherType));

    //zapiseme ramec
//    strncpy(ramec.payload, HELLO, sizeof(ramec.payload));
    memcpy(ramec.payload, HELLO, sizeof(ramec.payload));

//    for(int i = 0; i < 1000; i++) {
    while(true) {
        if(write(sock, &ramec, sizeof(struct frame)) < 0) {
            perror("ERROR ON WRITE");
            close(sock);
            exit(ERROR);
        }
        sleep(1);
    }

    return SUCCESS;
}
