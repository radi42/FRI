#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	int sockfd, newsockfd;  //filedescriptor socketu, filedescriptor noveho socketu
	socklen_t cli_len;
	struct sockaddr_in serv_addr, cli_addr;
	int n;
	char buffer[256];

	if (argc < 2) 
	{
		fprintf(stderr,"pouzitie: %s cislo_portu\n", argv[0]);
		return 1;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr)); 
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(atoi(argv[1]));

	sockfd = socket(AF_INET, SOCK_STREAM, 0); 
	if (sockfd < 0)
	{
		perror("Chyba pri vytvarani socketu");
		return 1;
	}

	if (bind(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0) 
	{
		 perror("Chyba pri bindovani socketovej adresy");
		 return 2;
	}

	listen(sockfd, 5); 
	cli_len = sizeof(cli_addr);

	newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len); 
	if (newsockfd < 0)
	{
		perror("Chyba pri prijmani");
		return 3;
	}

	bzero(buffer,256);
	n = read(newsockfd, buffer, 255); 
	if (n < 0)
	{
		perror("Chyba pri citani zo socketu");
		return 4;
	}
        
        //ovladanie podla prikazov od klienta

        int ret;
        const char* msg;

        if(strcmp(buffer, "uloz") == 0){
            //uloz zaznam (subor)
            //kluc bude nazov suboru
            //hodnota bude obsah suboru
            ret = strcmp(buffer, "uloz");
            printf("%s\n", buffer);
            printf("%s\n", "uloz");
            printf("%d\n", ret);
            
            FILE *pFile;
            
            char kluc[101]; //nazov suboru
            char hodnota[101]; //obsah suboru

            //odosli spravu klientovi - zadaj kluc
            printf("zadajte kluc (nazov suboru)\n");
            scanf("%s", kluc);
            
            char cesta[200];
            strcpy(cesta, "/home/debian/OS/semestralka/netbeans/databaza_server/databazove_subory/");   //zakladna cesta ukladania DB suborov
            strcat(cesta, kluc);    //kluc je nazov suboru
            strcat(cesta, ".txt");  //subor je s priponou .txt
            printf(cesta);
            

            FILE *f = fopen(cesta, "w");
            printf("otvoril som subor\n");

            //odosli spravu klientovi - zadaj hodnotu
            printf("zadajte hodnotu (obsah suboru)\n");
            scanf("%s", hodnota);

            printf("hodnota priradena");
            
            //zapis hodnotu do suboru
            fputs(hodnota, pFile);

            printf("zatvaram subor...");
            
            fclose(pFile);
            printf("uzavrel som subor\n");
            
            //odosli spravu
            msg = "ulozene";
            n = write(newsockfd, msg, strlen(msg) + 1);
            if (n < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        } 
        else if(strcmp(buffer, "dajHodnotu") == 0)
        {
            //daj hodnotu zaznamu (obsah suboru)
            msg = "hodnota vypisana";
            n = write(newsockfd, msg, strlen(msg) + 1);
            if (n < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        } 
        else if(strcmp(buffer, "zmaz") == 0)
        {
            //zmaz subor podla nazvu (zmen hodnotu zaznamu podla kluca)
            msg = "zmazane";
            n = write(newsockfd, msg, strlen(msg) + 1);
            if (n < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        } 
        else if(strcmp(buffer, "koniec") == 0)
        {
            //uzavri socket
            msg = "program ukonceny";
            n = write(newsockfd, msg, strlen(msg) + 1);
            if (n < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
            
            close(newsockfd);
            close(sockfd);
            printf("\n ukoncene v ife");
        }
        
/*
        const char* msg = "200 OK";
	n = write(newsockfd, msg, strlen(msg)+1); 
	if (n < 0)
	{
		perror("Chyba pri zapisovani do socketu");
		return 5;
	}
*/

        printf("\n ukoncene za ifom");
	close(newsockfd);
	close(sockfd);

	return 0;
}