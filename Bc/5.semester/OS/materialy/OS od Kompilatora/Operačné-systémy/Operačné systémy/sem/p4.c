/**
 *  @file   p4.c
 *  @brief  Subor obsahujuci funkciu , ktoru vykonava proces p4
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
 *  Vypocita rozdiel medzi dnesnym datumom a datumom nacitanym zo suboru.
 *
 *  Vysledok ulozi do suboru vystup.txt
 */  
int main (int argc, char *argv[]) 
   {
	   struct tm tm;
	   int x; 
	   time_t start,end;
	   double diff,vysledok;
	   FILE *fp = fopen( "datum.txt", "r" );
	   char str[20];
	   char buffer[500];
	   fgets(str, 20, fp);
	   strptime(str, "%d %m %Y", &tm);
	   sprintf (buffer,"DEBUG tm_sec = %d, tm_min = %d, tm_hour = %d, tm_mday = %d, " 
			"tm_mon = %d, tm_year = %d, tm_wday = %d, tm_yday = %d, " 
			"tm_isdst = %d\n", 
			tm.tm_sec, tm.tm_min, tm.tm_hour, tm.tm_mday, 
			tm.tm_mon, tm.tm_year, tm.tm_wday, tm.tm_yday, 
			tm.tm_isdst);
	  
	   time(&start);
	   end = timegm(&tm);
	   diff = difftime(start,end);
	   vysledok = fabs(diff / 86400);
	   x =ceil(vysledok);
	   fclose(fp); 
	   FILE *file = fopen( "vystup.txt", "w+" );
	   fprintf(file,"%d",x);
	   fclose(file);
	   exit(0);
  }