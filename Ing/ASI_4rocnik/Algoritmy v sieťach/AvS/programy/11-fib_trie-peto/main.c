/* 
 * File:   main.c
 * Author: cyrec
 *
 * Created on Pondelok, 2016, máj 9, 9:30
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>
#include <netinet/ip.h>

#include <arpa/inet.h>

struct TrieNode {
    struct TrieNode * N [2];
    int Terminal;
    struct in_addr Network;
    struct in_addr Netmask;
};

#define             TOPBIT(x)       ((x) >> 31)
#define             ERR_SUCCESS     (0)
#define             ERR_NOTCREATE   (1)
#define             ERR_EMPTY       (2)
#define             EXIT_ERROR      (1)

#define             IPCOUNT         (80000000)
#define             NETCOUNT        (50000)

struct TrieNode *
CreateEmptyNode(void) {
    struct TrieNode * E;
    E = (struct TrieNode *) malloc(sizeof (struct TrieNode));
    if (E == NULL) {
        perror("CreateEmptyNode malloc");
        return NULL;
    }

    memset(E, 0, sizeof (struct TrieNode));

    return E;
}

struct TrieNode *
FindExisting(struct TrieNode * Table, unsigned int Address, unsigned int Mask) {
    struct TrieNode * I;

    if (Table == NULL)
        return NULL;

    I = Table;

    while (Mask != 0) {
        I = I->N[TOPBIT(Address)];

        if (I == NULL)
            return NULL;

        Address <<= 1;
        Mask <<= 1;
    }

    if (I->Terminal == 1)
        return I;
    else
        return NULL;
}

struct TrieNode *
RoutingLookup(struct TrieNode * Table, unsigned int DstAddr) {
    struct TrieNode * I = Table;
    struct TrieNode * Match = NULL;

    while (I != NULL) {
        if (I->Terminal == 1)
            Match = I;

        I = I->N[TOPBIT(DstAddr)];
        DstAddr <<= 1;
    }

    return Match;
}

struct TrieNode *
AddEntry(struct TrieNode * Table, unsigned int Address, unsigned int Mask) {
    unsigned int A = Address;
    unsigned int M = Mask;
    struct TrieNode * I = Table;

    if (Table == NULL)
        return NULL;

    while (M != 0) {
        if (I->N [TOPBIT(A)] == NULL)
            I->N [TOPBIT(A)] = CreateEmptyNode();

        I = I->N [TOPBIT(A)];
        A <<= 1;
        M <<= 1;
    }

    I->Terminal = 1;
    I->Network.s_addr = htonl(Address);
    I->Netmask.s_addr = htonl(Mask);

    return I;
}

void
PrintNodeInfo(struct TrieNode * E) {
    char TN [INET_ADDRSTRLEN];
    char TM [INET_ADDRSTRLEN];

    if (E == NULL)
        return;

    inet_ntop(AF_INET, &(E->Network), TN, INET_ADDRSTRLEN);
    inet_ntop(AF_INET, &(E->Netmask), TM, INET_ADDRSTRLEN);


    printf("%s/%s, T:%d\n", TN, TM, E->Terminal);
}

struct QueueNode {
    struct QueueNode * Next;
    void * Data;
};

struct QueueNode *
Enqueue(struct QueueNode ** Queue, struct QueueNode** Tail, void * Data) {
    struct QueueNode * E;
    E = (struct QueueNode *) malloc(sizeof (struct QueueNode));
    if (E == NULL) {
        perror("malloc");
        return NULL;
    }

    memset(E, 0, sizeof (struct QueueNode));
    E->Data = Data;

    if (*Queue == NULL)
        *Queue = *Tail = E;
    else {
        (*Tail)->Next = E;
        *Tail = E;
    }
    
    return E;
}

void *
Dequeue(struct QueueNode ** Queue, struct QueueNode ** Tail) {
    struct QueueNode * E = *Queue;
    void * Data;

    *Queue = (*Queue)->Next;
    if (*Queue == NULL)
        *Tail = NULL;

    Data = E->Data;
    free(E);

    return Data;
}

void
PrintRoutingTable(struct TrieNode * Table) {
    struct TrieNode * I = Table;
    struct QueueNode * Queue = NULL, * Tail = NULL;

    if (Table == NULL)
        return;

    Enqueue(&Queue, &Tail, I);

    while (Queue != NULL) {
        I = (struct TrieNode *) Dequeue(&Queue, &Tail);

        if (I->Terminal == 1)
            PrintNodeInfo(I);

        if (I->N[0] != NULL)
            Enqueue(&Queue, &Tail, I->N[0]);

        if (I->N[1] != NULL)
            Enqueue(&Queue, &Tail, I->N[1]);
    }
}

int
CountNetworks (struct TrieNode * Table) {
    struct TrieNode * I = Table;
    struct QueueNode * Queue = NULL, *Tail = NULL;
    long int NetCount = 0;
    
    if(Table == NULL)
        return 0;
    
    Enqueue(&Queue, &Tail, I);
    
    while(Queue != NULL) {
        I = (struct TrieNode *) Dequeue(&Queue, &Tail);
        
        if(I->Terminal == 1)
            NetCount++;
        
        if (I->N[0] != NULL)
            Enqueue(&Queue, &Tail, I->N[0]);

        if (I->N[1] != NULL)
            Enqueue(&Queue, &Tail, I->N[1]);
    }
    return NetCount;
}

void
FlushRTable (struct TrieNode * Table) {
    struct TrieNode * I = Table;
    struct QueueNode * Queue = NULL, *Tail = NULL;
    
    if(Table == NULL)
        return;
    
    Enqueue(&Queue, &Tail, I);
    
    while(Queue != NULL) {
        I = (struct TrieNode *) Dequeue(&Queue, &Tail);
        
        if (I->N[0] != NULL)
            Enqueue(&Queue, &Tail, I->N[0]);

        if (I->N[1] != NULL)
            Enqueue(&Queue, &Tail, I->N[1]);
        
        free (I);
    }
}

int GenerateNetworks(struct TrieNode * Table, int Count) {
    if (Table == NULL)
        return -ERR_NOTCREATE;

    srandom(time(NULL));

    int i;
    for (i = 0; i < Count; i++) {
        int MaskLen = ((float) random()) / RAND_MAX * 32;
        int Mask = 0xFFFFFFFF << MaskLen;
        int Address = random() & Mask;
        AddEntry(Table, Address, Mask);
    }
    return -ERR_SUCCESS;
}

/*
 * 
 */
int main(int argc, char** argv) {
    struct TrieNode * Table;
    unsigned int * IPs;
    struct timeval Before, After, Duration;
    int MatchCount = 0;

    Table = CreateEmptyNode();
    if (Table == NULL) {
        perror("Create Empty Node");
        exit(EXIT_ERROR);
    }

    GenerateNetworks(Table, NETCOUNT);
    // PrintRoutingTable(Table);

    IPs = (unsigned int *) malloc(IPCOUNT * sizeof (unsigned int));
    if (IPs == NULL) {
        perror("Malloc");
        FlushRTable(Table);
        free(Table);
        exit(EXIT_ERROR);
    }


    for (int i = 0; i < IPCOUNT; i++) {
        IPs[i] = random();
    }

    
    printf("Starting lookups...\n");
    fflush(stdout);
    gettimeofday(&Before, NULL);
    
    /*vypis
    for (int i = 0; i < IPCOUNT; i++) {
        struct TrieNode * I = RoutingLookup(Table, IPs[i]);

        printf("%hhu.%hhu.%hhu.%hhu -> ",
                (IPs[i] >> 24) &0xFF,
                (IPs[i] >> 16) & 0xFF,
                (IPs[i] >> 8) & 0xFF,
                (IPs[i]) & 0xFF);

        if (I != NULL) {
            MatchCount++;
            PrintNodeInfo(I);
        } else
        printf("not found\n");
    }
    */
    
    
    /*kratky vypis*/
    for (int i = 0; i < IPCOUNT; i++) {
        struct TrieNode * I = RoutingLookup(Table, IPs[i]);
        if (I != NULL)
            MatchCount++;
    }
    /**/
    
    gettimeofday(&After, NULL);
    timersub(&After, &Before, &Duration);
    printf("done. \nTime: %ld sec %ld usec, hits: %d, ratio: %f, avg lookup time : %f usec, table size: %d\n",
            Duration.tv_sec,
            Duration.tv_usec,
            MatchCount,
            ((float) MatchCount) / IPCOUNT * 100,
            (float) (Duration.tv_sec * 1000000 + Duration.tv_usec) / IPCOUNT,
            CountNetworks(Table));

    FlushRTable(Table);
    free(Table);
    return (EXIT_SUCCESS);
    return (EXIT_SUCCESS);
}