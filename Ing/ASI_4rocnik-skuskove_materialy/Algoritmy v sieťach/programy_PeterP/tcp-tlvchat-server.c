#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>

#include <netinet/in.h>
#include <netinet/tcp.h>

#include <arpa/inet.h>

#define		EXIT_ERROR		(1)
#define		MAXCLIENTS		(100)
#define		MAXLINELENGTH		(256)
#define		TCP_PORT		(1234)
#define		BACKLOG			(10)

#define		MAXTLVSIZE		(65539)
#define		MAXNICKLEN		(32)

#define		ERR_MEM			(0x00000001)
#define		ERR_READ		(0x00000002)
#define		ERR_DISC		(0x00000003)
#define		ERR_MALFORMED		(0x00000004)

#define		M_SETNAME		(0x0001)
#define		M_GETUSERS		(0x0002)
#define		M_BYE			(0x0003)
#define		M_PRIVATEMSG		(0x0004)
#define		M_MSG			(0x0005)
#define		M_NICK			(0x0006)

struct TLV
{
  unsigned short Type;
  unsigned short Length;
  char Value[0];
} __attribute__ ((packed));

struct ClientInfo
{
  int S;
  char Nick[MAXNICKLEN];
};

int
ReadBytes (int Socket, char *M, int Count)
{
  int BytesRead = 0;

  while (BytesRead < Count)
    {
      int ByteCount;

      ByteCount = read (Socket, M + BytesRead, Count - BytesRead);

      if (ByteCount == -1)
	{
	  if (errno == EINTR)
	    continue;
	  else
	    {
	      perror ("ReadBytes read");
	      return -ERR_READ;
	    }
	}

      if (ByteCount == 0)
	{
	  return -ERR_DISC;
	}

      BytesRead += ByteCount;
    }
  return BytesRead;
}


int
ReadTLV (int Socket, struct TLV *M)
{
  int BytesRead = 0;

  if (M == NULL)
    {
      return -ERR_MEM;
    }

  memset (M, 0, MAXTLVSIZE);

  BytesRead = ReadBytes (Socket, (char *) M, sizeof (struct TLV));
  if (BytesRead < 0)
    {
      return BytesRead;
    }

  BytesRead = ReadBytes (Socket, M->Value, ntohs (M->Length));
  if (BytesRead < 0)
    {
      return BytesRead;
    }

  return 0;
}

int
HandleSetName (struct ClientInfo *Info, struct TLV *M)
{
  if (ntohs (M->Length) > MAXNICKLEN)
    {
      socklen_t SockLen = sizeof (struct sockaddr_in);
      struct sockaddr_in ClientAddr;

      memset (&ClientAddr, 0, SockLen);
      getpeername (Info->S, (struct sockaddr *) &ClientAddr, &SockLen);

      fprintf (stderr, "Client %s:%hu sent wrong M_SETNAME TLV\n",
	       inet_ntoa (ClientAddr.sin_addr), ntohs (ClientAddr.sin_port));

      return -ERR_MALFORMED;

    }

  memset (Info->Nick, '\0', MAXNICKLEN);
  strncpy (Info->Nick, (char *) M->Value, MAXNICKLEN);
  Info->Nick[MAXNICKLEN - 1] = '\0';

  return 0;
}

int
HandleMessage (struct ClientInfo *Clients, int i, int ClientCount,
	       struct TLV *M)
{
  int BufLen = 2 * sizeof (struct TLV) + strlen
    (Clients[i].Nick) + 1 + ntohs (M->Length);

  struct TLV *I;
  char *Buffer = (char *) malloc (BufLen);
  //TODO: Osetrit chybu

  memset (Buffer, 0, BufLen);

  I = (struct TLV *) Buffer;

  I->Type = htons (M_NICK);
  I->Length = htons (strlen (Clients[i].Nick) + 1);
  strncpy (I->Value, Clients[i].Nick, MAXNICKLEN);

  I = (struct TLV *) (Buffer + sizeof (struct TLV) + ntohs (I->Length));
  memcpy (I, M, sizeof (struct TLV) + ntohs (M->Length));

  for (int j = 0; j < ClientCount; j++)
    {
      write (Clients[j].S, Buffer, BufLen);
      //TODO: Osetrit chybu
    }

  free (Buffer);
  return 0;

}


int
HandleGetUsers (struct ClientInfo *Clients, int i, int ClientCount)
{
  struct TLV *M;

  M = (struct TLV *) malloc (sizeof (struct TLV) + MAXNICKLEN);
  //TODO: Osetrit chybu

  memset (M, 0, sizeof (struct TLV) + MAXNICKLEN);

  M->Type = htons (M_NICK);

  for (int j = 0; j < ClientCount; j++)
    {
      M->Length = htons (strlen (Clients[j].Nick) + 1);
      strncpy (M->Value, Clients[j].Nick, MAXNICKLEN);
      write (Clients[i].S, M, sizeof (struct TLV) + ntohs (M->Length));
      //TODO: Osetrit chybu
    }

  free (M);
  return 0;
}


int
HandlePrivateMessage (struct ClientInfo *Clients, int i, int ClientCount,
		      struct TLV *M)
{
  struct TLV *Nick = NULL;
  struct TLV *PM = NULL;
  struct TLV *I;
  int TotalLength = 0;

  I = (struct TLV *) M->Value;

  while ((((char *) I) - M->Value) < ntohs (M->Length))
    {

      TotalLength += ntohs (I->Length) + sizeof (struct TLV);
      switch (ntohs (I->Type))
	{
	case M_NICK:
	  Nick = I;
	  break;
	case M_MSG:
	  PM = I;
	  break;

	default:
	  return -ERR_MALFORMED;
	}

      I =
	(struct TLV *) (I->Value + ntohs (I->Length));
    }

  if (TotalLength != ntohs (M->Length))
    return -ERR_MALFORMED;

  if ((Nick == NULL) || (PM == NULL))
    return -ERR_MALFORMED;

  for (int j = 0; j < ClientCount; j++)
    {
      if (strncmp (Clients[j].Nick, Nick->Value, MAXNICKLEN) == 0)
	{
	  int BufLen = 2 * sizeof (struct TLV) + strlen
	    (Clients[i].Nick) + 1 + ntohs (M->Length);

	  char *Buffer = (char *) malloc (BufLen);
	  //TODO: Osetrit chybu

	  memset (Buffer, 0, BufLen);
	  I = (struct TLV *) Buffer;
	  I->Type = htons (M_NICK);
	  I->Length = htons (strlen (Clients[i].Nick) + 1);
	  strncpy (I->Value, Clients[i].Nick, MAXNICKLEN);

	  I =
	    (struct TLV *) (Buffer + sizeof (struct TLV) + ntohs (I->Length));
	  memcpy (I, M, sizeof (struct TLV) + ntohs (M->Length));
	  write (Clients[j].S, Buffer, BufLen);
	  //TODO: Osetrit chybu
	  free (Buffer);
	}
    }

  return 0;
}



int
main (void)
{
  int ServerSocket;
  struct ClientInfo Clients[MAXCLIENTS];
  int ClientCount = 0;
  struct sockaddr_in MyAddr;
  if ((ServerSocket = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
      perror ("socket");
      exit (EXIT_ERROR);
    }

  memset (&MyAddr, 0, sizeof (MyAddr));
  MyAddr.sin_family = AF_INET;
  MyAddr.sin_port = htons (TCP_PORT);
  MyAddr.sin_addr.s_addr = INADDR_ANY;
  if (bind (ServerSocket, (struct sockaddr *) &MyAddr, sizeof (MyAddr)) == -1)
    {
      perror ("bind");
      close (ServerSocket);
      exit (EXIT_ERROR);
    }

  if (listen (ServerSocket, BACKLOG) == -1)
    {
      perror ("listen");
      close (ServerSocket);
      exit (EXIT_ERROR);
    }

  for (;;)
    {
      int MaxSockNo = 0;
      fd_set FDs;
      FD_ZERO (&FDs);
      FD_SET (ServerSocket, &FDs);
      MaxSockNo = ServerSocket;
      for (int i = 0; i < ClientCount; i++)
	{
	  FD_SET (Clients[i].S, &FDs);
	  if (Clients[i].S > MaxSockNo)
	    MaxSockNo = Clients[i].S;
	}

      if (select (MaxSockNo + 1, &FDs, NULL, NULL, NULL) == -1)
	{
	  perror ("select");
	  close (ServerSocket);
	  for (int i = 0; i < ClientCount; i++)
	    close (Clients[i].S);
	  exit (EXIT_ERROR);
	}

      if (FD_ISSET (ServerSocket, &FDs))
	{
	  int NewClient = accept (ServerSocket, NULL, NULL);
	  /*TODO: Osetrit chybu */
	  if (ClientCount == MAXCLIENTS)
	    close (NewClient);
	  else
	    {
	      Clients[ClientCount].S = NewClient;
	      memset (Clients[ClientCount].Nick, '\0', MAXNICKLEN);
	      ClientCount++;
	    }

	}

      for (int i = 0; i < ClientCount; i++)
	{
	  if (FD_ISSET (Clients[i].S, &FDs))
	    {
	      struct TLV *M;
	      M = (struct TLV *) malloc (MAXTLVSIZE);
	      if (M == NULL)
		{
		  //TODO: Obsluzit chybu
		}

	      ReadTLV (Clients[i].S, M);
	      //TODO: Obsluzit navratovu hodnotu
	      switch (ntohs (M->Type))
		{
		case M_SETNAME:
		  HandleSetName (&Clients[i], M);
		  break;
		case M_GETUSERS:
		  HandleGetUsers (Clients, i, ClientCount);
		  break;
		case M_BYE:
		  close (Clients[i].S);
		  Clients[i] = Clients[ClientCount - 1];
		  ClientCount--;
		  break;
		case M_PRIVATEMSG:
		  HandlePrivateMessage (Clients, i, ClientCount, M);
		  break;
		case M_MSG:
		  HandleMessage (Clients, i, ClientCount, M);
		  break;
		}
	    }

	}
    }
}
