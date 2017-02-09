/**
 *  @file   p5.c
 *  @brief  Subor obsahujuci funkciu , ktoru vykonava proces p5
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
 *  Main funkcia subor vystup.txt.
 *
 *  Vypise na obrazovku vysledok minuleho procesu ( p4 ).
 */  
int main (int argc, char *argv[]) 
   {
	FILE *fp = fopen( "vystup.txt", "r" );
	char str[20];
	fgets(str, 20, fp);
	printf("Pocet dni medzi medzi zadanym datumom a aktualnym datumom : %s\n",str);
	fclose(fp); 
	if (remove("vystup.txt") == -1)
		perror("Chyba pri vymazani suboru vystup.txt");
	if (remove("datum.txt") == -1)
		perror("Chyba pri vymazani suboru datum.txt");
    exit(0);
   }