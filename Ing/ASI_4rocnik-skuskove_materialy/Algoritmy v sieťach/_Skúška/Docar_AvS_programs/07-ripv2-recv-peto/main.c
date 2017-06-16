#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/udp.h>

#include <arpa/inet.h>
#include <net/if.h>

#include <pthread.h>

#define		RIP_GROUP	"224.0.0.9"
#define		RIP_VERSION	(2)
#define		PORT		(520)
#define		MSGLEN		(1500-20-8)

#define		IPTXTLEN	(4*3 + 3 + 1)

#define		RIP_M_RESP	(2)

#define		EXIT_ERROR	(1)

struct RIPNetEntry {
    unsigned short int AF;
    unsigned short int Tag;
    struct in_addr Net;
    struct in_addr Mask;
    struct in_addr NHop;
    unsigned int Metric;
} __attribute__((packed));

struct RIPMessage {
    unsigned char Command;
    unsigned char Version;
    unsigned short int Unused;
    struct RIPNetEntry Entry[0];
} __attribute__((packed));

int
main(void) {
    int Socket;
    struct sockaddr_in MyAddr;
    struct ip_mreqn McastGroup;
    struct RIPMessage *RM;
    pthread_t Vlakno;
    struct RIPMessage *Send;

    Send->Command = 2;
    Send->Version = 2;
    
    if (inet_aton(RIP_GROUP, &(McastGroup.imr_multiaddr)) == 0) {
        fprintf(stderr, "Error: %s is not a valid IPv4 address.\n\n",
                RIP_GROUP);
        exit(EXIT_ERROR);
    }

    McastGroup.imr_address.s_addr = INADDR_ANY;
    McastGroup.imr_ifindex = 0;
    //McastGroup.imr_ifindex = if_nametoindex ("veth1");

    if ((Socket = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
        perror("socket");
        exit(EXIT_ERROR);
    }

    MyAddr.sin_family = AF_INET;
    MyAddr.sin_port = htons(PORT);
    MyAddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(Socket, (struct sockaddr *) &MyAddr, sizeof (MyAddr)) == -1) {
        perror("bind");
        close(Socket);
        exit(EXIT_ERROR);
    }

    if (setsockopt(Socket, IPPROTO_IP, IP_ADD_MEMBERSHIP,
            &McastGroup, sizeof (McastGroup)) == -1) {

        perror("setsockopt");
        close(Socket);
        exit(EXIT_ERROR);
    }

    if ((RM = (struct RIPMessage *) malloc(MSGLEN)) == NULL) {
        perror("malloc");
        close(Socket);
        exit(EXIT_ERROR);
    }

    if ((Send = (struct RIPMessage *) malloc(MSGLEN)) == NULL) {
        perror("malloc");
        close(Socket);
        exit(EXIT_ERROR);
    }

    for (;;) {
        struct sockaddr_in SenderAddr;
        socklen_t AddrLen;
        struct RIPNetEntry *E;
        ssize_t BytesRead;
        ssize_t BytesProcessed;
        struct RIPNetEntry *E2;

        E2->AF = htons(2);
        E2->Tag = htons(2);
        E2->Net = ;
        E2->Mask = ;
        E2->NHop = ;
        E2->Metric = htonl(2);
        
        /*
              if (pthread_create (&Vlakno, NULL, PrintResponses, ARPRequest->TIP) != 0) {
                perror("pthread_create");
                close(Socket);
                free(Packet);
                exit(EXIT_ERROR);
            };
         */

        BytesProcessed = 0;
        memset(RM, 0, MSGLEN);
        AddrLen = sizeof (SenderAddr);

        if ((BytesRead =
                recvfrom(Socket, RM, MSGLEN, 0, (struct sockaddr *) &SenderAddr,
                &AddrLen)) == -1) {
            perror("recvfrom");
            close(Socket);
            exit(EXIT_ERROR);
        }

        if (((BytesRead -
                sizeof (struct RIPMessage)) % sizeof (struct RIPNetEntry)) != 0) {
            printf("Corrupted (truncated) RIP message from %s\n",
                    inet_ntoa(SenderAddr.sin_addr));

            continue;
        }

        if (BytesRead < sizeof (struct RIPMessage)) {
            printf("Corrupted RIP message with incomplete header from %s\n",
                    inet_ntoa(SenderAddr.sin_addr));

            continue;
        }

        if (RM->Command != RIP_M_RESP) {
            printf("Unknown RIP message type %hhu from %s\n",
                    RM->Command, inet_ntoa(SenderAddr.sin_addr));

            continue;
        }

        if (RM->Version != RIP_VERSION) {
            printf("Unknown RIP message version %hhu from %s\n",
                    RM->Version, inet_ntoa(SenderAddr.sin_addr));

            continue;
        }

        BytesProcessed += sizeof (struct RIPMessage);

        E = RM->Entry;

        printf("RIP message from %s:\n", inet_ntoa(SenderAddr.sin_addr));
        while (BytesProcessed < BytesRead) {
            if (ntohs(E->AF) == AF_INET) {
                char Network[IPTXTLEN];
                char Netmask[IPTXTLEN];
                char NextHop[IPTXTLEN];

                memset(Network, '\0', IPTXTLEN);
                memset(Netmask, '\0', IPTXTLEN);
                memset(NextHop, '\0', IPTXTLEN);

                strncpy(Network, inet_ntoa(E->Net), IPTXTLEN - 1);
                strncpy(Netmask, inet_ntoa(E->Mask), IPTXTLEN - 1);
                strncpy(NextHop, inet_ntoa(E->NHop), IPTXTLEN - 1);

                printf("\t%s/%s, metric=%u, nh=%s, tag=%hu\n",
                        Network,
                        Netmask, ntohl(E->Metric), NextHop, ntohs(E->Tag));
            } else
                printf("\tUnknown address family %hu\n", ntohs(E->AF));

            BytesProcessed += sizeof (struct RIPNetEntry);
            E++;
        }
    }

    close(Socket);

    exit(EXIT_SUCCESS);

}