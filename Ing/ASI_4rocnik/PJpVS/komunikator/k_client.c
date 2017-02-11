#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/socket.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <netdb.h>

#include "k_definitions.h"

int main(int argc, char *argv[]) {
    if (argc < 4) {
        printError("Malo argumentov pre spustenie programu.");
    }
    
    //ziskanie adresy a portu servera
    struct hostent *server = gethostbyname(argv[1]);
    if (server == NULL) {
        printError("Server neexistuje.");
    }
    int port = atoi(argv[2]);
    char *userName = argv[3];
    
    //vytvorenie socketu <sys/socket.h>
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        printError("Chyba - socket.");        
    }
    
    //definovanie adresy servera <arpa/inet.h>
    struct sockaddr_in serverAddress;
    bzero((char *) &serverAddress, sizeof(serverAddress));
    serverAddress.sin_family = AF_INET;
    bcopy((char *)server->h_addr, 
         (char *)&serverAddress.sin_addr.s_addr,
         server->h_length);
    serverAddress.sin_port = htons(port);

    if (connect(sock,(struct sockaddr *) &serverAddress, sizeof(serverAddress)) < 0) {
        printError("Chyba - connect.");        
    }
    
    char buffer[BUFFER_LENGTH];

    DATA data;
    data.socket = sock;
    data.stop = 0;
    strcpy(data.userName, userName);
    sem_init(&(data.sem), 0, 1);

    pthread_t thread;
    pthread_create(&thread, NULL, writeData, (void *)&data);

    fd_set sockets;
    FD_ZERO(&sockets);
    FD_SET(sock, &sockets);
    struct timeval tv;
    tv.tv_sec = 2;
    tv.tv_usec = 0;
    int max = sock + 1;
    while(!isStopped(&data)) {
        select(max, &sockets, NULL, NULL, NULL);
        if (FD_ISSET(sock, &sockets)) {
            bzero(buffer, BUFFER_LENGTH);
            read(sock, buffer, BUFFER_LENGTH);
            if (strstr(buffer, endMsg) != NULL) {
                printf("Pouzivatel ukoncil komunikaciu.\n");
                stop(&data);
                break;
            } else {
                printf("%s", buffer);
            }      
        }
    }
    
    close(sock);
    
    return (EXIT_SUCCESS);
}
