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
char buffer[512];
int pole[5000000];

pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

int jePrv(int cislo)
{
 int odmocnina=sqrt(cislo);
 int index=0;
 int cis;
 for(index=0;index<2237;index++)
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
 pole[0]=2;
 pole[1]=3;
 int ukazovatel=1;
 int je;
 int i;
  for(i=5;i<86028123;i=i+2)
    {
     je=jePrv(i);
     if(je==1)
     {
     if(ukazovatel<4999999)
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
 printf("spustilo sa vlakno na vypocet prvocisel\n");
 prvocislo();
 printf("vlakno sa skoncilo\n");
 pthread_exit((void*)0);
}

void *pracuj(arg)
{
printf("Spustilo sa vlakno\n");
int mysocfd = (int)arg;
int n,skus,vrat;
int index1=0;
int index2=0;

//char hlava[256]="HTTP/1.1 200 OK \nConnection: close\nServer: SimpleHttp \nContent-Type: text/html\n\n";
char * prvy,*druhy;
char to[256];

//char *telo="HTTP/1.1 200 OK\n"
//"Content-Type: text/html\n\n"

//"<HTML><HEAD></HEAD><BODY>Nejlepsi http server.</BODY></HTML>";

char telo[512]="HTTP/1.1 200 OK" "Content-Type: text/html \n\n"
 "<html><head><meta charset=iso-8859-2></head><body>";

n=read(mysocfd, buffer, 512); 
     if (n < 0) perror("CHYBA pri citani zo schranky ");
    
    printf("Sprava: %s\n", buffer);
    prvy=strstr(buffer,"=");
    index1 = prvy-buffer+1;
    printf("index1 %d\n",index1);
     
     
     druhy=strstr(prvy," ");
     index2 = druhy - prvy+1 ;
     printf("index2 %d\n",index2);
    
     int i;
     
    for(i=index1;i<index1+index2-2;i=i+1)
     {
      to[i-index1]=buffer[i];
    }
     skus=atoi(to);
    printf("Ktore prvocislo : %d\n",skus);
if((skus>5000000)||(skus<=0))
{
strcat(telo,"<br> ZLY VSTUP (server vrati prve prvocislo)  <br>");
skus=1;
}    

int pomocna=pole[skus-1];
if(pomocna==0)
{
strcat(telo,"<br>Vase prvocislo sa rata<br>");
}

skus=skus-1;

//usleep ( 50000 ) ;
vrat=pole[skus];

char s[10];
sprintf(s,"%d",skus+1);
char l[10];
sprintf(l,"%d",vrat);

printf("Prvocislo : %d\n",vrat);
strcat(telo,s);
strcat(telo," . Prvocislo : ");
strcat(telo,l);
strcat(telo,"</body></html>");

n=write(mysocfd,telo,strlen(telo)); 
    if (n < 0) perror("CHYBA pri zapisu do schranky"); 
close(mysocfd);
pthread_exit((void*)0);
}
int main(int argc, char *argv[])
{
 int sockfd, newsockfd, portno, clilen;

 pthread_create(&spagatik,NULL,&vypocitaj,NULL);
 
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