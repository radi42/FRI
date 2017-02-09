#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h> 
#include <time.h>
#include <math.h>
#include <string.h>

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

  printf("Proces 2\n");
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
   
   printf("Proces 4\n");
  
  
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
  
   printf("Proces 3\n");
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
  printf("Proces 5\n");
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
  
   
  
  sem_init(&semA,0,0); /* inicializacia semoforov pre procesy */
  sem_init(&semB,0,0);
  sem_init(&semC,0,0);
  sem_init(&semD,0,0);
  sem_init(&semE,0,0);
  
  pthread_create(&thread_id[0], NULL,&proces_2, NULL);
  pthread_create(&thread_id[1], NULL,&proces_3, NULL);
  pthread_create(&thread_id[2], NULL,&proces_4, NULL);
  pthread_create(&thread_id[3], NULL,&proces_5, NULL);
     
 
  int pid, status;
 
    
  pid = fork ();
  if ( pid < 0 ) {
   perror("Chyba pri volani fork\n");
   exit(1);
   }
  if ( pid==0 ) {  /* metoda P1 procesu nacita den, mesiac, rok zo vstupu a ulozi do suboru */ 
   printf("Proces 1\n");    
   }
  else { 
   wait(&status);
   sem_post(&semA);
   sem_post(&semB);
   int i;
   for (i = 0; i < POCET_VLAKIEN; i++)
    pthread_join(thread_id[i],NULL);   
   return 0;
   }
 exit(0);
   
} 