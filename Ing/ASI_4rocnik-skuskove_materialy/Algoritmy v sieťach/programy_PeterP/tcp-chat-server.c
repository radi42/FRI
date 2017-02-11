#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

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

int
main (void)
{
  int ServerSocket;
  FILE *Clients[MAXCLIENTS];
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
	  FD_SET (fileno (Clients[i]), &FDs);
	  if (fileno (Clients[i]) > MaxSockNo)
	    MaxSockNo = fileno (Clients[i]);
	}

      if (select (MaxSockNo + 1, &FDs, NULL, NULL, NULL) == -1)
	{
	  perror ("select");
	  close (ServerSocket);
	  for (int i = 0; i < ClientCount; i++)
	    fclose (Clients[i]);
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
	      Clients[ClientCount] = fdopen (NewClient, "r+");
	      ClientCount++;
	    }

	}

      for (int i = 0; i < ClientCount; i++)
	{
	  if (FD_ISSET (fileno (Clients[i]), &FDs))
	    {
	      char Message[MAXLINELENGTH];
	      memset (Message, '\0', MAXLINELENGTH);

	      if (fgets (Message, MAXLINELENGTH, Clients[i]) == NULL)
		{
		  fclose (Clients[i]);

		  Clients[i] = Clients[ClientCount - 1];
		  ClientCount--;

		  continue;
		}

	      for (int j = 0; j < ClientCount; j++)
		if (i != j)
		  {
		    fputs (Message, Clients[j]);
		    fflush (Clients[j]);
		  }

	    }
	}
    }
}
