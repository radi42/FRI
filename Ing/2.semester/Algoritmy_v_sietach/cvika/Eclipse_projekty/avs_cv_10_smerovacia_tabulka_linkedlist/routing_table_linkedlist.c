#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <time.h>
#include <sys/time.h>

struct SmerTabZaznam {
	uint32_t netPrefix;
	uint32_t mask;
	int val;
	struct SmerTabZaznam *next;
};

void vytvorTab(struct SmerTabZaznam **head) {
	*head = malloc(sizeof(struct SmerTabZaznam));
	memset(*head, 0, sizeof(struct SmerTabZaznam));
}

_Bool vlozZaznamNaZaciatok(struct SmerTabZaznam **head, int val) {
	struct SmerTabZaznam *novyZaznam = malloc(sizeof(struct SmerTabZaznam));
	if(novyZaznam == NULL) {
		puts("Nemozem vlozit dalsi zaznam - neviem alokovat miesto");
		return false;
	}

	// Ak je prazdny, potom maju prefix aj maska hodnotu 0, lebo sme ich vynulovali
	if((*head)->val == 0) {
		(*head)->val = val;
		(*head)->next = NULL;
		return true;
	}

	novyZaznam->val = val;
	novyZaznam->next = *head;
	*head = novyZaznam;
	return true;
}

void zmazTabulku(struct SmerTabZaznam **tab) {
	// TODO - uvolnit este vsetky ostatne polozky
	free(*tab);
	*tab = NULL;
}

void vypisTabulku(struct SmerTabZaznam *head) {
	struct SmerTabZaznam *aktualny = head;
	while(true) {
		if(aktualny == NULL) exit(EXIT_FAILURE);

		printf("%d\n", aktualny->val);

		if(aktualny->next != NULL) aktualny = aktualny->next;
		else break;
	}
}

int generateNetworks(struct SmerTabZaznam *rt, int count) {
	if(rt == NULL) {
		puts("generateNetworks(): Table not created yet");
		exit(EXIT_FAILURE);
	}

	if(count <= 0) {
		puts("generateNetworks(): Bad parameter");
		exit(EXIT_FAILURE);
	}

	srandom(time(NULL));

	for(int i = 0; i < count; i++) {
		uint32_t maskLen = random() % 33;
		uint32_t mask = 0xFFFFFFFF << (32 - maskLen);	//sprava vyplnime nulami

		uint32_t prefix = random() & mask;

//		vlozZaznamNaZaciatok(&rt, prefix, mask);
		vlozZaznamNaZaciatok(&rt, mask);
	}

	return EXIT_SUCCESS;
}

int main(int argc, char **argv) {
	struct SmerTabZaznam *head = NULL;

	// Vytvorime tabulku
	vytvorTab(&head);
	if(head == NULL) {
		puts("Nepodarilo sa vytvorit smerovaciu tabulku");
		return EXIT_FAILURE;
	}


	head->val = 1;
	head->next = NULL;

	vlozZaznamNaZaciatok(&head, 2);

	vypisTabulku(head);

	zmazTabulku(&head);
	return EXIT_SUCCESS;
}
