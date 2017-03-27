#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <pcap/pcap.h>
#include <stdint.h>

#define IFACE "wlan0"

// odchytavanie ramcov cez libpcap
// man pcap - zobrazi zakladny popis a postup, ako to integrovat do programu
// kazda fcia v libpcap ma aj svoju manualovu stranku

// najprv najst rozhranie, na ktorom chceme odchytavat
// vytvorime si kontext - popisovac , nieco, v com bude ulozeny aktualny stav odchytavania
// aktivujeme odchytavanie
// ak potrebujeme spracovat nejaky ramec, odchytime ho

// da sa to aj inak - v nekonecnom cykle cez callback vykoname nejku

// na konci zatvoime kontext

char err_buf[PCAP_ERRBUF_SIZE];

struct ethHdr{
	uint8_t dstMAC[6];
	uint8_t srcMAC[6];
	uint8_t ethType;
	uint8_t payload[0];		// moze tam byt smernik namiesto pola nulovej velkosti?
}__attribute__((packed));

void obsluhaRamca(u_char *user, const struct pcap_pkthdr *hdr, const u_char *frame) {
	struct ethHdr *eth;		// vytvorime si strukturu
	eth = (struct ethHdr*) frame;	// a priradime jej adresu prveho bajtu odchyteneho ramca

	//a potom dereferencujeme premenne struktury ethHdr
	printf("Received frame from %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx"
					"to %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
					eth->srcMAC[0], eth->srcMAC[1], eth->srcMAC[2], eth->srcMAC[3], eth->srcMAC[4], eth->srcMAC[5],
					eth->dstMAC[0], eth->dstMAC[1], eth->dstMAC[2], eth->dstMAC[3], eth->dstMAC[4], eth->dstMAC[5]);
}

int main(void) {
	pcap_t *pcap;			// kontext pre pcap kniznicu
	//struct pcap_pkthdr hdr;	// metadata ethernetoveho ramca
	//uint8_t *frame;			// ramec, do ktoreho nasypeme hlavicku odchyteneho ramca
	//struct ethHdr *eth;

	// najdeme rozhranie, z ktoreho vieme odchytavat
	// bud hard-code alebo cez funkciu pcap_lookupdev
	// pcap_lookupdev - pouzije prve aktivne rozhranie
	// pcap_findalldevs - najde vsetky rozhrania

	// nazov ifaceu a buffer na chybove hlasky
	pcap = pcap_create(IFACE, err_buf);

	if(pcap == NULL) {
		fprintf(stderr, "Error pcap_create() - %s\n", err_buf);
		exit(EXIT_FAILURE);
	}

	// nastavime promiskuitny rezim pre rozhranie
	if(pcap_set_promisc(pcap, 1) != 0) {
		fprintf(stderr, "Error pcap_set_promisc() - %s\n", err_buf);
		exit(EXIT_FAILURE);
	}

	// aktivujeme odchytavanie
	if(pcap_activate(pcap) != 0) {
			fprintf(stderr, "Error pcap_activate() - %s\n", err_buf);
			exit(EXIT_FAILURE);
	}

	// 1. SPOSOB ODCHYTAVANIA - NEKONECNY CYKLUS
	// kazdy ramec odchytavame jeden po druhom v nekonecnom cykle
	// pcap_next - bud chyba nastala, alebo nenastala - ale nevieme odlisit rozne druhy chyb
	// pcap_next_ex - odlisuje chyby podla navratovej hodnoty

	/*for(;;) {
		frame = (uint8_t *)pcap_next(pcap, &hdr);
		if(frame == NULL) {
			fprintf(stderr, "Error pcap_next() - %s\n", err_buf);
			exit(EXIT_FAILURE);
		}

		// ak bolo odchytenie ramca uspesne, nasypeme hlavicku odchyteneho ramca do struktury
		eth = (struct ethHdr*) frame;
		printf("Received frame from %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx"
				"to %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
				eth->srcMAC[0], eth->srcMAC[1], eth->srcMAC[2], eth->srcMAC[3], eth->srcMAC[4], eth->srcMAC[5],
				eth->dstMAC[0], eth->dstMAC[1], eth->dstMAC[2], eth->dstMAC[3], eth->dstMAC[4], eth->dstMAC[5]);

		// ramec sa automaticky znici
	}*/

	// 2. SPOSOB ODCHYTAVANIA - CALLBACK
	// pcap_loop - neustale odchytavame callback funkciou "obshluhaRamca"
	// Nastala chyba pri odchytavani
	if(pcap_loop(pcap, 0, obsluhaRamca, NULL) == -1) {
		pcap_perror(pcap, "pcap_loop()");
		exit(EXIT_FAILURE);
	}

	pcap_close(pcap);
	return EXIT_SUCCESS;
}
