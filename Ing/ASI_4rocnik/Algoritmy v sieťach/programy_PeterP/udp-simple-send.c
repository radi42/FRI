#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/udp.h>

#include <arpa/inet.h>


#define		DSTPORT		(1234)
#define		MSGLEN		(576)

#define		EXIT_ERROR	(1)

int
main (int argc, char * argv [])
{
  int Socket;
  struct sockaddr_in DstAddr;
  char Message[MSGLEN];
  const int AllowBroadcast = 1;

  if (argc != 2) {
    fprintf (stderr, "Usage: %s <Destination address>\n\n", argv[0]);
    exit (EXIT_ERROR);
  }

  memset (&DstAddr, 0, sizeof (DstAddr));
  DstAddr.sin_family = AF_INET;
  DstAddr.sin_port = htons (DSTPORT);
  if (inet_aton (argv[1], &(DstAddr.sin_addr)) == 0)
    {
      fprintf (stderr, "inet_aton: String %s is not a valid IPv4 address\n",
	       argv[1]);
      exit (EXIT_ERROR);
    }


  if ((Socket = socket (AF_INET, SOCK_DGRAM, 0)) == -1)
    {
      perror ("socket");
      exit (EXIT_ERROR);
    }


  if (setsockopt (Socket, SOL_SOCKET, SO_BROADCAST, &AllowBroadcast, sizeof (AllowBroadcast)) == -1) {
    perror ("setsockopt");
    close (Socket);
    exit (EXIT_ERROR);
  }

  memset (Message, '\0', MSGLEN);
  printf ("> ");
  fflush (stdout);
  fgets (Message, MSGLEN, stdin);

  if (sendto
      (Socket, Message, strlen (Message) + 1, 0, (struct sockaddr *) &DstAddr,
       sizeof (DstAddr)) == -1)
    {
      perror ("sendto");
    }

  close (Socket);

  exit (EXIT_SUCCESS);

}
