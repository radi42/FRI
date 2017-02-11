#include <stdio.h>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <string.h>

/*Definicie*/
#define MAX_CLIENTS 10             //Maximalny pocet klientov
#define START_ID 1                 //Zaciatocne ID 

/*Globalne premenne*/
int cli_count = 0;                 //pocet klientov online
char escsq[8] = "!exit";           //logout
char chname[8]= "!chname ";        //zmena mena
char help[8]="!help";              //help
char rtrnm[8]="!name";             //zobrazenie mena
char actcli[16]="!active";         //aktivny na chate 

/*Struktura klienta*/
typedef struct {
	struct sockaddr_in addr;    //Adresa klienta
	int connfd;		    //Popiska spojenia
	int uid;		    //Id klienta
	char name[32];		    //Meno klienta
} client_t;

/*Vytvorenie pola klientov*/
client_t *clients[MAX_CLIENTS];

/*Vypis erroru s podporov sys. hlasok*/
void error(char *msg)
{
    perror(msg);
    exit(1);
}

/*pridaj klienta do pola*/
void queueAdd(client_t *cl){
	int i;
	for(i=0;i<MAX_CLIENTS;i++){
		if(!clients[i]){
			clients[i] = cl;
			return;
		}
	}
}
 
/*Vymaz clienta z pola*/
void queueDelete(int uid){
	int i;
	for(i=0;i<MAX_CLIENTS;i++){
		if(clients[i]){
			if(clients[i]->uid == uid){
				clients[i] = NULL;
				return;
			}
		}
	}
}

/*Posli spravu vsetkym*/
void sendAll(char *message, int uid)
{
  int n;
  for(int i = 0 ; i < MAX_CLIENTS ; i++ )
  {
    if(clients[i]){
      if(clients[i]->uid!=uid){
            n = write(clients[i]->connfd,message,strlen(message));
            if (n < 0) error("ERROR writing to socket");  
      }
    }
  }
}
/*Posli spravu sebe*/
void sendSelf(const char *s, int connfd){
	write(connfd, s, strlen(s));
}

/*Posli spravu vsetkym okrem seba*/
void sendMessage(char *s, int uid){
	int i;
	for(i=0;i<MAX_CLIENTS;i++){
		if(clients[i]){
			if(clients[i]->uid != uid){
				write(clients[i]->connfd, s, strlen(s));
                        }
		}
	}
}

/*Poslanie zoznamu aktivnych klientov*/
void sendActiveClients(int connfd){
	int i;
	char s[64];
	for(i=0;i<MAX_CLIENTS;i++){
		if(clients[i]){
			sprintf(s, "Uzivatel %d | %s\r", clients[i]->uid, clients[i]->name);
			sendSelf(s, connfd);
		}
	}
}

/*Funkcia serveClient pre obsluhu*/
void serveClient (void *arg)
{
   int n;
   char buffer_in[1024];
   char buffer_out[1024];
   char *prikaz; 
   
   /*Zvysenie poctu klientov a vytvorenie fiktivneho klienta*/
   cli_count++;
   client_t *cli = (client_t *)arg;
   
   sprintf(buffer_out, "Vase ID je %s.\r\nMozte pisat spravy.\n\n", cli->name);
   write(cli->connfd, buffer_out, strlen(buffer_out));
   
   sprintf(buffer_out, "Uzivatel s ID %d sa prihlasil.\n",cli->uid);
   sendAll(buffer_out,cli->uid);
   
   while((n = read(cli->connfd, buffer_in, sizeof(buffer_in)-1)) > 0){
         /*Zmazanie bufferov*/
         bzero(buffer_out,1024);
 
	/* Ignoruj prazdny buffer*/
	if(!strlen(buffer_in)){
	   continue;
           }
         
	if(buffer_in[0] == '!'){
          prikaz = strtok(buffer_in,"\n");
          
            /*Vystupenie z chatu*/   
            if(strncmp(prikaz,escsq,5)==0){
              sendSelf("exit\n",cli->connfd);
              break;
            }
      
            /*Zmena mena*/
            else if(strncmp(prikaz,chname,8)==0)
            {
                sprintf(cli->name,"%s",(&(buffer_in[8])));
                sprintf(buffer_out,"Vas novy nick je: %s\n",(&(buffer_in[8])));
                sendSelf(buffer_out,cli->connfd);
            }
          
            /*Help*/
            else if(strncmp(prikaz,help,5)==0)
            { 
                strcat(buffer_out,"***********HELP***********\r\n");
                strcat(buffer_out,"!name - vase meno na chate\n");
                strcat(buffer_out,"!active - aktivni pouzivatelia\n");
                strcat(buffer_out,"!chname <meno> - zmena mena\n");             
                strcat(buffer_out,"!help - vyvolanie tohto pomocnika\n");
                strcat(buffer_out,"!exit - odhlasenie sa\n");
                write(cli->connfd, buffer_out,512);
            }
          
            /*Vratenie zoznamu klientov*/
            else if(strncmp(buffer_in,actcli,7)==0)
            { 
                sendActiveClients(cli->connfd)  ;
            }
          
            /*Vratenie mena klienta*/
             else if(strncmp(buffer_in,rtrnm,5)==0)
            {
               sprintf(buffer_out,"Vas nick je: %s\n",cli->name);
               sendSelf(buffer_out,cli->connfd);
            }
        
            /*Neznamy prikaz*/
            else{        
                 sendSelf("Neznamy prikaz\n",cli->connfd);   
            }
        }else
         {
            sprintf(buffer_out,"%s: %s",cli->name,buffer_in);
            sendMessage(buffer_out,cli->uid);
         }
         bzero(buffer_in,1024);
   }
   close(cli->connfd);
   printf("Uzivatel %s s ID %d sa odhlasil.\n",cli->name,cli->uid);
   sprintf(buffer_out, "Uzivatel %s s ID %d sa odhlasil.\n",cli->name,cli->uid);
   sendAll(buffer_out,cli->uid);
   queueDelete(cli->uid);   
   free(cli);
   cli_count--;
   pthread_detach(pthread_self());
}


int main(int argc, char *argv[])
{
    /*Lokalne premenne*/
     int sockfd, newsockfd, portno, clilen, pid, uid=START_ID;
     struct sockaddr_in serv_addr, cli_addr;
     
     /*Kontrola dostatku argumentov*/
     if (argc < 2) {
         fprintf(stderr,"ERROR, no port provided\n");
         exit(1);
     }
     /*Nastavenie soketov*/
     sockfd = socket(AF_INET, SOCK_STREAM, 0);
     if (sockfd < 0) 
        error("ERROR opening socket");
     bzero((char *) &serv_addr, sizeof(serv_addr));
     portno = atoi(argv[1]);
     serv_addr.sin_family = AF_INET;
     serv_addr.sin_addr.s_addr = INADDR_ANY;
     serv_addr.sin_port = htons(portno);
     
     /*Bind*/
     if (bind(sockfd, (struct sockaddr *) &serv_addr,
              sizeof(serv_addr)) < 0) 
              error("ERROR on binding");
     
     /*Listen*/
     if(listen(sockfd,5)<0){
         error("ERROR on listening");
        return 0;
        }     
     printf("Server spusteny...\n\n");
     while (1) {
         clilen = sizeof(cli_addr);
         newsockfd = accept(sockfd,(struct sockaddr *) &cli_addr, &clilen);
         if (newsockfd < 0) 
             error("ERROR on accept");
         
         /* Kontrola poctu klientov */
	 if((cli_count+1) == MAX_CLIENTS){
	    printf("DOSIAHNUTY MAXIMALNY POCET KLIENTOV\n");
	    close(newsockfd);
	    continue;
	  }
 
	/*Nastavenie klienta */
	client_t *cli = (client_t *)malloc(sizeof(client_t));
	cli->addr = cli_addr;
	cli->connfd = newsockfd;
	cli->uid = uid++;
	sprintf(cli->name, "%d", cli->uid);
        
        /*Pridanie klienta do pola a fork*/
        queueAdd(cli);
        printf("Uzivatel %s je online.\n",cli->name);
        pthread_create(&pid, NULL, &serveClient, (void*)cli);
 
	/*Znizenie zataze*/
        sleep(1);
     } 
     return 0; //sem sa program nikdy nedostane
}
