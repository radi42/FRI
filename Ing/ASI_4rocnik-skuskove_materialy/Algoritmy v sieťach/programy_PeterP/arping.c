#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>

#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>
#include <net/if.h>

struct EthHeader
{
  unsigned char Dst[6];
  unsigned char Src[6];
  unsigned short TID;
  unsigned short VID;
  unsigned short EType;
  char Payload[0];
} __attribute__ ((packed));

struct ARPMessage
{
  unsigned short HwType;
  unsigned short ProtoType;
  unsigned char HwSize;
  unsigned char ProtoSize;
  unsigned short Opcode;
  unsigned char SMac[6];
  unsigned char SIP[4];
  unsigned char TMac[6];
  unsigned char TIP[4];
} __attribute__ ((packed));

#define		MYIP		"158.193.139.235"
#define		MYMAC		"a0:88:b4:71:3b:38"
#define		IFACE		"wlan0"
#define		ETHTYPE_VLAN	(0x8100)
#define		VLAN		(1234)


#define		ETHTYPE_ARP	(0x0806)
#define		HWTYPE_ETH	(1)
#define		PROTOTYPE_IP	(0x0800)
#define		HWSIZE_ETH	(6)
#define		PROTOSIZE_IP	(4)
#define		OPCODE_REQ	(1)
#define		OPCODE_RESP	(2)

#define		EXIT_ERROR	(1)
#define		SLEEPTIME	(1)

#define		MAX(x,y)	((x)>(y)?(x):(y))


int Sock;

void *
PrintResponses (void * Arg)
{
  struct EthHeader *Response = NULL;

  Response = (struct EthHeader *) malloc (sizeof (struct EthHeader) + sizeof (struct ARPMessage));
  
  if (Response == NULL) {
    perror ("malloc");
    close (Sock);
    exit (EXIT_ERROR);
  }
  
  for (;;) {
    struct ARPMessage * ARPResp = (struct ARPMessage *) Response->Payload;
    
    memset (Response, 0, sizeof (struct EthHeader) + sizeof (struct ARPMessage));
    read (Sock, Response, sizeof (struct EthHeader) + sizeof (struct ARPMessage));
    
    if (ntohs (ARPResp->Opcode) != OPCODE_RESP)
      continue;
    
    if (memcmp (ARPResp->SIP, (unsigned char *) Arg /*ARPReq->TIP*/, PROTOSIZE_IP) != 0)
      continue;
    
    printf ("Response from %hhu.%hhu.%hhu.%hhu @ %02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx\n",
            *(ARPResp->SIP),
            *(ARPResp->SIP+1),
            *(ARPResp->SIP+2),
            *(ARPResp->SIP+3),
            *(ARPResp->SMac),
            *(ARPResp->SMac+1),
            *(ARPResp->SMac+2),
            *(ARPResp->SMac+3),
            *(ARPResp->SMac+4),
            *(ARPResp->SMac+5));
  }
  
  return NULL;
}

int
main (int argc, char *argv[])
{
  struct EthHeader *Packet = NULL;
  struct ARPMessage *ARPReq = NULL;
  int PacketSize;
  struct sockaddr_ll SA;
  pthread_t ReaderThreadID;

  if (argc != 2)
    {
      fprintf (stderr, "Usage: %s <IP>\n\n", argv[0]);
      exit (EXIT_ERROR);
    }

  Sock = socket (AF_PACKET, SOCK_RAW, htons (ETHTYPE_ARP));

  if (Sock == -1)
    {
      perror ("socket");
      exit (EXIT_ERROR);
    }

  memset (&SA, 0, sizeof (SA));

  SA.sll_family = AF_PACKET;
  SA.sll_protocol = htons (ETHTYPE_ARP);
  SA.sll_ifindex = if_nametoindex (IFACE);

  if (SA.sll_ifindex == 0)
    {
      perror ("if_nametoindex");
      close (Sock);
      exit (EXIT_ERROR);
    }

  if (bind (Sock, (struct sockaddr *) &SA, sizeof (SA)) == -1)
    {
      perror ("bind");
      close (Sock);
      exit (EXIT_ERROR);
    }

  PacketSize =
    MAX (60, sizeof (struct EthHeader) + sizeof (struct ARPMessage));

  Packet = (struct EthHeader *) malloc (PacketSize);
  if (Packet == NULL)
    {
      perror ("malloc");
      close (Sock);
      exit (EXIT_ERROR);
    }

  memset (Packet, 0, PacketSize);

  memset (Packet->Dst, 0xFF, sizeof (Packet->Dst));
  sscanf (MYMAC, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
	  Packet->Src,
	  Packet->Src + 1,
	  Packet->Src + 2, Packet->Src + 3, Packet->Src + 4, Packet->Src + 5);
  Packet->EType = htons (ETHTYPE_ARP);
  ARPReq = (struct ARPMessage *) Packet->Payload;
  
  Packet->TID = htons (ETHTYPE_VLAN);
  Packet->VID = htons (VLAN);

  ARPReq->HwType = htons (HWTYPE_ETH);
  ARPReq->ProtoType = htons (PROTOTYPE_IP);
  ARPReq->HwSize = HWSIZE_ETH;
  ARPReq->ProtoSize = PROTOSIZE_IP;
  ARPReq->Opcode = htons (OPCODE_REQ);
  memcpy (ARPReq->SMac, Packet->Src, sizeof (ARPReq->SMac));
  sscanf (MYIP, "%hhd.%hhd.%hhd.%hhd",
	  ARPReq->SIP, ARPReq->SIP + 1, ARPReq->SIP + 2, ARPReq->SIP + 3);

  if (sscanf (argv[1], "%hhd.%hhd.%hhd.%hhd",
	      ARPReq->TIP, ARPReq->TIP + 1, ARPReq->TIP + 2, ARPReq->TIP + 3) < 4)
    {
      fprintf (stderr,
	       "%s does not seem to be a valid IP address. Exiting.\n\n",
	       argv[1]);
      close (Sock);
      free (Packet);
      exit (EXIT_ERROR);
    }

  if (pthread_create (&ReaderThreadID, NULL, PrintResponses, ARPReq->TIP) != 0) {
    perror ("pthread_create");
    close (Sock);
    free (Packet);
    exit (EXIT_ERROR);
  }

  for (;;) {

    if (write (Sock, Packet, PacketSize) == -1)
      {
        perror ("write");
        close (Sock);
        free (Packet);
        exit (EXIT_ERROR);
      }
      
    sleep (SLEEPTIME);
  }

  close (Sock);
  free (Packet);

  exit (EXIT_SUCCESS);
}
