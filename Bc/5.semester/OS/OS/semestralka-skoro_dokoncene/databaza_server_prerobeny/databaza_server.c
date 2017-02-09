#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#include <sys/stat.h>

int main(int argc, char *argv[])
{
	int sockfd, newsockfd;  //filedescriptor socketu, filedescriptor noveho socketu
	socklen_t cli_len;
	struct sockaddr_in serv_addr, cli_addr;
	int retVal;
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

        do{
            newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len); 
            if (newsockfd < 0)
            {
                    perror("Chyba pri prijmani");
                    return 3;
            }

            bzero(buffer,256);
            retVal = read(newsockfd, buffer, 255); 
            if (retVal < 0)
            {
                    perror("Chyba pri citani zo socketu");
                    return 4;
            }

            printf("Zadany prikaz: %s\n", buffer);
            
            //rozparsuj spravu od klienta a zisti prikaz - POZOR: nazov suboru sa nesmie zacinat oddelovacom
            char str[256];
            strcpy(str, buffer);    //skopiruj originalny string do premennej, lebo funkcia strtok poskodi zdrojovy string
            
            //daj kazdy argument do samostatneho stringu - potrebujem pole stringov
            
            int pocet = 0;
            char *p;
            p = str;
            while(*p != '\0'){
                if (*p == '#') pocet++; // prejdi stringom a spocitaj pocet znakov '#'
                p++;
            }

            pocet++;    //inkrementuj pocet argumentov o jedna, lebo pocet argumentov je o jeden viac ako pocet '#'
            
            printf("%d\n", pocet);
            
            //init pola prikazov
            char **arr = (char**) calloc(pocet+1, sizeof(char*));
            int i = 0;
            for ( i = 0; i < pocet; i++ )
            {
                arr[i] = (char*) calloc(1024, sizeof(char));    //alokujem pole o takom pocte prvkov, kolko je argumentov, kde kazdy prvok (argument) moze mat 1023 znakov
            }
            
            char *pch;
            printf ("Rozdelovanie retazca \"%s\" na casti:\n",str);
            pch = strtok (str,"#");
            i = 0;
            while (pch != NULL)
            {
              arr[i] = pch;
              //printf ("%s\n",arr[i]);
              i++;
              pch = strtok (NULL, "#");
            }
            
            //skontroluj obsah pola
            printf("\n");
            for(i = 0; i<pocet; i++)
            {
                printf("%s\n", arr[i]);
            }
            
/*
            printf("%d\n", sizeof("insert"));
            printf("%d\n", sizeof(arr[0]));
*/
            printf("insert? %d\n",strcmp("insert", arr[0]));
            printf("select? %d\n",strcmp("select", arr[0]));
            printf("delete? %d\n",strcmp("delete", arr[0]));

            const char* msg;
            char cesta[200];
            char vytvorPriecinok[100];
            char *pHome = getenv("HOME");
            char *pRootPath = "/databazove_subory/";
            
            //Ak priecinky pre ukladanie suborov neexistuju, vytvoria sa
            strcpy(vytvorPriecinok, pHome);
            strcat(vytvorPriecinok, pRootPath);
            printf("%s\n", vytvorPriecinok);
            
            struct stat st = {0};
            
            if (stat(vytvorPriecinok, &st) == -1) {
                mkdir(vytvorPriecinok, 0700);
            }
            
            
            //Vetvenie podla prikazu od klienta
            
            /*
             * insert vytvori novy subor, ak subor s danym nazvom este neexistuje
             * v opacnom pripade sa sprava ako update - aktualizuje obsah suboru podla kluca
             */
            if(strcmp("insert", arr[0]) == 0)
            {
                //ukladanie do suboru
                //kluc je nazov suboru
                //hodnota je obsah suboru
                
                printf("%s\n", "Poziadavka: insert");
                printf("Nazov vkladaneho suboru: %s\n", arr[2]);
                printf("Obsah vkladaneho suboru: %s\n", arr[4]);
                
                strcpy(cesta, pHome);
                strcat(cesta, pRootPath);   //zakladna cesta ukladania DB suborov
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                printf("%s\n", cesta);
                
                FILE *pFile = fopen(cesta, "w");
                printf("Subor otvoreny\n");
                
                //zapis hodnotu do suboru
                fputs(arr[4], pFile);
                fclose(pFile);
                
                printf("Subor uzavrety\n");
                
                //Daj spravu klientovo, ze sa subor ulozil
                msg = "Subor ulozeny";
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Error writing to socket");
                        return 5;
                }
            }
            else if(strcmp("select", arr[0]) == 0)
            {
                printf("%s\n", "Poziadavka: select");
                printf("Vypisuje sa obsah suboru: %s\n", arr[2]);
                
                char c; //jedno pismeno obsahu suboru
                FILE *file;
                char obsahSuboru[1024]; //cely obsah suboru - maximalne 1023 znakov
                
                //vynuluj pole obsahSuboru
                for(i = 0; i < 1024; i++){
                    obsahSuboru[i] = '\0';
                }
                
                strcpy(cesta, pHome);
                strcat(cesta, pRootPath);
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                
                file = fopen(cesta, "r");   //Otvor subor na danej ceste iba na citanie
                
                //ak subor existuje, klientovi sa vypise jeho obsah
                //inak sa nevypise nic
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
                
                //Posli klientovi obsah suboru podla zadaneho kluca
                msg = obsahSuboru;
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Error writing to socket");
                        return 5;
                }
            }
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
                
                //Posli klientovi spravu o vymazani suboru
                msg = stavVymazania;
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Error writing to socket");
                        return 5;
                }
                
                //vynuluj pole stavVymazania
                for(i = 0; i < 50; i++){
                    stavVymazania[i] = '\0';
                }
            }
            
            free(arr);  //uvolni alokovane miesto v pamati pre pole argumentov
            printf("%s\n", "Pole arr uvolnene");
        }while(1);
        

	close(newsockfd);
	close(sockfd);

	return 0;
}