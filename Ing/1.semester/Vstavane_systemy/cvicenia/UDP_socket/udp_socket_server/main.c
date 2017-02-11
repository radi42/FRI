// SERVER

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>

void die(char *s)
{
    perror(s);
    exit(1);
}

int main(int argc, char *argv[])
{
	int sockfd, newsockfd;
	socklen_t cli_len;
	struct sockaddr_in serv_addr, cli_addr;
//	int n;
	char buffer[256];

	if (argc < 2)
	{
		fprintf(stderr,"usage %s port\n", argv[0]);
		return 1;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(atoi(argv[1]));

	sockfd = socket(AF_INET, SOCK_DGRAM, 0);
	if (sockfd < 0)
	{
		perror("Error creating socket");
		return 1;
	}

	if (bind(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
	{
		 perror("Error binding socket address");
		 return 2;
	}

//	listen(sockfd, 5);
	cli_len = sizeof(cli_addr);

////	UDP server nedokaze prijat spojenie, lebo je nespojovany a nespolahlivy
//	newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len);
//	if (newsockfd < 0)
//	{
//		perror("ERROR on accept");
//		return 3;
//	}

//	bzero(buffer,256);
//	n = read(newsockfd, buffer, 255);
//	if (n < 0)
//	{
//		perror("Error reading from socket");
//		return 4;
//	}
//	printf("Here is the message: %s\n", buffer);
//
//	const char* msg = "I got your message";
//	n = write(newsockfd, msg, strlen(msg)+1);
//	if (n < 0)
//	{
//		perror("Error writing to socket");
//		return 5;
//	}
//
//	close(newsockfd);
//	close(sockfd);


    //keep listening for data
    while(1)
    {
//        printf("Waiting for data...");
        fflush(stdout);

        bzero(buffer,256);
        //try to receive some data, this is a blocking call
        if ((newsockfd = recvfrom(sockfd, buffer, 256, 0, (struct sockaddr *) &cli_addr, &cli_len)) == -1)
        {
            die("recvfrom()");
        }

        //print details of the client/peer and the data received
        printf("Received packet from %s:%d\n", inet_ntoa(cli_addr.sin_addr), ntohs(cli_addr.sin_port));
        printf("Client: %s\n" , buffer);
//
//        //now reply the client with the same data
//        if (sendto(sockfd, buffer, newsockfd, 0, (struct sockaddr*) &cli_addr, cli_len) == -1)
//        {
//            die("sendto()");
//        }
    }
    close(newsockfd);
    close(sockfd);

	return 0;
}
