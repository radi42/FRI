/**
 * @file databaza_server.c
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/stat.h>

/**
 * Hlavna funkcia servera
 * zodpoveda za vykonanie prikazu klienta a informovanie klienta o vysledku
 * operacie
 * @param argc pocet argumentov
 * @param argv hodnoty argumentov
 * @return 
 */
int main(int argc, char *argv[])
{
        //! filedescriptor socketu, filedescriptor noveho socketu
	int sockfd, newsockfd;
	socklen_t cli_len;
	struct sockaddr_in serv_addr, cli_addr;
	int retVal;
	char buffer[256];
        //! Bufferom sa odosiela odpoved klientovi

	if (argc < 2) 
	{
		fprintf(stderr,"pouzitie: %s cislo_portu\n", argv[0]);
		return 1;
	}

	bzero((char*)&serv_addr, sizeof(serv_addr)); 
	serv_addr.sin_family = AF_INET;
        //! komunikujeme cez IPv4
	serv_addr.sin_addr.s_addr = INADDR_ANY;
        //! zadana adresa moze byt lubovolna platna IPv4 adresa
	serv_addr.sin_port = htons(atoi(argv[1]));
        //! konverzia cisla portu do obrateneho poradia, kvoli prenosu cez siet

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
        //! najviac moze na splnenie poziadavky cakat 5 klientov
	cli_len = sizeof(cli_addr);

        /*!
         * Nekonecny cyklus
         * Server moze prijmat poziadavky neustale, narozdiel od klienta,
         * ktory uzavrie spojenie, akonahle odosle prikaz
         */
        do{
            newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len);
            //! Prijatie poziadavky o pripojenie klienta
            if (newsockfd < 0)
            {
                    perror("Chyba pri prijmani");
                    return 3;
            }

            bzero(buffer,256);
            retVal = read(newsockfd, buffer, 255);
            //! server precita prikaz od klienta
            if (retVal < 0)
            {
                    perror("Chyba pri citani zo socketu");
                    return 4;
            }

            //printf("Zadany prikaz: %s\n", buffer);
            
            /*!
             * rozparsuj spravu od klienta a zisti prikaz
             * nazov suboru sa nesmie zacinat oddelovacom
             */
            char str[256];
            //! skopiruj originalny string do premennej, lebo funkcia strtok poskodi zdrojovy string
            strcpy(str, buffer);
            
            //! prejdi stringom a spocitaj pocet znakov '#'
            int pocet = 0;
            char *p;
            p = str;
            while(*p != '\0'){
                if (*p == '#') pocet++;
                p++;
            }

            //! inkrementuj pocet argumentov o jedna, lebo pocet argumentov je o jeden viac ako pocet '#'
            pocet++;
            
            //printf("%d\n", pocet);
            
            /*!init pola prikazov arr do dynamickej pamate
             * daj kazdy argument do samostatneho stringu - rozdel ich podla znaku '#'
             */
            char **arr = (char**) calloc(pocet+1, sizeof(char*));
            int i = 0;
            for ( i = 0; i < pocet; i++ )
            {
                /*!
                 * alokujem pole o takom pocte prvkov, aky je argumentov, 
                 * kde kazdy prvok (argument) moze mat 511 najviac znakov
                 */
                arr[i] = (char*) calloc(512, sizeof(char));
            }
            
            //printf ("Rozdelovanie retazca \"%s\" na casti:\n",str);
            /*!
             * Rozdelenie retazca odoslaneho klientom podla znaku '#'
             */
            char *pch;
            pch = strtok (str,"#");
            i = 0;
            while (pch != NULL)
            {
                //! Kazdy jednotlivy argument pridaj do pola argumentov arr
                arr[i] = pch;
                //printf ("%s\n",arr[i]);
                i++;
                pch = strtok (NULL, "#");
            }
            
            //skontroluj obsah pola
/*
            printf("\n");
            for(i = 0; i<pocet; i++)
            {
                printf("%s\n", arr[i]);
            }
*/

            const char* msg;
            char cesta[200];
            char vytvorPriecinok[100];
            char *pHome = getenv("HOME");
            char *pRootPath = "/databazove_subory/";
            
            strcpy(vytvorPriecinok, pHome);
            strcat(vytvorPriecinok, pRootPath);
            //printf("%s\n", vytvorPriecinok);
            
            //! Ak priecinok pre ukladanie suborov neexistuje, vytvori sa
            struct stat st = {0};
            if (stat(vytvorPriecinok, &st) == -1) {
                mkdir(vytvorPriecinok, 0700);
            }
            
            
            //! Vetvenie podla prikazu od klienta
            
            /*! Insert
             * Prikaz insert vytvori novy subor, ak subor s danym nazvom este neexistuje
             * v opacnom pripade sa sprava ako update - aktualizuje obsah suboru podla kluca
             */
            if(strcmp("insert", arr[0]) == 0)
            {
                //! ukladanie do suboru
                //! kluc je nazov suboru
                //! hodnota je obsah suboru
                
                printf("%s\n", "Poziadavka: insert");
                printf("Nazov vkladaneho suboru: %s\n", arr[2]);
                printf("Obsah vkladaneho suboru: %s\n", arr[4]);
                
                strcpy(cesta, pHome);
                strcat(cesta, pRootPath);   //! zakladna cesta ukladania DB suborov
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                printf("%s\n", cesta);
                
                FILE *pFile = fopen(cesta, "w");
                printf("Subor otvoreny\n");
                
                //! zapis hodnotu do suboru
                fputs(arr[4], pFile);
                fclose(pFile);
                
                printf("Subor uzavrety\n");
                
                //! Daj spravu klientovo, ze sa subor ulozil
                msg = "Subor ulozeny";
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Chyba pri zapisovani do socketu");
                        return 5;
                }
            }
            /*!
             * Select
             * Prikaz select vypysuje obsah suboru podla zadaneho kluca
             * Ak subor s danym nazvom neexituje, server vrati klientovi
             * prazdny retazec
             */
            else if(strcmp("select", arr[0]) == 0)
            {
                printf("%s\n", "Poziadavka: select");
                printf("Vypisuje sa obsah suboru: %s\n", arr[2]);
                
                //! Jedno pismeno obsahu suboru
                char c;
                //! Subor, ktory chceme citat
                FILE *file;
                //! Cely obsah suboru - maximalne 1023 znakov
                char obsahSuboru[1024];
                
                //! Vynuluj pole obsahSuboru
                for(i = 0; i < 1024; i++){
                    obsahSuboru[i] = '\0';
                }
                
                strcpy(cesta, pHome);
                strcat(cesta, pRootPath);
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                
                //! Otvor subor na danej ceste iba na citanie
                file = fopen(cesta, "r");
                
                /*!
                 * ak subor existuje, do pola sa ulozi jeho obsah po 
                 * jednotlivych znakoch, inak sa nevypise nic
                 */
                if (file) {                   
                    int i = 0;
                    while ((c = getc(file)) != EOF){
                        obsahSuboru[i] = c;
                        i++;
                    }
                    printf("\n%s\n", obsahSuboru);
                    fclose(file);
                    printf("\n%s\n", "Obsah suboru vypisany");
                }
                
                //! Posli klientovi obsah suboru podla zadaneho kluca
                msg = obsahSuboru;
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Chyba pri zapisovani do socketu");
                        return 5;
                }
            }
            /*!
             * Delete
             * Prikaz delete vymaze subor podla, kluca zadaneho ako parameter
             * Ak subor neexistuje, klient o tom dostane spravu
             */
            else if(strcmp("delete", arr[0]) == 0)
            {
                printf("%s\n", "Poziadavka: delete");
                printf("Vymazava sa subor: %s\n", arr[2]);
                
                strcpy(cesta, pHome);
                strcat(cesta, pRootPath);
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
 
                char stavVymazania[50];
                if( remove(cesta) == 0 ){
                    strcpy(stavVymazania, "Subor ");
                    strcat(stavVymazania, arr[2]);
                    strcat(stavVymazania, ".txt uspesne vymazany");
                    
                    printf(stavVymazania);
                    printf("\n");
                }
                else
                {
                    strcpy(stavVymazania, "Subor neexistuje. Skontrolujte nazov kluca.");
                    printf("Skontrolujte nazov kluca\n");
                    perror("Subor neexistuje");
                }
                
                //! Posli klientovi spravu o vymazani suboru
                msg = stavVymazania;
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Chyba pri zapisovani do socketu");
                        return 5;
                }
                
                //! vynuluj pole stavVymazania
                for(i = 0; i < 50; i++){
                    stavVymazania[i] = '\0';
                }
            }
            
            //! uvolni alokovane miesto v pamati pre pole argumentov
            free(arr);
            printf("\n");
        }while(1);
        
        /*!
         * Server bezi v slucke, a nie je mozne ho ukonit z klienta,
         * preto ho treba ukoncit cez ctrl + c
         */
	close(newsockfd);
	close(sockfd);

	return 0;
}

//! Priklady pouzitia
//! ./databaza_server <cislo portu>
//! ./databaza_server 5178
