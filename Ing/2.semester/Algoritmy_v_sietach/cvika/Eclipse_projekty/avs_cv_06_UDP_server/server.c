#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <arpa/inet.h>

#define PORT (1234)

// man 7 ip

int main(int argc, char **argv){
	int servSock;
	struct sockaddr_in servAddr;
	uint8_t msg[512];	// 511 znakov + \0
	struct sockaddr_in clientAddr;
	socklen_t addrLen = sizeof(struct sockaddr_in);	// odporuca sa zadat hodnotu, aka velka je adresa servera
	uint8_t ipAddr[16];

	// VYTVOR SOCKET
	servSock = socket(AF_INET, SOCK_DGRAM, 0);
	if(servSock == -1) {
		perror("socket()");
		exit(EXIT_FAILURE);
	}

	// NASTAVIME, NA KTOREJ IP A PORTE MA SERVER POCUVAT
	memset(&servAddr, 0, sizeof(struct sockaddr_in));
	servAddr.sin_family = AF_INET;
	servAddr.sin_port = htons(PORT);	// ak nechceme well-known porty, nepotrebujeme prava roota
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);	// aj ked su to same nuly, je tu stale riziko, ze nejake operacne systemy tomu nebude rozumiet

	// PREPOJIME SOCKET S ROZHRANIM
	if(bind(servSock, (struct sockaddr *)&servAddr, sizeof(struct sockaddr_in)) == 0) {
		perror("bind()");
		exit(EXIT_FAILURE);
	}

	// NEKONECNY CYKLUS PRE PRIJIMANIE SPRAV
	for(;;) {
		memset(&clientAddr, 0, sizeof(struct sockaddr_in));
		memset(&msg, 0, 512);

		if(recvfrom(servSock, &msg, sizeof(msg), 0, (struct sockaddr *)&clientAddr, &addrLen) == -1){
			perror("recvfrom()");
			exit(EXIT_FAILURE);
		}

		if(inet_ntop(AF_INET, &clientAddr, ipAddr, sizeof(ipAddr)) == NULL){
			perror("inet_ntop()");
			exit(EXIT_FAILURE);
		}


		printf("[%s:%d]\t%s\n", ipAddr, ntohs(clientAddr.sin_addr), msg);
	}
	close(servSock);
	return 0;
}
