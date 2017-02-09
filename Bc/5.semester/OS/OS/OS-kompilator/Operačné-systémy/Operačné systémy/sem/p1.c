/**
 *  @file   p1.c
 *  @brief  Subor obsahujuci funkciu , ktoru vykonava proces p1
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
 *  Main funkcia nacita den, mesiac a rok.
 *
 *  Nasledne zadany vstup ulozi do suboru datum.txt
 */   
int main (int argc, char *argv[]) 
   {
	 char den[10];
     char mesiac[10];
	 char rok[10];
 
	 printf("Zadajte den : ");   
	 scanf("%s",&den);
   
	 printf("Zadajte mesiac : ");
	 scanf("%s",&mesiac);
   
	 printf("Zadajte rok : ");
	 scanf("%s",&rok);
	 
	 FILE *fp;
	 fp=fopen("datum.txt", "w+");   
	 fprintf (fp, "%s ", den);
	 fprintf (fp, "%s ", mesiac);
	 fprintf (fp, "%s ", rok);
	 fclose(fp);
	 exit(0);
   }