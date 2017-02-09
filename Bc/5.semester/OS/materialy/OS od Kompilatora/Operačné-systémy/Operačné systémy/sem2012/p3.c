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
	printf("Den v roku : %d\n", tm.tm_yday + 1);
	fclose(fp);
	exit(0);
   }