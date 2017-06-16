/* 
 * File:   main.c
 * Author: martinus
 *
 * Created on Pondelok, 2016, apríl 11, 8:06
 */


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include<sys/socket.h>
#include<sys/types.h>

#include<netinet/in.h>
#include<netinet/tcp.h>

#include<arpa/inet.h>

#include<netdb.h>

#define LISTEN_PORT (1234)
#define HELLO_MSG ("Satanislav\n")
#define EXIT_ERROR (1)
#define BACKLOG (10)
#define MAX_MSG_LEN (100)

/*
 * 
 */
int main(int argc, char** argv) {
    int ServSock;
    struct sockaddr_in ServAddr;
    char Msg[] = HELLO_MSG;
    char MsgFromClient[MAX_MSG_LEN];
    
    if((ServSock = socket(AF_INET,SOCK_STREAM,0)) < 0){
        perror("socket");
        exit(EXIT_ERROR);
    }
    
    int enable = 1;
    if(setsockopt(ServSock,SOL_SOCKET,SO_REUSEADDR,&enable,sizeof(enable))==-1){
        perror("setsockopt");
        close(ServSock);
        exit(EXIT_ERROR);
    }
    
    ServAddr.sin_family = AF_INET;
    ServAddr.sin_port = htons(LISTEN_PORT);
    ServAddr.sin_addr.s_addr = htonl(INADDR_ANY);
    
    if(bind(ServSock,(struct sockaddr *)&ServAddr,sizeof(ServAddr)) == -1){
        perror("bind");
        close(ServSock);
        exit(EXIT_ERROR);
    }
    
    if(listen(ServSock,BACKLOG) == -1){
        perror("listen");
        close(ServSock);
        exit(EXIT_ERROR);
    }
    
    while(1){
        struct sockaddr_in ClientAddr;
        socklen_t ClientAddrLen;
        int ClientSock;
        FILE * ClientFile = NULL;
        
        memset(MsgFromClient,'\0',sizeof(MsgFromClient));
        
        if((ClientSock = accept(ServSock,(struct sockaddr *)&ClientAddr,&ClientAddrLen)) == -1){
            perror("accept");
            continue;
        }
        
        if((ClientFile = fdopen(ClientSock, "r")) == NULL){
            perror("fdopen");
            close(ClientSock);
            continue;
        }
        
        do{
            if(fgets(MsgFromClient,sizeof(MsgFromClient),ClientFile) == NULL){
                fprintf(stderr,"End of communication with %s:%d\n",inet_ntoa(ClientAddr.sin_addr),ntohs(ClientAddr.sin_port));
                break;
            }
        
        printf("IP: %s PORT: %d TEXT: %s\n",inet_ntoa(ClientAddr.sin_addr),ntohs(ClientAddr.sin_port),MsgFromClient);
        
        char * indexSent;
        int BytesSent = 0;
        int sent;
        
        while(BytesSent < sizeof(Msg)){
            sent = write(ClientSock,indexSent,sizeof(Msg)-BytesSent);
            if(sent < 0){
                perror("write");
                break;
            }
            BytesSent += sent;
            indexSent += sent;
        }
        if(sent < 0){
            break;
        }
        
        }while(strcmp(MsgFromClient,"\n") != 0);
        
        
        /*
        int BytesRecv = 0;
        int recv;
        char * indexRecv = MsgFromClient;
        
        while((recv = read(ClientSock,indexRecv,sizeof(MsgFromClient)-1-BytesRecv)) > 0){
            BytesRecv += recv;
            indexRecv += recv;
        }
        
        if(recv < 0){
            perror("read");
            continue;
        }
*/
        
     
    
        close(ClientSock);
    }
    return (EXIT_SUCCESS);
}