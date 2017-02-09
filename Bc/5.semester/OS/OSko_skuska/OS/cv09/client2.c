#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netdb.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
  int sockfd, n;
  struct sockaddr_un serv_addr;
  struct hostent *server;
	fd_set fdset;

  char buffer[256];

  sockfd = socket(AF_UNIX, SOCK_STREAM, 0);
  if (sockfd < 0)
    perror("ERROR opening socket");

  bzero((char *) &serv_addr, sizeof(serv_addr));
  serv_addr.sun_family = AF_UNIX;
  strcpy( serv_addr.sun_path, "socket" ); 

  if (connect(sockfd,&serv_addr,sizeof(serv_addr)) < 0) {
    perror("ERROR connecting");
    exit(1);
  }

struct timeval t;
t.tv_sec= 1;
t.tv_usec=0;

while ( 1 )
{
  printf("> ");
  bzero(buffer,256);
 
	int ret = select(2,&fdset,0,0,&t);

if ( FD_ISSET( sockfd, &fdset) )
{
	 fgets(buffer,255,stdin);
	n = write(sockfd,buffer,strlen(buffer));

  if (n < 0)
    error("ERROR writing to socket");
  bzero(buffer,256);
}

if( FD_ISSET(0, &fdset))
{
  n = read(sockfd,buffer,255);

  if (n < 0)
    error("ERROR reading from socket");
  printf("%s\n",buffer);
}
}
  return 0;
}