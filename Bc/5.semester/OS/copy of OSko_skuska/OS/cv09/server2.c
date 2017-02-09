#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  int sockfd, newsockfd, portno, clilen;
  char buffer[256];
  struct sockaddr_un serv_addr, cli_addr;
  int n;
fd_set fdset;

  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sockfd < 0)
    perror("ERROR opening socket");

  bzero((char *) &serv_addr, sizeof(serv_addr));

  serv_addr.sun_family = AF_UNIX;
  strcpy( serv_addr.sun_path, "socket" );

  if (bind(sockfd, (struct sockaddr *) &serv_addr, sizeof(serv_addr)) < 0) {
    perror("ERROR on binding");
        exit(1);
  }
	listen(sockfd,5);
  clilen = sizeof(cli_addr);
  newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
  if (newsockfd < 0) {
    perror("ERROR on accept");
    exit(1);
  }
struct timeval t;
t.tv_sec= 1;
t.tv_usec=0;

while ( 1 )
{
  bzero(buffer,256);

  select( 2, &fdset,0,0,&t);


if( FD_ISSET( sockfd, &fdset))
{
	printf(">");
  fgets(buffer,255,stdin);
  n = write(newsockfd, buffer,255);
  if (n < 0)
    perror("ERROR writing to socket");
}

if( FD_ISSET(0, &fdset))
{
  n = read(newsockfd,buffer,255);

  if (n < 0)
    error("ERROR reading from socket");

  printf("%s\n",buffer);
  bzero(buffer,256);
}

}
  return 0;
}