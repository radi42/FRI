
/*
 * arp request posielanie 
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/socket.h>
#include <linux/if_packet.h>
#include <net/ethernet.h>
#include <arpa/inet.h>
#include <net/if.h>

#include <string.h>

#define EXIT_ERROR (1)
#define INTERFACE "eth0"

struct EthFrame{
    unsigned char DstMAC[6];
    unsigned char SrcMAC[6];
    unsigned short EthTYPE;
    char Payload[46];
} __attribute__ ((packed));

struct Arp{
    unsigned short HwType;         //= htons(0x0001); Ethernet
    unsigned short PType;          // = htons(0x0800); IP
    unsigned char HwSize;
    unsigned char PSize;
    unsigned short OperCode;       //= h tons(0x0001); //Request
    unsigned char SndMAC[6];
    unsigned char SndIP[4];
    unsigned char TrgMAC[6];
    unsigned char TrgIP[4];
} __attribute__ ((packed));

int main(void) {
    int Socket;
    struct sockaddr_ll Addr;
    struct EthFrame MyFrame;
    struct Arp MyARP;
    
    Socket = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
    
    if(Socket == -1)
    {
        perror("Socket");
        exit(EXIT_ERROR);
    }
    
    memset(&Addr,0,sizeof(Addr));
    
    Addr.sll_family=AF_PACKET;
    Addr.sll_protocol=htons(ETH_P_ALL);
    Addr.sll_ifindex=if_nametoindex(INTERFACE);
    
    if(Addr.sll_ifindex==0){
        perror("If_nametoindex");
        close(Socket);
        exit(EXIT_ERROR);
    }
    
    if(bind(Socket,(struct sockaddr *)&Addr,sizeof(Addr))==-1){
        perror("Bind");
        close(Socket);
        exit(EXIT_ERROR);
    }   
      
    /*Frame*/
    memset(&MyFrame,0,sizeof(MyFrame));    
    memset(&MyFrame,0xFF,6);        
    MyFrame.SrcMAC[0]=0x02;  
    MyFrame.SrcMAC[5]=1;    
    MyFrame.EthTYPE=htons(0x0806);
    
    /*ARP Data - constants*/
    MyARP.HwType=htons(0x0001);
    MyARP.PType=htons(0x0800);
    MyARP.HwSize=6;
    MyARP.PSize=4;
    MyARP.OperCode=htons(0x01);
    MyARP.TrgIP[0]=255;
    MyARP.TrgIP[1]=255;
    MyARP.TrgIP[2]=255;
    MyARP.TrgIP[3]=255;
    MyARP.TrgMAC[0]=2;
    MyARP.SndMAC[0]=7;
    MyARP.SndIP[0]=192;
    MyARP.SndIP[1]=168;
    MyARP.SndIP[2]=0;
    MyARP.SndIP[3]=100;
    
    
    memcpy(&(MyFrame.Payload),&(MyARP.HwType),sizeof(MyARP));
    
    if(write (Socket,&MyFrame,sizeof(MyFrame))==-1){
        perror("Write");
        close(Socket);
        exit(EXIT_ERROR);
    }   
    
    close(Socket);
    return (EXIT_SUCCESS);
}
