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

	printf("Zadajte spravu: ");
	bzero(buffer,256);
	fgets(buffer, 255, stdin); 
        
        //vyhadzat z konca nepotrebne znaky => kontrolovat na \n a \r a dalsie
        //specialne (biele) znaky, potom bude mat server menej roboty
        
        //strchr(buffer, '\n');
              
        int i=0, j=0;
        char blank[256];    //retazec ocisteny od bielych znakov
        int velkostBuffra = strlen(buffer);
        
        printf("\nPocet znakov zadaneho retazca: ");
        printf("%d\n", velkostBuffra);

        while(i != velkostBuffra){
            if(buffer[i] == ' ' || buffer[i] == '\t' || buffer[i] == '\n' || buffer[i] == '\r')
            {
                i++;
            }
            else
            {
                //nasiel som normalny znak
                blank[j] = buffer[i];
                i++;
                j++;
            }
        }
        printf("Dlzka retazca bez bielych znakov: ");
        printf("%d\n",j);   //vypis dlzku noveho retazca
        blank[j] = '\0';    //pridaj null terminator na koniec retazca, inak bude na konci vypisovat divne znaky

        printf("\nRetazec bez bielych znakov\n");
        printf("%s\n", blank);
        printf("Pocet znakov: ");
        printf("%d\n", strlen(blank));

        char prikaz[11];
        if(strcmp(blank, strcpy(prikaz, "uloz")) == 0 ||
                strcmp(blank, strcpy(prikaz, "dajHodnotu")) == 0 ||
                strcmp(blank, strcpy(prikaz, "zmaz")) == 0 ||
                strcmp(blank, strcpy(prikaz, "koniec")) == 0){

                printf("\nPrikazovy retazec, ktory bude porovnavat server\n");
                printf("%s\n", prikaz);
                printf("Pocet znakov: ");
                printf("%d\n\n", strlen(prikaz));

            printf("Prikazy sa zhoduju a su podporovane serverom!\n");
        }
        else
        {
            printf("Server nepodporuje tento prikaz");
        }
        
        strcpy(buffer, blank);
        
        
        

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

