#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h> 
#include <time.h>
#include <math.h>

sem_t semA,semB,semC,semD,semE;


void* proces_2 (void* param)
{ 
  sem_wait(&semA);
  int pid2, status2; 
  pid2 = fork ();
  if ( pid2 < 0 ) {
   perror("Chyba pri volani fork\n");
   exit(1);
  }
 if ( pid2==0 ) {  /* metoda P2 procesu*/ /* vypise den v tyzdni nacitaneho datumu zo suboru */

  
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
 else {
  wait(&status2);
  sem_post(&semC);
 } 
 return NULL;
}

void* proces_4(void* param)
{	
 sem_wait(&semB);
 int pid4, status4;
 pid4 = fork ();
 if ( pid4 < 0 ) {
  perror("Chyba pri volani fork\n");
  exit(1);
 }
 if ( pid4==0 ) {  /* metoda P4 procesu*/ /*ulozenie do suboru pocet dni medzi datummi*/
   
   struct tm tm;
   FILE *fp = fopen( "datum.txt", "a+" );
   char str[10];
   fgets(str, 20, fp);
   strptime(str, "%d %m %Y", &tm);
                      
   time_t start,end;
   double diff;
   time(&start);
          
   end = timegm(&tm);
   diff = difftime(start,end);
   double vysledok;
   vysledok = fabs(diff / 86400);
   int x;        // doplnit zaokruhlovanie smerom nahor ceil -> "gcc -lm -lpthread sem.c"
   // x = ceil(vysledok);
   //   printf("start : %ld, koniec : %ld, rozdiel : %lf ",start,end,vysledok);
  
   fclose(fp); 
    remove("vystup.txt");   //kontrola existencie suboru
   FILE *file = fopen( "vystup.txt", "a+" );
   fprintf(file,"%lf",vysledok);
   fclose(file);
                     
  
  
  exit(0);
 }
 else {
  wait(&status4);
  sem_post(&semD);                          
 }


 return NULL;
}


void* proces_3(void* param)
{
 sem_wait(&semC);
 int pid3, status3;
 pid3 = fork();
  if (pid3 < 0) {
  perror("Chyba pri volani fork\n");
  exit(0);
 }
 if (pid3 == 0) {  /* metoda P3 procesu*/ /* vypise den v roku */
  
   char nazov_dna[20];
   struct tm tm;
   FILE *fp = fopen( "datum.txt", "r" );
   char str[10];
   fgets(str, 20, fp);
   strptime(str, "%d %m %Y", &tm);  
   printf("Den v roku : %d\n", tm.tm_yday);
   fclose(fp);
   
  exit(0);
 }
 else{
  wait(&status3);
  sem_post(&semE);
 }

 return NULL;

}

void* proces_5(void* param)
{
 sem_wait(&semD);
 sem_wait(&semE);
 int pid5, status5;
 pid5 = fork();
 if (pid5 < 0) {
   perror("Chyba pri volani fork\n");
   exit(0);
 }
 if (pid5 == 0) {  /* metoda P5 procesu */
  FILE *fp = fopen( "vystup.txt", "r" );
  char str[20];
  fgets(str, 20, fp);
  printf("Pocet dni medzi medzi zadanym datumom a aktualnym datumom : %s\n",str);
  fclose(fp);      
   exit(0);
 }
 else{
  wait(&status5);
  exit(0);
 }
               
 return NULL;
                
}
                
 

int main () {
  
  #define POCET_VLAKIEN 4
  pthread_t thread_id[POCET_VLAKIEN];
  pthread_create(&thread_id[0], NULL,&proces_2, NULL);
  pthread_create(&thread_id[1], NULL,&proces_3, NULL);
  pthread_create(&thread_id[2], NULL,&proces_4, NULL);
  pthread_create(&thread_id[3], NULL,&proces_5, NULL);
    
  
  sem_init(&semA,0,0); /* inicializacia semoforov pre procesy */
  sem_init(&semB,0,0);
  sem_init(&semC,0,0);
  sem_init(&semD,0,0);
  sem_init(&semE,0,0);
     
 
  int pid, status;
 
    
  pid = fork ();
  if ( pid < 0 ) {
   perror("Chyba pri volani fork\n");
   exit(1);
   }
  if ( pid==0 ) {  /* metoda P1 procesu nacita den, mesiac, rok zo vstupu a ulozi do suboru */ 
   char den[10];
   char mesiac[10];
   char rok[10];
 
//   int den, mesiac, rok;
   printf("Zadajte den : ");   
   scanf("%s",&den);
   
   printf("Zadajte mesiac : ");
   scanf("%s",&mesiac);
   
   printf("Zadajte rok : ");
   scanf("%s",&rok);
  // printf("\nDatum : %s. %s. %s",den, mesiac, rok);
     
   void write_lines (FILE *f) {
   fprintf (f, "%s ", den);
   fprintf (f, "%s ", mesiac);
   fprintf (f, "%s ", rok);
   }
   
   remove("datum.txt");      // prepisat kontrola ci subor existuje
   FILE *fp;
   fp=fopen("datum.txt", "w+");
   // a+ - append iba prida na koniec suboru
   //fp=fopen("datum.txt", "a+");
   write_lines(fp);
   fclose(fp);
   exit(0);        
   }
  else { 
   wait(NULL);
   //wait(&status);
   sem_post(&semA);
   sem_post(&semB);
   int i;
   for (i = 0; i < POCET_VLAKIEN; i++)
    pthread_join(thread_id[i],NULL);   
   return 0;
   }
 exit(0);
   
} 