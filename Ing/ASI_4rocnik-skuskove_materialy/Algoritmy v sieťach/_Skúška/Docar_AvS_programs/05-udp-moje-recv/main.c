/* 
 * dest UDP --> 192.168.1.1; port --> 1234
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

#define     SRCPORT         (1234)
#define     MSGLEN          (576)
#define     EXIT_ERROR      (1)

int main(int argc, char** argv) {

    int Socket;
    struct sockaddr_in MyAddr;
    struct ip_mreqn McastGroup;

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
    
    if (setsockopt (Socket,IPPROTO_IP, IP_ADD_MEMBERSHIP, &McastGroup, sizeof(McastGroup)) == -1 ){
        perror("setsockopt");
        close(Socket);
        exit(EXIT_ERROR);
    }

    for (;;) {
        struct sockaddr_in SenderAddr;
        socklen_t AddrLen;
        char Message[MSGLEN];

        AddrLen = sizeof (SenderAddr);
        memset(Message, '\0', MSGLEN);

        if (recvfrom(Socket, Message, MSGLEN, 0, (struct sockaddr *) &SenderAddr, &AddrLen) == -1) {
            perror("recvfrom");
            exit(EXIT_ERROR);
            close(Socket);
        }

        printf("%s:%u writes: %s\n", inet_ntoa(SenderAddr.sin_addr), ntohs(SenderAddr.sin_port), Message);

    }
    close(Socket);
}

