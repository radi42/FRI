#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>
#include <pthread.h>
#include <sched.h>
#include <pcap.h>

#include <sys/select.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <arpa/inet.h>

#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>

#define		MACSIZE		6
#define		MTU		65535
#define		MAXINTERFACES	8
#define		EXIT_ERROR	1
#define		MACMAXAGE	300

/*
 * Struktura IntDescriptor uchovava informacie o sietovom rozhrani, ktore
 * nas bridge obsluhuje - meno rozhrania, jeho cislo v Linuxe, a socket,
 * ktorym na tomto rozhrani citame a odosielame ramce.
 *
 */

struct IntDescriptor
{
  char Name[IFNAMSIZ];
  pcap_t *Handle;
  int MACManSock[2];
};

/*
 * Struktura MACAddress obaluje 6-bajtove pole pre uchovavanie MAC adresy. 
 * Obalenie do struktury je vyhodne pri kopirovani (priradovani) MAC adresy
 * medzi premennymi rovnakeho typu.
 *
 */

struct MACAddress
{
  unsigned char MAC[MACSIZE];
} __attribute__ ((packed));

/*
 * Union MACRep umoznuje pozriet sa na MAC adresu dvomi sposobmi, bud ako na
 * 6-bajtove pole neznamienkovych cisel, alebo ako na 8-bajtovy integer,
 * ktoreho horne dva bajty su v nasom programe nedefinovane (pocitame s tym,
 * ze mame little-endian architekturu).  Integer reprezentacia umozni pracu
 * s bitmi MAC adresy, co sa zide pri implementacii tabulky formou binarneho
 * vyhladavacieho stromu.
 *
 */

union MACRep
{
  struct MACAddress AsArray;
  unsigned long long int AsInt;
} __attribute__ ((packed));

/*
 * Struct BTEntry je prvok zretazeneho zoznamu, ktory reprezentuje riadok
 * prepinacej tabulky.  V riadku je okrem smernikov na dalsi a predosly
 * prvok ulozena MAC adresa a smernik na rozhranie, kde je pripojeny klient,
 * ako aj cas, kedy sme videli tohto odosielatela naposledy.
 *
 */

struct BTEntry
{
  struct BTEntry *Next;
  struct BTEntry *Previous;
  union MACRep Address;
  time_t LastSeen;
  struct IntDescriptor *IFD;
};

/* 
 * Struct EthFrame reprezentuje zakladny ramec podla IEEE 802.3 s maximalnou
 * velkostou tela.
 *
 */

struct EthFrame
{
  struct MACAddress Dest;
  struct MACAddress Src;
  unsigned short Type;
  char Payload[MTU];
} __attribute__ ((packed));


struct BTEntry *Table = NULL;
struct IntDescriptor Ints[MAXINTERFACES];
pthread_rwlock_t TableLock = PTHREAD_RWLOCK_INITIALIZER;
int IntCount = 0;

/*
 * Funkcia pre vytvorenie noveho riadku tabulky.  Riadok nebude zaradeny do
 * tabulky, bude mat len inicializovane vnutorne hodnoty.
 *
 */

struct BTEntry *
CreateBTEntry (void)
{
  struct BTEntry *E = (struct BTEntry *) malloc (sizeof (struct BTEntry));
  if (E != NULL)
    {
      memset (E, 0, sizeof (struct BTEntry));
      E->Next = E->Previous = NULL;
      E->IFD = NULL;
    }

  return E;
}

/*
 * Funkcia pre vlozenie vytvoreneho riadku do tabulky na jej zaciatok.
 *
 */

struct BTEntry *
InsertBTEntry (struct BTEntry *Head, struct BTEntry *Entry)
{
  if (Head == NULL)
    return NULL;

  if (Entry == NULL)
    return NULL;

  Entry->Next = Head->Next;
  Entry->Previous = Head;
  Head->Next = Entry;

  return Entry;
}

/*
 * Funkcia pre vlozenie vytvoreneho riadku do tabulky na jej koniec.
 *
 */

struct BTEntry *
AppendBTEntry (struct BTEntry *Head, struct BTEntry *Entry)
{
  struct BTEntry *I;

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

/*
 * Funkcia hladajuca riadok tabulky podla zadanej MAC adresy.
 *
 */

struct BTEntry *
FindBTEntry (struct BTEntry *Head, const struct MACAddress *Address)
{
  struct BTEntry *I;

  if (Head == NULL)
    return NULL;

  if (Address == NULL)
    return NULL;

  I = Head->Next;
  while (I != NULL)
    {
      if (memcmp (&(I->Address.AsArray), Address, MACSIZE) == 0)
	return I;

      I = I->Next;
    }

  return NULL;
}

struct BTEntry *
EjectBTEntryByItem (struct BTEntry *Head, struct BTEntry *Item)
{
  if (Head == NULL)
    return NULL;

  if (Item == NULL)
    return NULL;

  (Item->Previous)->Next = Item->Next;
  if (Item->Next != NULL)
    (Item->Next)->Previous = Item->Previous;

  return Item;
}

struct BTEntry *
EjectBTEntryByMAC (struct BTEntry *Head, const struct MACAddress *Address)
{
  struct BTEntry *E;

  if (Head == NULL)
    return NULL;

  if (Address == NULL)
    return NULL;

  E = FindBTEntry (Head, Address);
  if (E == NULL)
    return NULL;

  E = EjectBTEntryByItem (Head, E);

  return E;
}


/*
 * Funkcia na vynatie a uplne zrusenie riadku tabulky i z pamate.  Vyhladava
 * sa podla MAC adresy.
 *
 */

void
DestroyBTEntry (struct BTEntry *Head, const struct MACAddress *Address)
{
  struct BTEntry *E;

  if (Head == NULL)
    return;

  if (Address == NULL)
    return;

  E = EjectBTEntryByMAC (Head, Address);
  if (E != NULL)
    free (E);

  return;
}

/*
 * Funkcia na vypis obsahu prepinacej tabulky.
 *
 */

void
PrintBT (const struct BTEntry *Head)
{

#define TLLEN (2+IFNAMSIZ+3+17+2+1)

  struct BTEntry *I;
  char TableLine[TLLEN];

  memset (TableLine, '-', TLLEN - 2);
  TableLine[0] = TableLine[2 + IFNAMSIZ + 1] = TableLine[TLLEN - 2] = '+';
  TableLine[TLLEN - 1] = '\0';
  printf (TableLine);
  printf ("\n");

  memset (TableLine, ' ', TLLEN - 2);
  TableLine[0] = '|';
  strncpy (TableLine + 2, "Interface", 9);
  TableLine[2 + IFNAMSIZ + 1] = '|';
  strncpy (TableLine + 2 + IFNAMSIZ + 1 + 2, "MAC Address", 11);
  TableLine[TLLEN - 2] = '|';
  printf (TableLine);
  printf ("\n");

  memset (TableLine, '-', TLLEN - 2);
  TableLine[0] = TableLine[2 + IFNAMSIZ + 1] = TableLine[TLLEN - 2] = '+';
  TableLine[TLLEN - 1] = '\0';
  printf (TableLine);
  printf ("\n");

  if (Head == NULL)
    return;

  if (Head->Next == NULL)
    return;

  I = Head->Next;
  while (I != NULL)
    {
      memset (TableLine, ' ', TLLEN - 2);
      TableLine[0] = '|';

      strncpy (TableLine + 2, I->IFD->Name, strlen (I->IFD->Name));
      TableLine[2 + IFNAMSIZ + 1] = '|';
      sprintf (TableLine + 2 + IFNAMSIZ + 1 + 2,
	       "%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx",
	       I->Address.AsArray.MAC[0], I->Address.AsArray.MAC[1],
	       I->Address.AsArray.MAC[2], I->Address.AsArray.MAC[3],
	       I->Address.AsArray.MAC[4], I->Address.AsArray.MAC[5]);
      TableLine[TLLEN - 3] = ' ';
      TableLine[TLLEN - 2] = '|';

      printf (TableLine);
      printf ("\n");

      I = I->Next;
    }

  memset (TableLine, '-', TLLEN - 2);
  TableLine[0] = TableLine[2 + IFNAMSIZ + 1] = TableLine[TLLEN - 2] = '+';
  TableLine[TLLEN - 1] = '\0';
  printf (TableLine);
  printf ("\n");

  return;
}

/*
 * Funkcia uplne zrusi a dealokuje z pamate celu prepinaciu tabulku, necha
 * iba pociatocny zaznam.
 *
 */

struct BTEntry *
FlushBT (struct BTEntry *Head)
{
  struct BTEntry *I;

  if (Head == NULL)
    return Head;

  if (Head->Next == NULL)
    return Head;

  I = Head->Next;
  while (I->Next != NULL)
    {
      I = I->Next;
      free (I->Previous);
    }

  free (I);

  Head->Next = Head->Previous = NULL;

  return Head;
}

/*
 * Funkcia realizujuca obsluhu zdrojovej adresy v prepinacej tabulke.  Ak
 * adresa v tabulke neexistuje, funkcia pre nu vytvori a do tabulky vlozi
 * novy zaznam.  Ak adresa v tabulke existuje, funkcia podla potreby
 * aktualizuje zaznam o vstupnom rozhrani, a v kazdom pripade aktualizuje
 * cas, kedy sme naposledy tuto zdrojovu adresu videli.
 *
 */

struct BTEntry *
UpdateOrAddMACEntry (struct BTEntry *Table, const struct MACAddress *Address,
		     const struct IntDescriptor *IFD)
{
  struct BTEntry *E;

  if (Table == NULL)
    return NULL;

  /* Vyhladame zdrojovu adresu v tabulke. */
  if ((E = FindBTEntry (Table, Address)) == NULL)
    {

      /* Adresa je neznama. Zalozime pre nu novy zaznam. */
      E = CreateBTEntry ();
      if (E == NULL)
	{
	  perror ("malloc");
	  /* TODO: ... ;) */
	  exit (EXIT_ERROR);
	}

      E->Address.AsArray = *Address;
      E->IFD = (struct IntDescriptor *) IFD;

      printf ("Adding address %x:%x:%x:%x:%x:%x to interface %s\n",
	      E->Address.AsArray.MAC[0],
	      E->Address.AsArray.MAC[1],
	      E->Address.AsArray.MAC[2],
	      E->Address.AsArray.MAC[3],
	      E->Address.AsArray.MAC[4],
	      E->Address.AsArray.MAC[5], E->IFD->Name);
      InsertBTEntry (Table, E);
      PrintBT (Table);
    }
  else if (E->IFD != IFD)
    /* Adresa je znama, ale naucena na inom rozhrani - aktualizujeme. */
    E->IFD = (struct IntDescriptor *) IFD;

  E->LastSeen = time (NULL);

  return E;
}

void *
DeleteUnusedMACThread (void *Arg)
{
  time_t CurrentTime;
  struct timeval TimeOut;

  for (;;)
    {
      struct BTEntry *I;

      if (pthread_rwlock_wrlock (&TableLock) != 0)
	{
	  fprintf (stderr,
		   "Cannot lock bridging table for writing. Exiting.\n");
	  /* TODO: Upratat. */
	  exit (EXIT_ERROR);
	}


      CurrentTime = time (NULL);

      if (Table != NULL)
	{
	  I = Table->Next;

	  while (I != NULL)
	    {
	      struct BTEntry *NI = I->Next;

	      if ((CurrentTime - I->LastSeen) > MACMAXAGE)
		{
		  EjectBTEntryByItem (Table, I);
		  free (I);
		}

	      I = NI;
	    }
	}

      if (pthread_rwlock_unlock (&TableLock) != 0)
	{
	  fprintf (stderr,
		   "Cannot unlock bridging table after writing. Exiting.\n");
	  /* TODO: Upratat. */
	  exit (EXIT_ERROR);
	}


      TimeOut.tv_sec = 1;
      TimeOut.tv_usec = 0;
      select (0, NULL, NULL, NULL, &TimeOut);
    }
}

void *
AddRefreshMACThread (void *Arg)
{
  fd_set MACSocks;
  int MaxSockNo = 0;

  for (int i = 0; i < IntCount; i++)
    if (Ints[i].MACManSock[1] > MaxSockNo)
      MaxSockNo = Ints[i].MACManSock[1];

  MaxSockNo += 1;

  for (;;)
    {
      FD_ZERO (&MACSocks);
      for (int i = 0; i < IntCount; i++)
	FD_SET (Ints[i].MACManSock[1], &MACSocks);

      select (MaxSockNo, &MACSocks, NULL, NULL, NULL);

      for (int i = 0; i < IntCount; i++)
	if (FD_ISSET (Ints[i].MACManSock[1], &MACSocks))
	  {
	    struct MACAddress Address;

	    memset (&Address, 0, sizeof (struct MACAddress));
	    read (Ints[i].MACManSock[1], &Address,
		  sizeof (struct MACAddress));

	    if (pthread_rwlock_wrlock (&TableLock) != 0)
	      {
		fprintf (stderr,
			 "Cannot lock bridging table for writing. Exiting.\n");
		/* TODO: Upratat. */
		exit (EXIT_ERROR);
	      }

	    UpdateOrAddMACEntry (Table, &Address, &(Ints[i]));

	    if (pthread_rwlock_unlock (&TableLock) != 0)
	      {
		fprintf (stderr,
			 "Cannot unlock bridging table after writing. Exiting.\n");
		/* TODO: Upratat. */
		exit (EXIT_ERROR);
	      }

	  }
    }

}

void
HandleReceivePCAPFrame (u_char * Arg, const struct pcap_pkthdr *PcapHeader,
			const u_char * Frame)
{
  struct BTEntry *E;

  /* Oznamime pridavaciemu/obnovovaciemu vlaknu zdrojovu
     MAC adresu. */
  send (((struct IntDescriptor *) Arg)->MACManSock[0],
	&(((struct EthFrame *) Frame)->Src), sizeof (struct MACAddress),
	MSG_DONTWAIT);

  /* Obsluzime cielovu adresu.  Ak ju nepozname, ramec rozosleme
     vsetkymi ostatnymi rozhraniami okrem vstupneho.  Ak ju
     pozname, ramec odosleme len danym rozhranim, ak je rozne od
     vstupneho.  */

  if (pthread_rwlock_rdlock (&TableLock) != 0)
    {
      fprintf (stderr, "Cannot lock bridging table for reading. Exiting.\n");
      /* TODO: Upratat. */
      exit (EXIT_ERROR);
    }


  if ((E = FindBTEntry (Table, &(((struct EthFrame *) Frame)->Dest))) == NULL)
    {
      for (int j = 0; j < IntCount; j++)
	if (((struct IntDescriptor *) Arg) != &(Ints[j]))
	  pcap_inject (Ints[j].Handle, Frame, PcapHeader->len);
    }
  else if (E->IFD != ((struct IntDescriptor *) Arg))
    pcap_inject (E->IFD->Handle, Frame, PcapHeader->len);

  if (pthread_rwlock_unlock (&TableLock) != 0)
    {
      fprintf (stderr,
	       "Cannot unlock bridging table after reading. Exiting.\n");
      /* TODO: Upratat. */
      exit (EXIT_ERROR);
    }
}

void *
FrameReaderThread (void *Arg)
{
  struct sched_param SchedParam;

  SchedParam.sched_priority = sched_get_priority_max (SCHED_FIFO);
  if (pthread_setschedparam (pthread_self (), SCHED_FIFO, &SchedParam) != 0)
    {
      fprintf (stderr, "Unable to set scheduling method.\n");
    }

  if (pcap_loop
      (((struct IntDescriptor *) Arg)->Handle, -1, HandleReceivePCAPFrame,
       Arg) < 0)
    {
      pcap_perror (((struct IntDescriptor *) Arg)->Handle, "pcap_loop");
      exit (EXIT_ERROR);
    }

  pthread_exit (NULL);
}

int
main (int argc, char *argv[])
{

  pthread_t ThreadID;

  /* Kontrola poctu argumentov pri spusteni programu. */
  if ((argc > MAXINTERFACES) || (argc == 1))
    {
      fprintf (stderr, "Usage: %s IF1 IF2 ... IF%d\n\n",
	       argv[0], MAXINTERFACES);

      exit (EXIT_ERROR);
    }

  IntCount = argc - 1;

  /* Inicializacia pola s popisovacmi rozhrani. */
  memset (Ints, 0, sizeof (Ints));

  /*
   * V cykle sa postupne pre kazde rozhranie vybavia tri klucove
   * zalezitosti: otvorime socket typu AF_PACKET pre vsetky ramce, zviazeme
   * ho s prislusnym rozhranim a rozhranie presunieme do promiskuitneho
   * rezimu.
   *
   */

  for (int i = 1; i < argc; i++)
    {
      char ErrorMsg[PCAP_ERRBUF_SIZE];

      memset (ErrorMsg, '\0', PCAP_ERRBUF_SIZE);

      /* Prekopirujeme meno rozhrania do popisovaca rozhrania. */
      strcpy (Ints[i - 1].Name, argv[i]);

      if ((Ints[i - 1].Handle =
	   pcap_open_live (argv[i], 65535, 1, 0, ErrorMsg)) == NULL)
	{
	  fprintf (stderr, "%s\n", ErrorMsg);
	  exit (EXIT_ERROR);
	}


      if (socketpair (AF_LOCAL, SOCK_DGRAM, 0, Ints[i - 1].MACManSock) == -1)
	{
	  perror ("socketpair");
	  /* TODO: Upratat. */
	  exit (EXIT_ERROR);
	}
    }

  /* Vytvorime prepinaciu tabulku zalozenim jej prveho riadku. */
  Table = CreateBTEntry ();
  if (Table == NULL)
    {
      perror ("malloc");
      /* TODO: Zavriet sockety */
      exit (EXIT_ERROR);
    }

  pthread_create (&ThreadID, NULL, AddRefreshMACThread, NULL);
  pthread_create (&ThreadID, NULL, DeleteUnusedMACThread, NULL);
  for (int i = 0; i < IntCount; i++)
    {
      pthread_create (&ThreadID, NULL, FrameReaderThread, &(Ints[i]));
    }

  (void) getchar ();

  return 0;
}
