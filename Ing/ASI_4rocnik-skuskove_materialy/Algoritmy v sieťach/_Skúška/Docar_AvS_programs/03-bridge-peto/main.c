// gcc -Wall -std=gnu99 main.c

// man 7 packet
// man 7 netdevice
// man 2 select
// man socket
//  man select

#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <net/if.h>
#include <sys/ioctl.h>
#include <linux/if_packet.h>
#include <sys/time.h>
#include <sys/types.h>
#include <sys/select.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <arpa/inet.h>
#include <net/ethernet.h>

#define		MACSIZE		6
#define		MTU		1500
#define		MAXINTERFACES	8
#define		EXIT_ERROR	1

//  MAC adresa

struct MACAddress {
    unsigned char MAC[MACSIZE];
} __attribute__((packed));

//  MAC adresa ako cislo

union MACRep {
    struct MACAddress AsArray;
    unsigned long long int AsInt;
} __attribute__((packed));

struct IntDescriptor {
    char Name [IFNAMSIZ];
    unsigned int IntNo;
    int Socket;
};

struct BTEntry {
    struct BTEntry *Next;
    struct BTEntry *Previous;
    union MACRep Address;
    struct IntDescriptor *IFD;
};

struct EthFrame {
    struct MACAddress Dest;
    struct MACAddress Src;
    unsigned short Type;
    char PaYload [MTU];
} __attribute__((packed));

struct BTEntry * CreateBTEntry(void) {
    struct BTEntry * E = (struct BTEntry *) malloc(sizeof (struct BTEntry));
    if (E != NULL) {
        memset(E, 0, sizeof (struct BTEntry));
        E->Next = NULL;
        E->Previous = NULL;
        E->IFD = NULL;
    }

    return E;
}

struct BTEntry * InsertBTEntry(struct BTEntry * Head, struct BTEntry * Entry) {
    if (Head == NULL)
        return NULL;

    if (Entry == NULL)
        return NULL;

    Entry->Next = Head->Next;
    Entry->Previous = Head;
    Head->Next = Entry;

    return Entry;
}

struct BTEntry * AppendBTEntry(struct BTEntry * Head, struct BTEntry * Entry) {
    struct BTEntry * I;

    if (Head == NULL)
        return NULL;

    if (Entry == NULL)
        return NULL;

    I = Head;
    while (I->Next != NULL)
        I = I->Next;

    I->Next = Entry;
    Entry->Previous = I;

    return Entry;
}

struct BTEntry * FindBTEntry(struct BTEntry * Head, const struct MACAddress * Address) {
    struct BTEntry * I;

    if (Head == NULL)
        return NULL;

    if (Address == NULL)
        return NULL;

    I = Head->Next;
    while (I != NULL) {
        if (memcmp(&(I->Address.AsArray), Address, MACSIZE) == 0)
            return I;

        I = I->Next;
    }

    return NULL;
}

struct BTEntry * EjectBTEntry(struct BTEntry * Head, const struct MACAddress * Address) {
    struct BTEntry * E;

    if (Head == NULL)
        return NULL;

    if (Address == NULL)
        return NULL;

    E = FindBTEntry(Head, Address);
    if (E == NULL)
        return NULL;

    (E->Previous)->Next = E->Next;
    if (E->Next != NULL)
        (E->Next)->Previous = E->Previous;

    return E;
}

void DestroyBTEntry(struct BTEntry * Head, const struct MACAddress * Address) {
    struct BTEntry * E;

    if (Head == NULL)
        return;

    if (Address == NULL)
        return;

    E = EjectBTEntry(Head, Address);
    if (E != NULL)
        free(E);

    return;
}

void FlushBT(struct BTEntry * Head) {
    struct BTEntry * I;

    if (Head == NULL)
        return;

    if (Head->Next == NULL)
        return;

    I = Head->Next;
    while (I->Next != NULL) {
        I = I->Next;
        free(I->Previous);
    }

    free(I);

    Head->Next = Head->Previous = NULL;

    return;
}

void PrintBT (const struct BTEntry *Head) {
    printf("+-------+--------------------------+\n");
    printf("| IFace | MAC ADDRESS              |\n");
    printf("+-------+--------------------------+\n");
    
}

int main(int argc, char * argv[]) {
    struct IntDescriptor Ints [MAXINTERFACES];
    int MaxSockNo = 0;
    struct BTEntry * Table = NULL;

    if ((argc > MAXINTERFACES) || (argc == 1)) {
        fprintf(stderr, "Usage: %s IF1 IF2 ... IF <%d>\n\n", argv[0], MAXINTERFACES);
        exit(EXIT_ERROR);
    }

    memset(Ints, 0, sizeof (Ints)); // vynulujem pole interface-ov

    for (int i = 1; i < argc; i++) { // do pola si ulozim mena interface-ov
        struct ifreq IFR;
        struct sockaddr_ll SA;

        strcpy(Ints[i - 1].Name, argv[i]);

        Ints[i - i].IntNo = if_nametoindex(argv[i]);
        if (Ints[i - 1].IntNo == 0) {
            perror("if_nametoindex");
            exit(EXIT_ERROR);
        }

        
        
        memset(&SA, 0, sizeof (struct sockaddr_ll));
        SA.sll_family = AF_PACKET;
        SA.sll_protocol = htons(ETH_P_ALL);
        SA.sll_ifindex = Ints[i - 1].IntNo;

        Ints[i - 1].Socket = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
        if (Ints[i - 1].Socket == -1) {
            perror("socket");
            exit(EXIT_ERROR);
        }

        if (Ints[i - 1].Socket > MaxSockNo) {
            MaxSockNo = Ints[i - 1].Socket;
        }

        if (bind(Ints[i - 1].Socket, (struct sockaddr *) &SA, sizeof (struct sockaddr_ll)) == -1){
            perror("bind");
            exit(EXIT_ERROR);
        }
            

        
        memset(&IFR, 0, sizeof (struct ifreq));
        strcpy(IFR.ifr_name, argv[i]);
        if (ioctl(Ints[i - 1].Socket, SIOCGIFFLAGS, &IFR) == -1) {
            perror("ioctl get flags");
            exit(EXIT_ERROR);
        };

        IFR.ifr_flags |= IFF_PROMISC; // bitove OR a rovna sa

        if (ioctl(Ints[i - 1].Socket, SIOCSIFFLAGS, &IFR) == -1) {
            perror("ioctl set flags");
            exit(EXIT_ERROR);
        };


    }

    MaxSockNo += 1;

    Table = CreateBTEntry();
    if (Table == NULL) {
        perror("malloc");
        exit(EXIT_ERROR);
    }

    for (;;) {
        fd_set FDs;

        FD_ZERO(&FDs);
        for (int i = 0; i < argc - 1; i++) {
            FD_SET(Ints[i].Socket, &FDs);
        }

        select(MaxSockNo, &FDs, NULL, NULL, NULL);

        for (int i = 0; i < argc - 1; i++) {
            if (FD_ISSET(Ints[i].Socket, &FDs) != 0) {
                struct EthFrame Frame;
                int FrameLength;
                struct BTEntry * E;

                FrameLength = read(Ints[i].Socket, &Frame, MTU + sizeof (struct EthFrame));

                if ((E = FindBTEntry(Table, &(Frame.Src))) == NULL) {

                    E = CreateBTEntry();
                    if (E == NULL) {
                        perror("malloc");
                        exit(EXIT_ERROR);
                    }

                    E->Address.AsArray = Frame.Src;
                    E->IFD = &(Ints[i]);

                    printf("%x:%x:%x:%x:%x:%x to interface %s\n",
                            E->Address.AsArray.MAC[0],
                            E->Address.AsArray.MAC[1],
                            E->Address.AsArray.MAC[2],
                            E->Address.AsArray.MAC[3],
                            E->Address.AsArray.MAC[4],
                            E->Address.AsArray.MAC[5],
                            E->IFD->Name);
                    
                    InsertBTEntry(Table, E);
                    
                } else if (E->IFD != &(Ints[i])) {
                    E->IFD = &(Ints[i]);
                    printf("%x:%x:%x:%x:%x:%x to interface %s\n",
                            E->Address.AsArray.MAC[0],
                            E->Address.AsArray.MAC[1],
                            E->Address.AsArray.MAC[2],
                            E->Address.AsArray.MAC[3],
                            E->Address.AsArray.MAC[4],
                            E->Address.AsArray.MAC[5],
                            E->IFD->Name);
                }

                if ((E = FindBTEntry(Table, &(Frame.Dest))) == NULL) {
                    for (int j = 0; j < argc - 1; j++) {
                        if(i != j) {
                            write (Ints[j].Socket, &Frame, FrameLength);
                        }
                    }
                } else {
                    if (E->IFD != &(Ints[i])) {
                        write (E->IFD->Socket, &Frame, FrameLength);
                    }
                }
            }
        }
    }

    return 0;
}