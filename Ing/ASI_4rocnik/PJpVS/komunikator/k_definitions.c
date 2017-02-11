#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/socket.h>
#include <sys/time.h>
#include <arpa/inet.h>
#include <netdb.h>

#include "k_definitions.h"

char *endMsg = ":end\n";

void stop(DATA *data) {
    sem_wait(&(data->sem));
    data->stop = 1;
    sem_post(&(data->sem));
}
int isStopped(DATA *data) {
    int stop;
    sem_wait(&(data->sem));
    stop = data->stop;
    sem_post(&(data->sem));
    return stop;
}

int printError(char *str) {
    printf("%s\n", str);
    exit(EXIT_FAILURE);
}

void *writeData(void *data) {    
    DATA *pdata = (DATA *)data;
    char *userName = pdata->userName;
    int sock = pdata->socket;
    char buffer[BUFFER_LENGTH];
    char text[BUFFER_LENGTH - strlen(userName) + 1];

    while(1) {
        fgets(text, BUFFER_LENGTH, stdin);
        bzero(buffer, BUFFER_LENGTH);
        sprintf(buffer, "%s: %s", userName, text);        
        write(sock, buffer, strlen(buffer));
        
        if (strstr(buffer, endMsg) != NULL) {
            printf("Koniec komunikacie.\n");
            stop(pdata);
            break;
        }
    }
}

