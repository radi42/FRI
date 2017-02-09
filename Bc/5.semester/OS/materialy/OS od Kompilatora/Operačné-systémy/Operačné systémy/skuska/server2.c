#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>
#include <pthread.h>
#include <stdlib.h>
#include <math.h>

pthread_t vlakno;
pthread_t spagatik;
char buffer [512];
char bubu[1];
int pole[1000];

int jePrv(int cislo)
{
 int odmocnina=sqrt(cislo);
 int index=0;
 int cis;
 for(index=0;index<1000;index++)
      {if(pole[index]!=0)
        {cis=pole[index];
         if(cis<=odmocnina)
         {
          if((cislo % pole[index])==0) return 0;  
          }                      
         }
      }
   return 1;
}

void prvocislo()
{
 int o;
 for(o=0;o<1000;o++)
 {pole[o]=0;}
 pole[0]=2;
 pole[1]=3;
 int ukazovatel=1;
 int je;
 int i;
  for(i=5;i<8000;i=i+2)
    {
     je=jePrv(i);
     if(je==1)
     {
     if(ukazovatel<999)
     {
      ukazovatel++;
      pole[ukazovatel]=i;
      //printf("%d  ",pole[ukazovatel]);
      }       
     }
    }
}


void *vypocitaj()
{
printf("druhe vlakno");
 prvocislo();
 pthread_exit((void*)0);
}






void *pracuj(arg)
{
printf("Spustilo sa vlakno");
int mysocfd = (int)arg;
int n;
int skus;
int vrat;

char hlava[256]="HTTP/1.1 200 OK \nConnection: close\nServer: SimpleHttp \nContent-Type: text/html\n\n";
char telo[256]="<html><head></head><body>sadasdsa</body></html>";

n=read(mysocfd, buffer, 255); 
     if (n < 0) perror("CHYBA pri citani zo schranky "); 
     printf("Sprava: %s\n", buffer);
//skus=atoi(buffer);
//skus=skus-1;
//pthread_create(&spagatik,NULL,&vypocitaj,NULL);
//usleep ( 50000 ) ;
//vrat=pole[skus];
//sprintf(buffer,"%d",vrat);
//printf("Zadaj spravu:\n");
//scanf("%s",buffer);
//n=write(mysocfd,"HTTP/1.1 200 OK\n\n",30);
n=write(mysocfd,telo, 512); 
    if (n < 0) perror("CHYBA pri zapisu do schranky"); 
close(mysocfd);
pthread_exit((void*)0);
}


int main(int argc, char *argv[])
{
 int sockfd, newsockfd, portno, clilen;

 struct sockaddr_in serv_addr, cli_addr;
 int n;
 if (argc<2){
     fprintf(stderr,"CHYBA CISLO PORTU\n");
     return 1;
 }
 
 sockfd= socket(PF_INET, SOCK_STREAM, 0);
 if(sockfd<0)
   perror("CHYBA SCHRANKA");

memset( &serv_addr,0, sizeof(serv_addr)); 
     portno = atoi(argv[1]); 

serv_addr.sin_family = PF_INET; 
     serv_addr.sin_addr.s_addr = INADDR_ANY; 
     serv_addr.sin_port = htons(portno); 

if (bind(sockfd, (struct sockaddr *) &serv_addr, 
                               sizeof(serv_addr)) < 0) 
              perror("CHYBA pri bind");

listen(sockfd,5); 


   for(;;){
     clilen = sizeof(cli_addr); 
     newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, 
                        &clilen); 
     if (newsockfd < 0) 
          perror("CHYBA pri accept"); 
     memset(&buffer, 0, 512); 
     pthread_create(&vlakno,NULL,&pracuj,newsockfd);
    
     }
return (0); 
}