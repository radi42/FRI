#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <strings.h>
#include <stdint.h>		// uint typy
#include <unistd.h>		// praca so subormi

#include <sys/socket.h>	// sockety
#include <netinet/in.h>	// sockety
#include <sys/socket.h>	// set/getsockopt

#include <errno.h>		// chybovy priznak

#include <arpa/inet.h>	// konverzia IP adresy

#define BUF_SIZE 256

// Posiela spravy na UDP server so zadanou IPckou a portom
// prvy argument je ip adresa, druhy je port
int main(int argc, char * argv[]){
	int fd;
	struct sockaddr_in servAddr;
	int port_int;	// pomocna premenna na kontrolu, ci je v spravnom ciselnom formate
	int enable = 1;		// premenna pre setsockopt() - 1 zapina
	socklen_t enable_len = sizeof(enable);

	struct ip_mreqn mcast;

	if(argc != 3) {
		printf("Usage: %s [cielova_adresa] [cielovy_port]", argv[0]);
		exit(EXIT_FAILURE);
	}

	port_int = atoi(argv[2]);

	// VYTVORENIE SOCKETU
	fd = socket(AF_INET, SOCK_DGRAM, 0);	// cislo protokolu napr. pre UDPlite
	if(fd == -1) {
		perror("socket()");
		exit(EXIT_FAILURE);
	}

	memset(&servAddr, 0, sizeof(struct sockaddr_in));
	servAddr.sin_family = AF_INET;
	servAddr.sin_port = port_int;

	if(inet_pton(AF_INET, argv[1], &servAddr.sin_addr) == -1){
		perror("inet_pton()");
		exit(EXIT_FAILURE);
	}

	// v pripade klientov funkciu "bind" nepotrebujem

	// connect() sluzi na virtualne spojenie s druhou stranou
	// vyhoda - mozeme pouzivat funkcie send() a write() bez nutnosti uvedenia IP adresy zakazdym
	// nevyhoda - vieme komunikovat naraz iba s jednou stranou

	// mozeme menit parametre socketu funkciou setsockopt()
	/*if(setsockopt(fd, SOL_SOCKET, SO_BROADCAST, &enable, enable_len)){
		perror("setsockopt()");
		exit(EXIT_FAILURE);
	}*/

	// multicast je jednoduchy na odosielanie, ale zlozitejsi na prijimanie
	// man ip 7 -> IP_ADD_MEMBERSHIP

	memset(&mcast, 0, sizeof(struct ip_mreqn));
	mcast.imr_multiaddr= servAddr.sin_addr;
	mcast.imr_ifindex = 0;	// 0 znamena "ignoruj index rozhrania" (pretoze ma prednost)
	mcast.imr_address.s_addr = INADDR_ANY;

	if(setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mcast, sizeof(struct ip_mreqn))){
		perror("setsockopt()");
		exit(EXIT_FAILURE);
	}


	// v nekonecnom cykle odosielam spravy
	char msg[] = "Ahoj!\n";
	for(;;) {
		// odosielame spravy
		printf("%s", msg);
		sendto(fd, msg, sizeof(msg), 0, (const struct sockaddr *) &servAddr, sizeof(struct sockaddr_in));
		sleep(1);
	}
	close(fd);

	// Klient spravy odosiela, ale spravy miznu v ciernej diere ... :/

	exit(EXIT_SUCCESS);
}
