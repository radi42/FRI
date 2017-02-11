/* 
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/udp.h>

#include <arpa/inet.h>

#define     SRCPORT         (520)
#define     MSGLEN          (576)
#define     EXIT_ERROR      (1)
#define     IPTXTLEN        (24)

#define     DSTADDR         "255.255.255.255"
#define     NETADDR         "10.118.1.0"
#define     MASKADDR        "255.255.255.0"
#define     HOPADDR         "0.0.0.0"

struct RIPNetEntry {
    unsigned short int AF;
    unsigned short int Tag;
    struct in_addr Net;
    struct in_addr Mask;
    struct in_addr NHop;
    unsigned int Metric;
} __attribute__((packed));;

struct RIPMessage {
    unsigned char Command;
    unsigned char Version;
    unsigned short int Unused;
    struct RIPNetEntry Entry[0];
} __attribute__((packed));;

int main(int argc, char** argv) {

    int Socket;
    struct sockaddr_in MyAddr;
    struct ip_mreqn McastGroup;
    struct RIPMessage *RM;
    

    if (argc != 2) {
        fprintf(stderr, "Usage: %s <Multicast group address>\n\n", argv[0]);
        exit(EXIT_ERROR);
    }
    
    if (inet_aton (argv[1], &(McastGroup.imr_multiaddr)) == 0) {
        fprintf (stderr, "Error: %s is not a valid IPv4 address.\n\n", argv[1]);
        exit(EXIT_ERROR);
    }
    
    McastGroup.imr_address.s_addr = INADDR_ANY;
    McastGroup.imr_ifindex = 0;

    Socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (Socket == -1) {
        perror("socket");
        exit(EXIT_ERROR);
    }

    MyAddr.sin_family = AF_INET;
    MyAddr.sin_port = htons(SRCPORT);
    MyAddr.sin_addr.s_addr = INADDR_ANY;

    if (bind(Socket, (struct sockaddr *) &MyAddr, sizeof (MyAddr)) == -1) {
        perror("bind");
        exit(EXIT_ERROR);
    }

    if (setsockopt (Socket,IPPROTO_IP, SO_BROADCAST, &McastGroup, sizeof(McastGroup)) == -1 ){
        perror("setsockopt");
        close(Socket);
        exit(EXIT_ERROR);
    }
    
    if ((RM = (struct RIPMessage *) malloc (MSGLEN)) == NULL) {
        perror("malloc");
        close(Socket);
        exit(EXIT_ERROR);
    }
    struct sockaddr_in Send_Address;
    Send_Address.sin_family = AF_INET;
    inet_aton(NETADDR, &Send_Address.sin_addr.s_addr);
    
    struct sockaddr_in Send_Mask;
    Send_Address.sin_family = AF_INET;
    inet_aton(MASKADDR, &Send_Mask.sin_addr.s_addr);
    
    struct sockaddr_in Send_Hop;
    Send_Address.sin_family = AF_INET;
    inet_aton(HOPADDR, &Send_Hop.sin_addr.s_addr);
    
    struct RIPMessage *Send;
    Send= (struct RIPMessage *) malloc(MSGLEN);
    Send->Version=htons(2);
    Send->Command=htons(2);
    struct RIPNetEntry *SendE;
    SendE=(struct RIPNetEntry *) malloc(MSGLEN-32);
    SendE->AF=htons(2);
    SendE->Mask= Send_Mask;
    SendE->Metric=htonl(2);
    SendE->NHop= Send_Hop;
    SendE->Net= Send_Address;
    SendE->Tag=htons(11);
    memcpy=(Send->Entry,SendE,MSGLEN-32);

    for (;;) {
        struct sockaddr_in SenderAddr;
        socklen_t AddrLen;
        struct RIPNetEntry *E;
        ssize_t BytesRead;
        ssize_t BytesProcessed;
        
        BytesProcessed = 0;
        memset(RM, 0, MSGLEN);

        AddrLen = sizeof (SenderAddr);

        BytesRead = recvfrom(Socket, RM, MSGLEN, 0, (struct sockaddr *) &SenderAddr, &AddrLen);
        
        BytesProcessed += sizeof(struct RIPMessage);
        
        E = RM->Entry;
        printf("RIP message from %s:\n", inet_ntoa(SenderAddr.sin_addr));

        while (BytesProcessed < BytesRead){
            if(ntohs (E->AF) == AF_INET) {
                char Network[IPTXTLEN];
                char Netmask[IPTXTLEN];
                char NextHop[IPTXTLEN];
                
                memset (Network, '\0', IPTXTLEN);
                memset (Netmask, '\0', IPTXTLEN);
                memset (NextHop, '\0', IPTXTLEN);
                
                strncpy (Network, inet_ntoa (E->Net), IPTXTLEN - 1);
                strncpy (Netmask, inet_ntoa (E->Mask), IPTXTLEN - 1);
                strncpy (NextHop, inet_ntoa (E->NHop), IPTXTLEN - 1);
                
                printf("\t%s/%s, metric=%u, nh=%s, tag=%hu\n",
                        Network,Netmask,ntohl(E->Metric), NextHop, ntohs(E->Tag));
            }
            else
                printf("\tUnknown address family %hu\n", ntohs(E->AF));
            
            BytesProcessed += sizeof(struct RIPNetEntry);
            E++;
        }

    }
    close(Socket);
}

