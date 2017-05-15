#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include "queue.h"

#define TOPBIT(x) ((x) >> 31)

struct trieNode {
	struct trieNode* n[2];
	int t;	//terminal symbol
	unsigned int net;
	unsigned int mask;
};

struct trieNode* createNode(void) {
	struct trieNode * node;
	node = (struct trieNode*) malloc(sizeof(struct trieNode));
	if(!node) {		// ked je node prazdny t.j. node == NULL
		fprintf(stderr, "Error: couldn't allocate memory\n");
		return NULL;
	}

	node->t = 0;
	node->net = 0;
	node->mask= 0;
	node->n[0] = NULL;
	node->n[1] = NULL;
	return node;
}

//vriaciame smernik na uzol, ktory reprezentuje siet
struct trieNode* addPrefix(struct trieNode* tab, unsigned int prefix, unsigned  int mask) {
	struct trieNode* actNode;
	unsigned int prefix_orig = prefix;
	unsigned int mask_orig = mask;

	if(!tab) {
		fprintf(stderr, "Error: couldn't add prefix - tree not created\n");
		return NULL;
	}

	actNode = tab;
	while(mask) {
		if(!actNode->n[TOPBIT(prefix)]) {
			if((actNode->n[TOPBIT(prefix)] = createNode()) == NULL) {
				return NULL;
			}
		}
		actNode = actNode->n[TOPBIT(prefix)];
		mask <<= 1;
		prefix <<= 1;
	}

	actNode->t = 1;
	actNode->net = prefix_orig;
	actNode->mask = mask_orig;
	return actNode;
}

void deleteTrie(struct trieNode* tab) {
	struct trieNode* actNode;
	struct Queue* front;

	if(!tab) {
		fprintf(stderr, "Error: Table is NULL in printTrie\n");
		return;
	}

	front = initQueue();
	if(!front){
		fprintf(stderr, "Error: Front is NULL in printTrie\n");
		return;
	}

	// zacnem korenom
	actNode = tab;
	enqueue(front, (void *) actNode);
	actNode = (struct trieNode*) dequeue(front);
	while(actNode != NULL) {
		// vloz laveho potomka
		if(actNode->n[0] != NULL) free((void *) actNode->n[0]);
		// vloz praveho potomka
		if(actNode->n[1] != NULL) free((void *) actNode->n[1]);
	}
}

// na vypis stromu pouzijeme prehliadku level order
void printTrie(struct trieNode* tab) {
	struct trieNode* actNode;
	struct Queue* front;

	if(!tab) {
		fprintf(stderr, "Error: Table is NULL in printTrie\n");
		return;
	}

	front = initQueue();
	if(!front){
		fprintf(stderr, "Error: Front is NULL in printTrie\n");
		return;
	}

	// zacnem korenom
	actNode = tab;
	enqueue(front, (void *) actNode);
	actNode = (struct trieNode*) dequeue(front);
	while(actNode != NULL) {
		// vloz laveho potomka
		if(actNode->n[0] != NULL) enqueue(front, (void *) actNode->n[0]);
		// vloz praveho potomka
		if(actNode->n[1] != NULL) enqueue(front, (void *) actNode->n[1]);

		if(actNode->t) {
			printf("%hhu.%hhu.%hhu.%hhu \t/%hhu.%hhu.%hhu.%hhu\n",
					(actNode->net >> 24) & 0xFF, (actNode->net >> 16) & 0xFF, (actNode->net >> 8) & 0xFF, (actNode->net) & 0xFF,
					(actNode->mask >> 24) & 0xFF, (actNode->mask >> 16) & 0xFF, (actNode->mask >> 8) & 0xFF, (actNode->mask) & 0xFF
					);

		}
	}
}

struct trieNode* lookup(struct trieNode* tab, unsigned int address) {
	// vyhladame prefix v smerovacej tabulke
	if(!tab) {
		fprintf(stderr, "Error: Table is NULL in lookup()");
		return NULL;
	}

	struct trieNode* actNode = tab;
	struct trieNode* match = NULL;		// Longest Prefix Match
	while(actNode) {
		if(actNode->t){
			match = actNode;
		}

		actNode = actNode->n[TOPBIT(address)];
		address <<= 1;
	}

	return match;
}

int main(int argc, char** argv) {
	struct trieNode *root = NULL;

	// Vytvorime tabulku
	root = createNode();

	printTrie(root);

	deleteTrie(root);
	return EXIT_SUCCESS;
}
