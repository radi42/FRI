#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <unistd.h>
      
int main (int argc, char *argv[]) 
   {
	   char nazov_dna[20];  
	   struct tm tm;  
	   FILE *fp = fopen( "datum.txt", "r" );
	   char str[10];
	   fgets(str, 20, fp);       
	   strptime(str, "%d %m %Y", &tm);     
	   fclose(fp);
		
	   switch ( tm.tm_wday )
	   {
		 case 1:
			strncpy(nazov_dna, "Pondelok", sizeof("Pondelok")); 
			break;
		 case 2:
			strncpy(nazov_dna, "Utorok", sizeof("Utorok"));     
			break;
		 case 3:
			strncpy(nazov_dna, "Streda", sizeof("Streda"));      
			break;
		 case 4:
			strncpy(nazov_dna, "Stvrtok", sizeof("Stvrtok"));                                     
			break;
		 case 5:
			strncpy(nazov_dna, "Piatok", sizeof("Piatok"));          
			break;
		 case 6:
			strncpy(nazov_dna, "Sobota", sizeof("Sobota"));
			break;
		 case 0:
			strncpy(nazov_dna, "Nedela", sizeof("Nedela"));
			break;
		 default:
			strncpy(nazov_dna, "", 0);
			break;                   
	   }
	   
	   printf("Den v tyzdni: %s\n", nazov_dna);
	   exit(0);
   
   }