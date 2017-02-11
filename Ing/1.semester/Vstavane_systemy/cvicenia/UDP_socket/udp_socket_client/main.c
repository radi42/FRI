#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void die(char *s)
{
    perror(s);
    exit(1);
}

int main(int argc, char *argv[])
{
	int sockfd;
	unsigned int serv_len;
	struct sockaddr_in serv_addr;
	struct hostent* server;

	char buffer[256];

	if (argc < 3)
	{
		fprintf(stderr,"usage %s hostname port\n", argv[0]);
		return 1;
	}

	server = gethostbyname(argv[1]);
	if (server == NULL)
	{
		fprintf(stderr, "Error, no such host\n");
		return 2;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	bcopy(
		(char*)server->h_addr,
		(char*)&serv_addr.sin_addr.s_addr,
		server->h_length
	);
	serv_addr.sin_port = htons(atoi(argv[2]));

	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0)
	{
		perror("Error creating socket");
		return 3;
	}

	serv_len = sizeof(serv_addr);

//	if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
//	{
//		 perror("Error connecting to socket");
//		 return 4;
//	}
//
//	printf("Please enter a message: ");
//	bzero(buffer,256);
//	fgets(buffer, 255, stdin);
//
//	n = write(sockfd, buffer, strlen(buffer));
//	if (n < 0)
//	{
//		 perror("Error writing to socket");
//		 return 5;
//	}
//
//	bzero(buffer,256);
//	n = read(sockfd, buffer, 255);
//	if (n < 0)
//	{
//		 perror("Error reading from socket");
//		 return 6;
//	}
//
//	printf("%s\n",buffer);


    while(1)
    {
        bzero(buffer,256);
        printf("Enter message : ");
       	fgets(buffer, 255, stdin);

        //send the message
        if (sendto(sockfd, buffer, 256 , 0 , (struct sockaddr *) &serv_addr, serv_len)==-1)
        {
            die("sendto()");
        }

        //receive a reply and print it
        //clear the buffer by filling null, it might have previously received data
//        memset(buffer,'\0', BUFLEN);
        //try to receive some data, this is a blocking call
//        if (recvfrom(sockfd, buffer, 256, 0, (struct sockaddr *) &serv_addr, &serv_len) == -1)
//        {
//            die("recvfrom()");
//        }
//
//        puts(buffer);
    }
	close(sockfd);

	return 0;
}
