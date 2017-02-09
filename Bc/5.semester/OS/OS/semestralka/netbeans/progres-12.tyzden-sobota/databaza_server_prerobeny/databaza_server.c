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
            printf ("Splitting string \"%s\" into tokens:\n",str);
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
            char *pHome = getenv("HOME");
            //Vetvenie podla prikazu od klienta
            
            /*
             * insert vytvori novy subor, ak subor s danym nazvom este neexistuje
             * v opacnom pripade sa sprava ako update - aktualizuje obsah
             * suboru podla kluca
             */
            if(strcmp("insert", arr[0]) == 0)
            {
                //ukladanie do suboru
                //kluc je nazov suboru
                //hodnota je obsah suboru
                
                printf("%s\n", "Poziadavka: insert");
                printf("Nazov vkladaneho suboru: %s\n", arr[2]);
                printf("Obsah vkladaneho suboru: %s\n", arr[4]);
                
                
                printf("%s\n", pHome);
                
                strcpy(cesta, pHome);
                strcat(cesta, "/Desktop/OS/semestralka/netbeans/databaza_server_prerobeny/databazove_subory/");   //zakladna cesta ukladania DB suborov
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                printf("%s\n", cesta);
                
                FILE *pFile = fopen(cesta, "w");
                printf("subor otvoreny\n");

                //zapis hodnotu do suboru
                fputs(arr[4], pFile);

                printf("subor sa zatvara...");

                fclose(pFile);

                printf("subor uzavrety\n");
            }
            else if(strcmp("select", arr[0]) == 0)
            {
                printf("%s\n", "Poziadavka: select");
                printf("Vypisuje sa obsah suboru: %s\n", arr[2]);
                
                char c; //jedno pismeno obsahu suboru
                FILE *file;
                char obsahSuboru[1024]; //cely obsah suboru - maximalne 1023 znakov
                
                strcpy(cesta, pHome);
                strcat(cesta, "/Desktop/OS/semestralka/netbeans/databaza_server_prerobeny/databazove_subory/");
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
                
                file = fopen(cesta, "r");
                
                //ak subor existuje, klientovi sa vypise jeho obsah
                //inak sa nevypise nic
                if (file) {                   
                    int i = 0;
                    while ((c = getc(file)) != EOF){
                        obsahSuboru[i] = c;
                        i++;
                    }
                    printf("%s\n", obsahSuboru);
                    fclose(file);
                    printf("\n%s\n", "Obsah suboru vypisany");
                }
                
                msg = obsahSuboru;
                retVal = write(newsockfd, msg, strlen(msg)+1);
                if (retVal < 0)
                {
                        perror("Error writing to socket");
                        return 5;
                }
                
                for(i = 0; i < 1024; i++){
                    obsahSuboru[i] = '\0';
                }
            }
            else if(strcmp("delete", arr[0]) == 0)
            {
                printf("%s\n", "Poziadavka: delete");
                printf("Vymazava sa subor: %s\n", arr[2]);
                
                //char cesta[200];
                //char *pHome = getenv("HOME");
                
                strcpy(cesta, pHome);
                strcat(cesta, "/Desktop/OS/semestralka/netbeans/databaza_server_prerobeny/databazove_subory/");
                strcat(cesta, arr[2]);
                strcat(cesta, ".txt");
 
               if( remove(cesta) == 0 )
                  printf("Subor %s.txt uspesne vymazany\n",arr[2]);
               else
               {
                  printf("Skontroluje nazov kluca\n");
                  perror("Subor neexistuje");
               }
            }          
            
            msg = "Sprava prijata";
            retVal = write(newsockfd, msg, strlen(msg)+1);
            if (retVal < 0)
            {
                    perror("Error writing to socket");
                    return 5;
            }
            
            
            free(arr);  //uvolni alokovane miesto v pamati pre pole
        }while(1);
        
/*        
        //ovladanie podla prikazov od klienta

        //int ret;
        const char* msg;

        if(strcmp(buffer, "insert\n") == 0){
            //uloz zaznam (subor)
            //kluc md5 hash suboru; vypocita sa z obsahu suboru
            //hodnota bude obsah suboru
                                    
            FILE *pFile;
            
            char kluc[101]; //nazov suboru
            char hodnota[101]; //obsah suboru
          
            char cesta[200];
            strcpy(cesta, "/home/debian/OS/semestralka/netbeans/databaza_server/databazove_subory/dbsubor.txt");   //zakladna cesta ukladania DB suborov
            
            FILE *f = fopen(cesta, "w");
            printf("otvoril som subor\n");
            
            //zapis hodnotu do suboru
            fputs(hodnota, pFile);

            printf("zatvaram subor...");
            
            fclose(pFile);
            
            printf("uzavrel som subor\n");
            
            //odosli spravu
            msg = "vlozene";
            printf("%s", msg);
            retVal = write(newsockfd, msg, strlen(msg) + 1);
            if (retVal < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        } 
        else if(strcmp(buffer, "delete") == 0)
        {
            //zmaz subor podla nazvu (zmen hodnotu zaznamu podla kluca)
            msg = "zmazane";
            retVal = write(newsockfd, msg, strlen(msg) + 1);
            if (retVal < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        }
        else if(strcmp(buffer, "update") == 0)
        {
            //zmen obsah suboru podla kluca
            msg = "zaznam zmeneny";
            printf("%s", msg);
            retVal = write(newsockfd, msg, strlen(msg) + 1);
            if (retVal < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        }
        else if(strcmp(buffer, "select") == 0)
        {
            //daj hodnotu zaznamu (obsah suboru)
            msg = "hodnota vypisana";
            printf("%s", msg);
            retVal = write(newsockfd, msg, strlen(msg) + 1);
            if (retVal < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        }
        else
        {
            //neplatny prikaz
            msg = buffer;
            printf("%s", "neplatny prikaz");
            retVal = write(newsockfd, msg, strlen(msg) + 1);
            if (retVal < 0) {
                perror("Chyba pri zapisovani do socketu");
                return 5;
            }
        }

        printf("\nsocket sa zatvara...");
*/ 
	close(newsockfd);
	close(sockfd);

	return 0;
}