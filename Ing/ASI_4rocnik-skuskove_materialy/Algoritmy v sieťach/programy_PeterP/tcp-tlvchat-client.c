#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <pthread.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <sys/select.h>

#include <netinet/in.h>
#include <netinet/tcp.h>

#include <arpa/inet.h>

#define		EXIT_ERROR		(1)
#define		MAXLINELENGTH		(256)
#define		TCP_PORT		(1234)
#define		SERVER_ADDR		"127.0.0.1"

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

#define		CMD_NICK		"nick"
#define		CMD_LIST		"list"
#define		CMD_PRIV		"priv"
#define		CMD_BYE			"bye"

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

void *
NetReadThread (void *Arg)
{
  struct TLV *M;
  int Socket = *((int *) Arg);

  M = (struct TLV *) malloc (MAXTLVSIZE);
  //TODO: Osetrit chybu

  for (;;)
    {
      ReadTLV (Socket, M);

      switch (ntohs (M->Type))
	{
	case M_MSG:
	  if (ntohs (M->Length) != (strlen (M->Value) + 1))
	    {
	      fprintf (stderr, "\nBad M_MSG TLV\n");
	      break;
	    }
	  printf (": %s", M->Value);
	  break;

	case M_NICK:
	  if (ntohs (M->Length) != (strlen (M->Value) + 1))
	    {
	      fprintf (stderr, "\nBad M_NICK TLV\n");
	      break;
	    }
	  printf ("\n%s", M->Value);
	  break;
	}
    }
}

int
main (void)
{
  int Socket;
  struct sockaddr_in ServerAddr;
  pthread_t NetReadThreadID;
  struct TLV *M;

  if ((Socket = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
      perror ("socket");
      exit (EXIT_ERROR);
    }

  memset (&ServerAddr, 0, sizeof (ServerAddr));

  ServerAddr.sin_family = AF_INET;
  ServerAddr.sin_port = htons (TCP_PORT);
  if (inet_aton (SERVER_ADDR, &ServerAddr.sin_addr) == 0)
    {
      fprintf (stderr, "%s is not a valid server address.\n", SERVER_ADDR);
      close (Socket);
      exit (EXIT_ERROR);
    }

  if (connect (Socket, (struct sockaddr *) &ServerAddr, sizeof (ServerAddr))
      == -1)
    {
      perror ("connect");
      close (Socket);
      exit (EXIT_ERROR);
    }

  pthread_create (&NetReadThreadID, NULL, NetReadThread, &Socket);
  if ((M =
       (struct TLV *) malloc (sizeof (struct TLV) + MAXLINELENGTH)) == NULL)
    {
      perror ("malloc");
      close (Socket);
      exit (EXIT_ERROR);
    }

  memset (M, 0, sizeof (struct TLV) + MAXLINELENGTH);
  M->Type = htons (M_MSG);

  for (;;)
    {
      char InputLine[MAXLINELENGTH];

      memset (InputLine, '\0', MAXLINELENGTH);
      fgets (InputLine, MAXLINELENGTH, stdin);
      if (InputLine[0] == '/')
	{
	  char Command[MAXLINELENGTH];
	  char Args[MAXLINELENGTH];

	  memset (Command, '\0', MAXLINELENGTH);
	  memset (Args, '\0', MAXLINELENGTH);
	  sscanf (InputLine + 1, "%s", Command);

	  if (strncmp (Command, CMD_NICK, strlen (CMD_NICK)) == 0)
	    {
	      struct TLV *M_Nick;

	      sscanf (InputLine + strlen (CMD_NICK), "%s", Args);

	      M_Nick =
		(struct TLV *) malloc (sizeof (struct TLV) + strlen (Args) +
				       1);
	      //TODO: Osetrit chybu

	      M_Nick->Type = htons (M_NICK);
	      M_Nick->Length = htons (strlen (Args) + 1);
	      strncpy (M_Nick->Value, Args, ntohs (M_Nick->Length));

	      write (Socket, M_Nick,
		     ntohs (M_Nick->Length) + sizeof (struct TLV));
	      free (M_Nick);
	      continue;
	    }

	  if (strncmp (Command, CMD_LIST, strlen (CMD_LIST)) == 0)
	    {
	      struct TLV *M_List;

	      M_List = (struct TLV *) malloc (sizeof (struct TLV));
	      //TODO: Osetrit chybu

	      M_List->Type = htons (M_GETUSERS);
	      M_List->Length = htons (0);
	      write (Socket, M_List, sizeof (struct TLV));
	      free (M_List);
	      continue;
	    }

	  if (strncmp (Command, CMD_PRIV, strlen (CMD_PRIV)) == 0)
	    {
	      continue;
	    }

	  if (strncmp (Command, CMD_BYE, strlen (CMD_BYE)) == 0)
	    {
	      pthread_cancel (NetReadThreadID);
	      pthread_join (NetReadThreadID, NULL);
	      close (Socket);
	      free (M);
	      exit (EXIT_SUCCESS);
	    }

	  fprintf (stderr, "%s: Unknown command\n", Command);
	  continue;
	}

      memset (M->Value, '\0', strlen (InputLine) + 1);
      M->Length = htons (strlen (InputLine) + 1);

      write (Socket, M, sizeof (struct TLV) + ntohs (M->Length));

    }

}
