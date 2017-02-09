/**
 *  @file   p3.c
 *  @brief  Subor obsahujuci funkciu , ktoru vykonava proces p3
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <string.h>
#include <unistd.h>
    
/**
 *  @brief  Main funkcia programu.
 *  @param  argc Pocet parametrov
 *  @param  argv Pole parametrov
 *
 *  Main funkcia datum zo suboru datum.txt
 *
 *  Vypocita den v roku a vypise vystup na obrazovku.
 */    
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