/* 
 * File:   main.c
 * Author: student
 *
 * Created on May 2, 2016, 8:29 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <sys/time.h>

#define ERR_SUCCESS (0)
#define ERR_NOTCREATE (1)
#define ERR_EMPTY (2)
#define EXIT_ERROR (1)

#define IPCOUNT (1000000)
#define NETCOUNT (20000)

/*
 * 
 */

struct RTEntry {
    struct RTEntry * Next;
    unsigned int Address;
    unsigned int Mask;
};

struct RTEntry * CreateRTable(void) {
    struct RTEntry * Head;
    Head = (struct RTEntry *) malloc(sizeof (struct RTEntry));
    if (Head == NULL)
        return Head;
    Head->Next = NULL;
    Head->Address = Head->Mask = 0xFFFFFFFF;
    return Head;

}

struct RTEntry * FindExisting(struct RTEntry * Table, unsigned int Address, unsigned int Mask) {
    struct RTEntry * I;

    if (Table == NULL)
        return NULL;

    if (Table->Next == NULL)
        return NULL;

    I = Table->Next;

    while (I != NULL) {
        if ((I->Address == Address) && (I->Mask == Mask))
            return I;
        if (I->Mask < Mask)
            return NULL;

        I = I-> Next;
    }
    return NULL;
}

struct RTEntry * AddEntry(struct RTEntry * Table, unsigned int Address, unsigned int Mask) {
    struct RTEntry * I = Table;
    struct RTEntry * Entry;

    if (Table == NULL)
        return NULL;


    if ((Entry = FindExisting(Table, Address, Mask)) != NULL)
        return Entry;


    Entry = (struct RTEntry *) malloc(sizeof (struct RTEntry));

    if (Entry == NULL)
        return NULL;

    Entry->Address = Address;
    Entry->Mask = Mask;

    if (Table->Next == NULL) {
        Table->Next = Entry;
        Entry->Next = NULL;
        return Entry;
    }

    I = Table;

    while (I->Next != NULL) {
        if ((I->Mask >= Mask) && (I->Next->Mask < Mask))
            break;
        I = I->Next;

    }

    Entry->Next = I->Next;
    I->Next = Entry;

    return Entry;

}

int PrintRTable(struct RTEntry * Table) {
    struct RTEntry * I;

    if (Table == NULL)
        return -ERR_NOTCREATE;

    if (Table->Next == NULL)
        return -ERR_EMPTY;

    I = Table->Next;

    while (I != NULL) {
        printf("%hhu.%hhu.%hhu.%hhu/%hhu.%hhu.%hhu.%hhu\n",
                (I->Address >> 24) &0xFF,
                (I->Address >> 16) & 0xFF,
                (I->Address >> 8) & 0xFF,
                (I->Address) & 0xFF,

                (I->Mask >> 24) &0xFF,
                (I->Mask >> 16) & 0xFF,
                (I->Mask >> 8) & 0xFF,
                (I->Mask) & 0xFF);
        I = I->Next;
    }
    return -ERR_SUCCESS;
}

struct RTEntry * RoutingLookup(struct RTEntry * Table, unsigned int DstAddr) {
    struct RTEntry * I;
    if (Table == NULL)
        return NULL;

    if (Table->Next == NULL)
        return NULL;

    I = Table->Next;

    while (I != NULL) {
        if ((DstAddr & (I->Mask)) == I->Address)
            return I;
        I = I->Next;
    }
    return NULL;
}

void FlushRTable(struct RTEntry * Table) {
    struct RTEntry *I, *J;

    if (Table == NULL)
        return;

    if (Table->Next == NULL)
        return;

    I = Table->Next;
    J = I->Next;

    while (J != NULL) {
        free(I);
        I = J;
        J = I->Next;
    }
    free(I);
}

int GenerateNetworks(struct RTEntry * Table, int Count) {
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

int CountRTable(struct RTEntry * Table) {
    int Count = 0;
    struct RTEntry *I;

    if (Table == NULL)
        return -1;

    I = Table -> Next;

    while (I != NULL) {
        Count++;
        I = I->Next;
    }
    return Count;
}

int main(void) {

    struct RTEntry * Table;
    unsigned int * IPs;
    struct timeval Before, After, Duration;
    int MatchCount = 0;

    Table = CreateRTable();
    if (Table == NULL) {
        perror("Create Table");
        exit(EXIT_ERROR);
    }

    GenerateNetworks(Table, NETCOUNT);
    //PrintRTable(Table);

    IPs = (unsigned int *) malloc(IPCOUNT * sizeof (int));
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

    for (int i = 0; i < IPCOUNT; i++) {
        struct RTEntry * I = RoutingLookup(Table, IPs[i]);

        /*printf("%hhu.%hhu.%hhu.%hhu -> ",
                (IPs[i] >> 24) &0xFF,
                (IPs[i] >> 16) & 0xFF,
                (IPs[i] >> 8) & 0xFF,
                (IPs[i]) & 0xFF);*/

        if (I != NULL) {
            MatchCount++;

            /*printf("%hhu.%hhu.%hhu.%hhu/%hhu.%hhu.%hhu.%hhu\n",
                    (I->Address >> 24) &0xFF,
                    (I->Address >> 16) & 0xFF,
                    (I->Address >> 8) & 0xFF,
                    (I->Address) & 0xFF,

                    (I->Mask >> 24) &0xFF,
                    (I->Mask >> 16) & 0xFF,
                    (I->Mask >> 8) & 0xFF,
                    (I->Mask) & 0xFF);*/
        } //else
        /*printf("not found");*/
    }
    gettimeofday(&After, NULL);
    timersub(&After, &Before, &Duration);
    printf("done. Time %ld sec %ld usec, hits: %d, hit ratio: %f, avg lookup time : %f usec, table size: %d\n",
            Duration.tv_sec,
            Duration.tv_usec,
            MatchCount,
            ((float) MatchCount) / IPCOUNT * 100,
            (float) (Duration.tv_sec * 1000000 + Duration.tv_usec) / IPCOUNT,
            CountRTable(Table));


    FlushRTable(Table);
    free(Table);
    return (EXIT_SUCCESS);
}