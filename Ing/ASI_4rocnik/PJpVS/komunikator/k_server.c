#include <sys/socket.h>
#include <arpa/inet.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include "k_definitions.h"

int main(int argc, char** argv) {
    
    if (argc < 3) {
        printError("Malo argumentov pre spustenie programu.");
    }
    int port = atoi(argv[1]);
    char *userName = argv[2];
    
    //vytvorenie socketu <sys/socket.h>
    int serverSocket = socket(AF_INET, SOCK_STREAM, 0);
    if (serverSocket < 0) {
        printError("Chyba - socket.");        
    }
    
    //definovanie adresy servera <arpa/inet.h>
    struct sockaddr_in serverAddress;
    serverAddress.sin_family = AF_INET;         //internetove sockety
    serverAddress.sin_addr.s_addr = INADDR_ANY; //prijimame spojenia z celeho internetu
    serverAddress.sin_port = htons(port);       //nastavenie portu
    
    //namapovanie adresy servera na socket <sys/socket.h>
    if (bind(serverSocket, (struct sockaddr *) &serverAddress, sizeof(serverAddress)) < 0) {
        printError("Chyba - bind.");
    }
    
    //server bude pocuvat na sockete <sys/socket.h>
    listen(serverSocket, 10);
    
    //server caka na pripojenie klienta <sys/socket.h>
    struct sockaddr_in clientAddress;
    int clientAddressLength = sizeof(clientAddress);
    int clientSocket = accept(serverSocket, (struct sockaddr *) &clientAddress, &clientAddressLength);
    if (clientSocket < 0) {
        printError("Chyba - accept.");        
    }
    
    DATA data;
    data.socket = clientSocket;
    data.stop = 0;
    strcpy(data.userName, userName);
    sem_init(&(data.sem), 0, 1);

    pthread_t thread;
    pthread_create(&thread, NULL, writeData, (void *)&data);

    fd_set sockets;
    FD_ZERO(&sockets);
    FD_SET(clientSocket, &sockets);
    struct timeval tv;
    tv.tv_sec = 2;
    tv.tv_usec = 0;
    int max = clientSocket + 1;
    char buffer[BUFFER_LENGTH];
    while(!isStopped(&data)) {
        select(max, &sockets, NULL, NULL, NULL);
	if (FD_ISSET(clientSocket, &sockets)) {
            bzero(buffer, BUFFER_LENGTH);
            read(clientSocket, buffer, BUFFER_LENGTH);
            if (strstr(buffer, endMsg) != NULL) {
                printf("Pouzivatel ukoncil komunikaciu.\n");
                break;
            } else {
                printf("%s", buffer);
            }			
        }
    }
    
    //uzavretie socketu klienta
    close(clientSocket);
    
    //uzavretie socketu servera
    close(serverSocket);   
    
    return (EXIT_SUCCESS);
}