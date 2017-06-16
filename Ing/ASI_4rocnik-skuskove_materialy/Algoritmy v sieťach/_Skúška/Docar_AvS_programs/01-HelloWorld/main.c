/* 
 * File:   main.c
 * Author: cyrec
 *
 * Created on Pondelok, 2016, február 22, 10:07
 * 
 * gcc -Wall main.c
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h> // read a write a podobne pre sockety

#include <sys/types.h> 
#include <sys/socket.h>

#include <string.h>

#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>  // htons

#include <net/if.h> // if_nametoindex

#define EXIT_ERROR  (1)
#define INTERFACE   "wlan0"

// definicia ramca

struct EthFrame {
    unsigned char DstMac [6]; // cielova MAC adresa = 6B
    unsigned char SrcMac [6]; // zdrojova MAC adresa = 6B
    unsigned short EthTYPE; // typ = 2B
    char Payload [1500]; // data = 1500B max
} __attribute__((packed)); // nenafukuj, nezarovnaja v pamati = ukladaj v pamati hned za sebou

int main(void) {
    int Socket; // nas soket
    struct sockaddr_ll Addr;
    struct EthFrame MyFrame;

    //  vytvorenie socketu
    Socket = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)); // AF_PACKET - tvorim si vlastny paket, SOCK_RAW - surovy ramec

    if (Socket == -1) {
        perror("socket");
        exit(EXIT_ERROR);
    }

    //  vynulovanie struktury
    memset(&Addr, 0, sizeof (Addr));

    //  naplnenie struktury
    Addr.sll_family = AF_PACKET;
    Addr.sll_protocol = htons(ETH_P_ALL); // chcem dostavat vsetky ramce
    Addr.sll_ifindex = if_nametoindex(INTERFACE);

    if (Addr.sll_ifindex == 0) {
        perror("if_nametoindex");
        close(Socket);
        exit(EXIT_ERROR);
    }

    //  priradenie adresy
    if (bind(Socket, (struct sockaddr *) &Addr, sizeof (Addr)) == -1) { // smernik na struck sockaddr
        perror("bind");
        close(Socket);
        exit(EXIT_ERROR);
    }

    //  vynulujem MyFrame
    memset(&MyFrame, 0, sizeof (MyFrame));

    //  zapis na cielovu adresu - broadcast MAC adresu
    memset(&MyFrame, 0xFF, 6);

    for (int i = 200; i < 210; i++) {
        //  nastavenie zdrojovej MAC adresy
        MyFrame.SrcMac[0] = 0x02; // privatna MAC adresa
        MyFrame.SrcMac[5] = i; // posledne cislo MAC adresy

        //  nastavenie typu
        MyFrame.EthTYPE = htons(0xDEAD); // treba prehodit bajty

        //  nastavenie tela
        strcpy(MyFrame.Payload, "Prve cviko - HACK MirecD");

        //  poslanie ramca
        if (write(Socket, &MyFrame, sizeof (MyFrame)) == -1) {
            perror("write");
            close(Socket);
            exit(EXIT_ERROR);
        }
    }

    close(Socket);
    exit(EXIT_SUCCESS);
}

