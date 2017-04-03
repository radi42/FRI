#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

#include <sys/socket.h>
#include <netinet/in.h>

#include <errno.h>

#include <arpa/inet.h>

#define PORT	(1234)

int main(int argc, char * argv[]){

	int servSock;
	struct sockaddr_in servAddr;
	uint8_t msg[512];

	char ipAddr[16];

	struct sockaddr_in clientAddr;
	socklen_t addrLen = sizeof(struct sockaddr_in);

	servSock = socket(AF_INET, SOCK_DGRAM, 0);
	if (servSock == -1){
		perror("socket()");
		exit(EXIT_FAILURE);
	}

	memset(&servAddr, 0, sizeof(struct sockaddr_in));
	servAddr.sin_family = AF_INET;
	servAddr.sin_port = htons(PORT);
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);

	if (bind(servSock, (struct sockaddr *) &servAddr, sizeof(struct sockaddr_in)) == -1){
		perror("bind()");
		exit(EXIT_FAILURE);
	}

	for (;;){
		memset(&clientAddr, 0, sizeof(struct sockaddr_in));
		memset(msg, 0, sizeof(msg));

		if (recvfrom(servSock, msg, sizeof(msg), 0, (struct sockaddr *) &clientAddr, &addrLen) == -1){
			perror("recvfrom()");
			exit(EXIT_FAILURE);
		}

		if (inet_ntop(AF_INET, &(clientAddr.sin_addr), ipAddr, sizeof(ipAddr)) == NULL){
			perror("inet_ntop()");
			exit(EXIT_FAILURE);
		}

		printf("[%s:%d] : %s\n", ipAddr, ntohs(clientAddr.sin_port), msg);

	}

	close(servSock);
	return EXIT_SUCCESS;
}
