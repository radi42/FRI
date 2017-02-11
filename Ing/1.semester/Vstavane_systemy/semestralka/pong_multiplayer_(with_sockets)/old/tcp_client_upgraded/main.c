#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct
{
    int player1x, player1y, player2x, player2y, ballx, bally;
    int message;
} Message;

int main(int argc, char *argv[])
{
	int sockfd, n;
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

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	if (sockfd < 0)
	{
		perror("Error creating socket");
		return 3;
	}

	if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
	{
		 perror("Error connecting to socket");
		 return 4;
	}

	printf("Please enter a message: ");
	bzero(buffer,256);
	fgets(buffer, 255, stdin);

	n = write(sockfd, buffer, strlen(buffer));
	if (n < 0)
	{
		 perror("Error writing to socket");
		 return 5;
	}

	Message msg;
	while(1)
	{
        n = read(sockfd, &msg, sizeof(msg));
        if (n < 0)
        {
             perror("Error reading from socket");
             return 6;
        }

        printf("%d;%d;%d;%d;%d;%d || sizeof(msg) = %lu || msg = %d\n", msg.player1x, msg.player1y, msg.player2x, msg.player2y, msg.ballx, msg.bally, sizeof(msg), msg.message);

        // Server poslal spravu na ukoncenie hry
        if(msg.message == 1)
        {
            printf("Koniec hry\n");
            break;
        }

	}
	close(sockfd);

	return 0;
}
