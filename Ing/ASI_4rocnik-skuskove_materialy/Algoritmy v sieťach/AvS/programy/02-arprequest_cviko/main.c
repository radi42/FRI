// gcc -Wall -pthread -std=c99 main.c
#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <pthread.h>

struct EthHeader {
    unsigned char Dst[6];
    unsigned char Src[6];
    unsigned short TID;
    unsigned short VID;
    unsigned short EType;
    char Payload[0];
} __attribute__((packed));

struct ARPMessage {
    unsigned short HwType;
    unsigned short ProtoType;
    unsigned char HwSize;
    unsigned char ProtoSize;
    unsigned short Opcode;
    unsigned char SMac[6];
    unsigned char SIP[4];
    unsigned char TMac[6];
    unsigned char TIP[4];
} __attribute__((packed));

#define		MYIP		"158.193.139.232"
#define		MYMAC		"6c:71:d9:be:da:59"
#define		IFACE		"wlan0"

#define		ETHTYPE_ARP	(0x0806)
#define		HWTYPE_ETH	(1)
#define		PROTOTYPE_IP	(0x0800)
#define		HWSIZE_ETH	(6)
#define		PROTOSIZE_IP	(4)
#define		OPCODE_REQ	(1)
#define		OPCODE_RESP	(2)

#define		EXIT_ERROR	(1)
#define		SLEEPTIME	(1)

#define         VLANT_TYPE      (0x8100)
#define         VLAN            (888)

#define		MAX(x,y)	((x)>(y)?(x):(y))


// globalne premenne
int Sock;

void *
PrintResponses(void * Arg) {
    struct EthHeader *Response = NULL;

    Response = (struct EthHeader *) malloc(sizeof (struct EthHeader) + sizeof (struct ARPMessage));

    if (Response == NULL) {
        perror("malloc");
        close(Sock);
        exit(EXIT_ERROR);
    }

    for (;;) {
        struct ARPMessage * ARPResp = (struct ARPMessage *) Response->Payload;

        memset(Response, 0, sizeof (struct EthHeader) + sizeof (struct ARPMessage));
        read(Sock, Response, sizeof (struct EthHeader) + sizeof (struct ARPMessage));

        if (ntohs(ARPResp->Opcode) != OPCODE_RESP) // ak to nie je odpoved, tak zacni zachytavat znovu
            continue;

        if (memcmp(ARPResp->SIP, (unsigned char *) Arg, PROTOSIZE_IP) != 0) // ak sa nezhoduje SENDER IP a TARGET IP
            continue;

        printf("Response from %hhu.%hhu.%hhu.%hhu @ %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
                *(ARPResp->SIP),
                *(ARPResp->SIP + 1),
                *(ARPResp->SIP + 2),
                *(ARPResp->SIP + 3),
                *(ARPResp->SMac),
                *(ARPResp->SMac + 1),
                *(ARPResp->SMac + 2),
                *(ARPResp->SMac + 3),
                *(ARPResp->SMac + 4),
                *(ARPResp->SMac + 5)
                );
    }
    return NULL;
}

int
main(int argc, char *argv[]) {
    struct ARPMessage *ARPRequest = NULL;
    struct EthHeader *Packet = NULL;
    int PacketSize;
    struct sockaddr_ll SA;
    pthread_t ReaderThreadID;

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <IP>\n\n", argv[0]);
        exit(EXIT_ERROR);
    }

    Sock = socket(AF_PACKET, SOCK_RAW, htons(ETHTYPE_ARP));

    if (Sock == -1) {
        perror("socket");
        exit(EXIT_ERROR);
    }

    memset(&SA, 0, sizeof (SA));

    SA.sll_family = AF_PACKET;
    SA.sll_protocol = htons(ETHTYPE_ARP);
    SA.sll_ifindex = if_nametoindex(IFACE);

    if (SA.sll_ifindex == 0) {
        perror("if_nametoindex");
        close(Sock);
        exit(EXIT_ERROR);
    }

    if (bind(Sock, (struct sockaddr *) &SA, sizeof (SA)) == -1) {
        perror("bind");
        close(Sock);
        exit(EXIT_ERROR);
    }

    PacketSize =
            MAX(60, sizeof (struct EthHeader) + sizeof (struct ARPMessage));

    Packet = (struct EthHeader *) malloc(PacketSize);
    if (Packet == NULL) {
        perror("malloc");
        close(Sock);
        exit(EXIT_ERROR);
    }

    memset(Packet, 0, PacketSize);

    memset(Packet->Dst, 0xFF, sizeof (Packet->Dst));
    sscanf(MYMAC, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
            Packet->Src,
            Packet->Src + 1,
            Packet->Src + 2, Packet->Src + 3, Packet->Src + 4, Packet->Src + 5);
    Packet->EType = htons(ETHTYPE_ARP);
    Packet->TID = htons(VLANT_TYPE);
    Packet->VID = htons(VLAN);
    ARPRequest = (struct ARPMessage *) Packet->Payload;

    ARPRequest->HwType = htons(HWTYPE_ETH);
    ARPRequest->ProtoType = htons(PROTOTYPE_IP);
    ARPRequest->HwSize = HWSIZE_ETH;
    ARPRequest->ProtoSize = PROTOSIZE_IP;
    ARPRequest->Opcode = htons(OPCODE_REQ);
    memcpy(ARPRequest->SMac, Packet->Src, sizeof (ARPRequest->SMac));
    sscanf(MYIP, "%hhd.%hhd.%hhd.%hhd",
            ARPRequest->SIP, ARPRequest->SIP + 1, ARPRequest->SIP + 2, ARPRequest->SIP + 3);

    if (sscanf(argv[1], "%hhd.%hhd.%hhd.%hhd",
            ARPRequest->TIP, ARPRequest->TIP + 1, ARPRequest->TIP + 2, ARPRequest->TIP + 3) < 4) {
        fprintf(stderr,
                "%s does not seem to be a valid IP address. Exiting.\n\n",
                argv[1]);
        close(Sock);
        free(Packet);
        exit(EXIT_ERROR);
    }

    if (pthread_create (&ReaderThreadID, NULL, PrintResponses, ARPRequest->TIP) != 0) {
        perror("pthread_create");
        close(Sock);
        free(Packet);
        exit(EXIT_ERROR);
    };

    for (;;) {

        if (write(Sock, Packet, PacketSize) == -1) {
            perror("write");
            close(Sock);
            free(Packet);
            exit(EXIT_ERROR);
        }
        
        sleep(SLEEPTIME);
    }

    close(Sock);
    free(Packet);

    exit(EXIT_SUCCESS);
}