/**
 * @file databaza_klient.c
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

/**
 * Hlavna funkcia klienta
 * odosiela udaje serveru prostrednictvom domenoveho mena a portu, na ktorom 
 * server pocuva, zadanych ako parametre
 * @param argc pocet argumentov
 * @param argv hodnoty argumentov
 * @return 
 */
int main(int argc, char *argv[])
{
        //! sockfd je filedescriptor socketu a premenna cisloDeskriptora na ukladanie navratovych hodnot metod
	int sockfd, cisloDeskriptora;
	struct sockaddr_in serv_addr;
	struct hostent* server;

        //! Bufferom klient odosiela udaje na server
	char buffer[256];

	if (argc < 3) 
	{
		fprintf(stderr,"pouzitie: %s hostname port\n", argv[0]);
		return 1;
	}

	server = gethostbyname(argv[1]);
        //! Najde IP adresu servera podla domenoveho mena
	if (server == NULL)
	{
		fprintf(stderr, "Chyba - host neexistuje\n");
		return 2;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr)); 
	serv_addr.sin_family = AF_INET;
        //! Adresa je vo formate IPv4
	bcopy(
		(char*)server->h_addr,
		(char*)&serv_addr.sin_addr.s_addr,
		server->h_length
	);
	serv_addr.sin_port = htons(atoi(argv[2]));
        //! konvertuj cislo portu do opacneho poradia, kvoli prenosu cez siet

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

        //! inicializuj strukturu bzero buffrom a jeho velkostou
	bzero(buffer,256);
        
        //printf("%d\n", argc);
        
        /*!
         * Prikaz insert
         * ulozenie/upravenie obsahu suboru
         * Na server sa posiela 5 argumentov, 3. az 7., ako jeden retazec, 
         * oddeleny znakom '#'
         * insert -k kluc -h hodnota
         */
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
        /*!
         * Prikaz select
         * zobrazenie obsahu suboru
         * Na server sa posiela 3 argumenty, 3. az 5., ako jeden retazec,
         * oddeleny znakom '#'
         * select -k kluc
         */
        else if(strcmp(argv[3], "select") == 0)
        {
            strcpy(buffer, argv[3]);
            strcat(buffer,"#");
            strcat(buffer, argv[4]);
            strcat(buffer,"#");
            strcat(buffer, argv[5]);
        }
        /*!
         * Prikaz delete
         * vymazanie suboru
         * Na server sa posiela 3 argumenty, 3. az 5., ako jeden retazec, 
         * oddeleny znakom '#'
         * delete -k kluc
         */
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
            //! Pri zadani neplatneho prikazu sa nic nevykona
            printf("%s\n", "Niekde ste spravili preklep.");
            return 400; // HTTP - Bad Request
        }
        
        //vypis obsah buffra - sprava odosielana serveru
        //printf("%s\n", buffer);

        /*!
         * Odoslanie retazca na server (nesmie byt vacsi ako 255 znakov + \0)
         */
	cisloDeskriptora = write(sockfd, buffer, strlen(buffer));
	if (cisloDeskriptora < 0)
	{
		 perror("Chyba pri zapisovani do socketu");
		 return 5;
	}

        //! Prijatie spravy od servera (nesmie byt vacsia ako 255 znakov + \0)
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

//!  priklady pouzitia
//!  ./databaza_klient localhost 5178 insert -k kluc -h hodnota
//!  viacslovnu hodnotu treba uzavriet do uvodzoviek
//!  ./databaza_klient localhost 5178 insert -k kluc -h "text"
//!  ./databaza_klient localhost 5178 insert -k dalsikluc -h "viac textu"

//!  ./databaza_klient localhost 5178 select -k kluc
//!  ./databaza_klient localhost 5178 select -k klcu

//!  ./databaza_klient localhost 5178 delete -k kluc
//!  ./databaza_klient localhost 5178 zlyprikaz
