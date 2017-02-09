#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int sockfd, cisloDeskriptora;  //filedescriptor socketu, 
	struct sockaddr_in serv_addr;
	struct hostent* server;

	char buffer[256];

	if (argc < 3) 
	{
		fprintf(stderr,"pouzitie: %s hostname port\n", argv[0]);
		return 1;
	}

	server = gethostbyname(argv[1]); 
	if (server == NULL)
	{
		fprintf(stderr, "Chyba - host neexistuje\n");
		return 2;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr)); 
	serv_addr.sin_family = AF_INET;
	bcopy(
		(char*)server->h_addr,
		(char*)&serv_addr.sin_addr.s_addr,
		server->h_length
	);
	serv_addr.sin_port = htons(atoi(argv[2]));

	sockfd = socket(AF_INET, SOCK_STREAM, 0); 
	if (sockfd < 0)
	{
		perror("Chyba pri vytvarani socketu");
		return 3;
	}

	if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)  
	{
		 perror("Chyba pri pripajani sa na socket");
		 return 4;
	}

	bzero(buffer,256);  //inicializuj buffer na 256 znakov
        
        //printf("%d\n", argc);
        char prikazy[6];
        if(strcmp(argv[3], "insert") == 0)
        {
            strcpy(buffer, argv[3]);
            strcat(buffer,"#");
            strcat(buffer, argv[4]);
            strcat(buffer,"#");
            strcat(buffer, argv[5]);
            strcat(buffer,"#");
            strcat(buffer, argv[6]);
            strcat(buffer,"#");
            strcat(buffer, argv[7]);
        }
        else if(strcmp(argv[3], "select") == 0)
        {
            strcpy(buffer, argv[3]);
            strcat(buffer,"#");
            strcat(buffer, argv[4]);
            strcat(buffer,"#");
            strcat(buffer, argv[5]);
        }
        else if(strcmp(argv[3], "delete") == 0)
        {
            strcpy(buffer, argv[3]);
            strcat(buffer,"#");
            strcat(buffer, argv[4]);
            strcat(buffer,"#");
            strcat(buffer, argv[5]);
        }
        else
        {
            printf("%s\n", "Niekde ste spravili preklep.");
            return 400; //HTTP - Bad Request
        }
        
        //vypis obsah buffra - sprava odosielana serveru
        //printf("%s\n", buffer);

	cisloDeskriptora = write(sockfd, buffer, strlen(buffer));
	if (cisloDeskriptora < 0)
	{
		 perror("Chyba pri zapisovani do socketu");
		 return 5;
	}

	bzero(buffer,256);
	cisloDeskriptora = read(sockfd, buffer, 255);
	if (cisloDeskriptora < 0)
	{
		 perror("Chyba pri citani zo socketu");
		 return 6;
	}

	printf("%s\n",buffer);
	close(sockfd);

	return 0;	
}

// priklady pouzitia
// ./databaza_klient localhost 5178 insert -k kluc -h hodnota
// ./databaza_klient localhost 5178 insert -k kluc -h "strasne vela slov naraz"
// ./databaza_klient localhost 5178 insert -k dalsikluc -h "viac slov # za sebou"

// ./databaza_klient localhost 5178 select -k kluc
// ./databaza_klient localhost 5178 select -k klcu

// ./databaza_klient localhost 5178 delete -k kluc
// ./databaza_klient localhost 5178 zlyprikaz