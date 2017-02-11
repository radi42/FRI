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

#define     DSTPORT         (1234)
#define     DSTADDRESS      "239.1.2.3"
#define     MSGLEN          (576)
#define     EXIT_ERROR      (1)


int main(int argc, char** argv) {

    int Socket;
    struct sockaddr_in DstAddr;
    char Message[MSGLEN];
    const int AllowBroadcast = 1;
    
    Socket = socket(AF_INET, SOCK_DGRAM, 0);
    if (Socket == -1)
    {
      perror ("socket");
      exit (EXIT_ERROR);
    }
    
    DstAddr.sin_family = AF_INET;
    DstAddr.sin_port = htons (DSTPORT);
    if(inet_aton (DSTADDRESS, &(DstAddr.sin_addr)) == 0){
        close (Socket);
        exit (EXIT_ERROR);
    }
    
    if (setsockopt (Socket, SOL_SOCKET, SO_BROADCAST, &AllowBroadcast, sizeof(AllowBroadcast)) == -1) {
        perror ("setsockopt");
        close(Socket);
        exit (EXIT_ERROR);
    }
    
    memset (Message, '\0', MSGLEN);
    printf("> ");
    fflush(stdout);
    fgets (Message, MSGLEN, stdin);     // sprava, kolko, odkial
    
    if(sendto(Socket, Message, strlen (Message) + 1, 0, (struct sockaddr *) &DstAddr, sizeof(DstAddr)) == -1){
        perror("sendto");
    }
    
    close(Socket);
}

