#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <stdlib.h>
#include <time.h>

#include <sys/select.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <arpa/inet.h>

#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>

#define		MACSIZE		6
#define		MTU		1500
#define		MAXINTERFACES	8
#define		EXIT_ERROR	1

/*
 * Struktura IntDescriptor uchovava informacie o sietovom rozhrani, ktore
 * nas bridge obsluhuje - meno rozhrania, jeho cislo v Linuxe, a socket,
 * ktorym na tomto rozhrani citame a odosielame ramce.
 *
 */

struct IntDescriptor
{
  char Name[IFNAMSIZ];
  unsigned int IntNo;
  int Socket;
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

/*
 * Funkcia sluziaca na vynatie riadku z tabulky.  Riadok nebude dealokovany
 * z pamate, bude len odstraneny z tabulky.  Vyhladava sa podla MAC adresy.
 *
 */

struct BTEntry *
EjectBTEntry (struct BTEntry *Head, const struct MACAddress *Address)
{
  struct BTEntry *E;

  if (Head == NULL)
    return NULL;

  if (Address == NULL)
    return NULL;

  E = FindBTEntry (Head, Address);
  if (E == NULL)
    return NULL;

  (E->Previous)->Next = E->Next;
  if (E->Next != NULL)
    (E->Next)->Previous = E->Previous;

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

  E = EjectBTEntry (Head, Address);
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

int
main (int argc, char *argv[])
{
  struct IntDescriptor Ints[MAXINTERFACES];
  int MaxSockNo = 0;
  struct BTEntry *Table = NULL;

  /* Kontrola poctu argumentov pri spusteni programu. */
  if ((argc > MAXINTERFACES) || (argc == 1))
    {
      fprintf (stderr, "Usage: %s IF1 IF2 ... IF%d\n\n",
	       argv[0], MAXINTERFACES);

      exit (EXIT_ERROR);
    }

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
      struct ifreq IFR;
      struct sockaddr_ll SA;

      /* Prekopirujeme meno rozhrania do popisovaca rozhrania. */
      strcpy (Ints[i - 1].Name, argv[i]);

      /* Konvertujeme meno rozhrania na index a ulozime do popisovaca. */
      Ints[i - 1].IntNo = if_nametoindex (argv[i]);
      if (Ints[i - 1].IntNo == 0)
	{
	  perror ("if_nametoindex");
	  exit (EXIT_ERROR);
	}

      /* Pre dane rozhranie vyplnime strukturu sockaddr_ll potrebnu
         pre bind() */
      memset (&SA, 0, sizeof (struct sockaddr_ll));
      SA.sll_family = AF_PACKET;
      SA.sll_protocol = htons (ETH_P_ALL);
      SA.sll_ifindex = Ints[i - 1].IntNo;

      /* Vytvorime socket typu AF_PACKET. */
      Ints[i - 1].Socket = socket (AF_PACKET, SOCK_RAW, htons (ETH_P_ALL));
      if (Ints[i - 1].Socket == -1)
	{
	  perror ("socket");
	  /* TODO: Zavriet predchadzajuce sockety */
	  exit (EXIT_ERROR);
	}

      /* Odkladame si maximalne cislo socketu pre neskorsi select(). */
      if (Ints[i - 1].Socket > MaxSockNo)
	MaxSockNo = Ints[i - 1].Socket;

      /* Zviazeme socket s rozhranim. */
      if (bind
	  (Ints[i - 1].Socket, (struct sockaddr *) &SA,
	   sizeof (struct sockaddr_ll)) == -1)
	{
	  perror ("bind");
	  /* TODO: Zavriet predchadzajuce sockety */
	  exit (EXIT_ERROR);
	}

      /* Priprava pre promiskuitny rezim.  Najprv ziskame sucasne priznaky
         rozhrania. */
      memset (&IFR, 0, sizeof (struct ifreq));
      strcpy (IFR.ifr_name, argv[i]);
      if (ioctl (Ints[i - 1].Socket, SIOCGIFFLAGS, &IFR) == -1)
	{
	  perror ("ioctl get flags");
	  exit (EXIT_ERROR);
	}

      /* K priznakom pridame priznak IFF_PROMISC. */
      IFR.ifr_flags |= IFF_PROMISC;

      /* Nastavime nove priznaky rozhrania. */
      if (ioctl (Ints[i - 1].Socket, SIOCSIFFLAGS, &IFR) == -1)
	{
	  perror ("ioctl set flags");
	  exit (EXIT_ERROR);
	}
    }

  /* Najvyssie cislo socketu zvysime o 1, ako pozaduje select() */
  MaxSockNo += 1;

  /* Vytvorime prepinaciu tabulku zalozenim jej prveho riadku. */
  Table = CreateBTEntry ();
  if (Table == NULL)
    {
      perror ("malloc");
      /* TODO: Zavriet sockety */
      exit (EXIT_ERROR);
    }

  /*
   * Hlavna cast programu.  V nekonecnej slucke program caka na udalost na
   * niektorom zo sledovanych socketov.  Po zisteni, ze nejaka udalost
   * nastala, program zisti, na ktorom sockete, potom z daneho socketu
   * nacita ramec, vyhlada a pripadne prida adresu odosielatela do tabulky,
   * vyhlada adresu prijemcu a odosle ramec - bud len danym rozhranim (nikdy
   * vsak nie vstupnym), alebo vsetkymi ostatnymi.
   *
   */
  for (;;)
    {
      fd_set FDs;

      /* Do mnoziny FDs pridame vsetky sockety. */
      FD_ZERO (&FDs);
      for (int i = 0; i < argc - 1; i++)
	FD_SET (Ints[i].Socket, &FDs);

      /* Nad tymito socketmi cakame na udalost. */
      select (MaxSockNo, &FDs, NULL, NULL, NULL);

      /* Ak udalost nastala, zistime, na ktorom sockete... */
      for (int i = 0; i < argc - 1; i++)
	if (FD_ISSET (Ints[i].Socket, &FDs))
	  {
	    /* ... a ideme ju obsluzit. */
	    struct EthFrame Frame;
	    int FrameLength;
	    struct BTEntry *E;

	    /* Nacitame ramec, maximalne do dlzky MTU. */
	    FrameLength =
	      read (Ints[i].Socket, &Frame, MTU + sizeof (struct EthFrame));

	    /* Obsluzime zdrojovu adresu.  Bud ju uz pozname, a v takom
	       pripade musime aktualizovat udaj o case, kedy sme ju
	       naposledy pouzili (prave teraz), pripadne aj vstupny
	       interfejs, alebo ju nepozname, a v takom pripade ju musime
	       pridat.  */
	    E = UpdateOrAddMACEntry (Table, &(Frame.Src), &(Ints[i]));

	    /* Obsluzime cielovu adresu.  Ak ju nepozname, ramec rozosleme
	       vsetkymi ostatnymi rozhraniami okrem vstupneho.  Ak ju
	       pozname, ramec odosleme len danym rozhranim, ak je rozne od
	       vstupneho.  */
	    if ((E = FindBTEntry (Table, &(Frame.Dest))) == NULL)
	      {
		for (int j = 0; j < argc - 1; j++)
		  if (i != j)
		    write (Ints[j].Socket, &Frame, FrameLength);
	      }
	    else if (E->IFD != &(Ints[i]))
	      write (E->IFD->Socket, &Frame, FrameLength);

	  }

    }


  return 0;
}
