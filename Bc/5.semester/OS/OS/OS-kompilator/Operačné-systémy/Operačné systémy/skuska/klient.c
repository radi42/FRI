#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <string.h>

int main(int argc, char *argv[]) 
{ 
    int sockfd, portno, n; 
    struct sockaddr_in serv_addr; 
    struct hostent *server; 
 
    char buffer[256]; 
     
     if (argc < 3) { 
       fprintf(stderr,"usage %s hostname port\n", argv[0]); 
       return 0; 
    } 
    portno = atoi(argv[2]); 
    sockfd = socket(PF_INET, SOCK_STREAM, 0); 
    if (sockfd < 0) 
        perror("CHYBA pri otvarani schranky "); 
     
    server = gethostbyname(argv[1]); 
    if (server == NULL) { 
        fprintf(stderr,"CHYBA, nie je taky host\n"); 
        return 0; 
    } 
    memset( &serv_addr,0, sizeof(serv_addr)); 
    serv_addr.sin_family = PF_INET; 
    memcpy((char *)server->h_addr, 
             (char *)&serv_addr.sin_addr.s_addr, 
              server->h_length); 
    serv_addr.sin_port = htons(portno); 
     
    if (connect(sockfd, (struct sockaddr *)&serv_addr,        
               sizeof(serv_addr)) < 0) 
        perror("CHYBA pri connect"); 
    printf("Zadaj spravu: "); 
    memset(&buffer,0,256); 
     
    fgets(buffer, 255, stdin);  
          // zápis do schránky 
    n = write(sockfd, buffer, strlen(buffer)); 
    if (n < 0) 
         perror("CHYBA pri zapise do schranky"); 
    memset(&buffer,0,256); 
    n = read(sockfd,buffer,255); 
    if (n < 0) 
         perror("CHYBA citani zo schranky"); 
    printf("%s\n", buffer); 
    return 0; 
} 