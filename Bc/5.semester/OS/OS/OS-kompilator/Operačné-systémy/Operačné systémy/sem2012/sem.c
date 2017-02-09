/**
 *  @file   sem.c
 *  @brief  Súbor obsahujúci funkciu main
 */
 
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h> 
#include <time.h>
#include <math.h>
#include <string.h>
#include <unistd.h>
   
sem_t semA,semB,semC,semD,semE;


void* vlakno_2 (void* param)
{ 
  sem_wait(&semA);
  int pid2; 
  pid2 = fork ();
  if ( pid2 < 0 ) 
  {
	perror("Chyba pri volani fork\n");
	exit(1);
  }
  if ( pid2==0 ) 
  {  
	execlp("./p2","p2",NULL);
	printf("Chyba pri spustani procesu 2\n");
	exit(EXIT_FAILURE);
  }
  else 
  {
	waitpid(pid2,NULL,0);
	sem_post(&semC);
  } 
 return NULL;
}

void* vlakno_4(void* param)
{	
  sem_wait(&semB);
  int pid4;
  pid4 = fork ();
  if ( pid4 < 0 ) 
  {
	perror("Chyba pri volani fork\n");
	exit(1);
  }
  if ( pid4==0 ) 
  { 
	execlp("./p4","p4",NULL);
	printf("Chyba pri spustani procesu 4\n");
	exit(EXIT_FAILURE); 
  }
  else 
  {
	waitpid(pid4,NULL,0);
	sem_post(&semD);   
  }
 return NULL;
}


void* vlakno_3(void* param)
{
  sem_wait(&semC);
  int pid3;
  pid3 = fork();
  if (pid3 < 0)
  {
	perror("Chyba pri volani fork\n");
	exit(0);
  }
  if (pid3 == 0) 
  {  
	execlp("./p3","p3",NULL);
	printf("Chyba pri spustani procesu 3\n");
	exit(EXIT_FAILURE);
  }
  else
  {
	waitpid(pid3,NULL,0);
	sem_post(&semE);
  }
 return NULL;
}

void* vlakno_5(void* param)
{
  sem_wait(&semD);
  sem_wait(&semE);
  int pid5;
  pid5 = fork();
  if (pid5 < 0) 
  {
	perror("Chyba pri volani fork\n");
	exit(0);
  }
  if (pid5 == 0) 
  { 
	execlp("./p5","p5",NULL);
	printf("Chyba pri spustani procesu 5\n");
	exit(EXIT_FAILURE);
 }
 else
 {
  waitpid(pid5,NULL,0);
  exit(0);
 }              
 return NULL;              
}
  
/**
 *  @brief  Main funkcia programu.
 *  @param  argc Poèet parametrov
 *  @param  argv Pole parametrov
 *
 *  Main funkcia vytvor vlakna a  semaforov pre kazdy proces
 *  
 *  Následne sa vytvory prvy potomok procesu 
 *  
 *  Rodic caka na skoncenie potomka procesu, a nasledne povoli vykonavanie dalsich procesov pomocou semaforov
 */  
int main (int argc, char *argv[]) {
  
  #define POCET_VLAKIEN 4
  pthread_t thread_id[POCET_VLAKIEN];
      
  sem_init(&semA,0,0); 
  sem_init(&semB,0,0);
  sem_init(&semC,0,0);
  sem_init(&semD,0,0);
  sem_init(&semE,0,0);
  
  pthread_create(&thread_id[0], NULL,&vlakno_2, NULL);
  pthread_create(&thread_id[1], NULL,&vlakno_3, NULL);
  pthread_create(&thread_id[2], NULL,&vlakno_4, NULL);
  pthread_create(&thread_id[3], NULL,&vlakno_5, NULL);
 
  int pid,vysledok;
  
  pid = fork ();
  if ( pid < 0 ) 
  {
	perror("Chyba pri volani fork\n");
	exit(1);
  }
  if ( pid==0 ) 
  { 
	execlp("./p1","p1",NULL);
    printf("Chyba pri spustani procesu 1\n");
    exit(EXIT_FAILURE);
  }
  else  
  { 
	waitpid(pid,NULL,0);
    sem_post(&semA);
    sem_post(&semB);
	
    int i;
    for (i = 0; i < POCET_VLAKIEN; i++)
		pthread_join(thread_id[i],NULL);   
		
	sem_destroy(&semA);
	sem_destroy(&semB);
	sem_destroy(&semC);
	sem_destroy(&semD);
	sem_destroy(&semE);
    return 0;
   }
   
  exit(0);
   
} 