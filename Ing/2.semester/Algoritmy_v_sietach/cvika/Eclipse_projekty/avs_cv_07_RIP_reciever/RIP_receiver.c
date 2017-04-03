#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>

#include <sys/socket.h>
#include <netinet/in.h>

#include <errno.h>

#include <arpa/inet.h>

// Port a IP pre RIPv2 sa nemenia
#define RIP_PORT "520"
#define RIP_MCAST "224.0.0.9"

#define MAX_MSG_LEN 1472 // 1500 - 20 - 8

#define RIP_RESPONSE 0x02

// informacie o prefixe - appendovane ku ripv2 strukture
struct rip_entry {
	uint16_t addr_family_id;
	uint16_t route_tag;

	struct in_addr netPrefix;	// s IP adresou pracujeme cez strukturu in_addr
	struct in_addr mask;
	struct in_addr nextHop;
	uint32_t metric;
}__attribute__((packed));

struct rip {
	uint8_t command;		// 0 - request, 1 - response
	uint8_t version;		// mala by byt 2
	uint16_t unused;		// musia byt nuly
	struct rip_entry entries[0];		// smernik na zaznamy o prefixoch ()
}__attribute__((packed));



int main(int argc, char * argv[]){
	int fd;
	struct sockaddr_in servAddr;
	struct in_addr mcastAddr;
	struct ip_mreqn mcast;
	uint8_t msg[MAX_MSG_LEN];
	struct sockaddr_in recvAddr;
	socklen_t addr_len = sizeof(struct sockaddr_in);

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd == -1){
		perror("socket()");
		exit(EXIT_FAILURE);
	}

	memset(&servAddr, 0, sizeof(struct sockaddr_in));
	servAddr.sin_family = AF_INET;
	servAddr.sin_port = htons(atoi(RIP_PORT));
	servAddr.sin_addr.s_addr = htonl(INADDR_ANY);

	if(inet_pton(AF_INET, RIP_PORT, &mcastAddr.s_addr) == -1){
		perror("inet_pton()");
		exit(EXIT_FAILURE);
	}

	if (bind(fd, (struct sockaddr *) &servAddr, sizeof(struct sockaddr_in)) == -1){
		perror("bind()");
		exit(EXIT_FAILURE);
	}

	memset(&mcast, 0, sizeof(struct ip_mreqn));
	mcast.imr_multiaddr= servAddr.sin_addr;
	mcast.imr_ifindex = 0;					// 0 znamena "ignoruj index rozhrania" (pretoze ma prednost)
	mcast.imr_address.s_addr = INADDR_ANY;

	if(setsockopt(fd, IPPROTO_IP, IP_ADD_MEMBERSHIP, &mcast, sizeof(struct ip_mreqn))){
		perror("setsockopt()");
		exit(EXIT_FAILURE);
	}

	// Ako viem, ze som spracoval celu spravu?
	// do nejakej pomocnej premennej si postupne ukladam pocty uz spracovanych bajtov
	ssize_t msg_len;		// aktualna dlzka
	struct rip *ripMsg;			// smernik na prijatu spravu
	struct rip_entry *entry;	// aktualne spracovavana polozka

	for (;;){
		memset(msg, 0, sizeof(msg));
		memset(&recvAddr, 0, sizeof(struct sockaddr_in));

		msg_len = recvfrom(fd, msg, sizeof(msg), 0, (struct sockaddr *) &recvAddr, &addr_len) == -1;
		ripMsg = (struct rip *) msg;
		if((msg_len - sizeof(struct rip) % sizeof(struct rip_entry)) != 0){
			continue;
		}

		// kazda sprava musi mat aspon jeden zaznam o prefixe
		if(msg_len < sizeof(struct rip) + sizeof(struct rip_entry)){
			continue;
		}

		if(ripMsg->command != RIP_RESPONSE){
			continue;
		}

		// prijimame iba spravy RIPv2
		if(ripMsg->version != 0x02){
			continue;
		}

		printf("CMD: 0x%02hhx :: Ver:0x%02hhx", ripMsg->command, ripMsg->version);

		msg_len -= sizeof(struct rip);

		// koniec zistime postupnym odcitanim zaznamov
		entry = ripMsg->entries;
		while(msg_len > 0){
			printf("\tAF: 0x%hx", entry->addr_family_id);
			printf("\tRouteTag: 0x%hx", entry->route_tag);
			printf("\tPrefix: %s", inet_ntoa(entry->netPrefix));
			printf("\tMask: %s", inet_ntoa(entry->mask));
			printf("\tNextHop: %s", inet_ntoa(entry->nextHop));
			printf("\tMetric: %u", ntohl(entry->metric));
			puts("");

			msg_len -= sizeof(struct rip_entry);
			entry++;
		}
	}

	close(fd);
	return EXIT_SUCCESS;
}
