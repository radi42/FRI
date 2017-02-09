/**
 *  @file   sem.c
 *  @brief  Subor obsahujuci funkciu main
 */
 
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <semaphore.h> 
#include <time.h>
#include <math.h>
#include <string.h>
#include <unistd.h>


/** @brief Deklaracia semafora A*/   
sem_t semA;

/** @brief Deklaracia semafora B*/  
sem_t semB;

/** @brief Deklaracia semafora C*/  
sem_t semC;

/** @brief Deklaracia semafora D*/  
sem_t semD;

/** @brief Deklaracia semafora E*/  
sem_t semE;


/**
 *  @brief  Vlakno 2
 *
 *  Vlakno vlakno_2 caka na ukoncenie prveho procesu pomocou semafora semA.
 *
 *  Ak bol ukonceny spusti sa novy proces. Rodic caka na ukoncenie potomka.
 *
 *  Potomok tvori druhy proces v nasom orientovanom grafe.
 */ 
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

/**
 *  @brief  Vlakno 4
 *
 *  Vlakno vlakno_4 caka na ukoncenie prveho procesu pomocou semafora semB.
 *
 *  Ak bol ukonceny spusti sa novy proces. Rodic caka na ukoncenie potomka.
 *
 *  Potomok tvori stvrty proces v nasom orientovanom grafe.
 */ 
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

/**
 *  @brief  Vlakno 3
 *
 *  Vlakno vlakno_3 caka na ukoncenie druheho procesu pomocou semafora semC.
 *
 *  Ak bol ukonceny spusti sa novy proces. Rodic caka na ukoncenie potomka.
 *
 *  Potomok tvori treti proces v nasom orientovanom grafe.
 */ 
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

/**
 *  @brief  Vlakno 5
 *
 *  Vlakno vlakno_5 caka na ukoncenie tretieho a stvrteho procesu pomocou semafora semD a semE.
 *
 *  Ak bol ukonceny spusti sa novy proces. Rodic caka na ukoncenie potomka.
 *
 *  Potomok tvori piaty proces v nasom orientovanom grafe.
 */ 
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
 *  @param  argc Pocet parametrov
 *  @param  argv Pole parametrov
 *
 *  Main funkcia vytvory vlakna a semafory pre kazdy proces
 *  
 *  Následne sa vytvory prvy potomok procesu 
 *  
 *  Rodic caka na skoncenie potomka procesu, a nasledne povoli vykonavanie dalsich procesov pomocou semaforov
 */  
int main (int argc, char *argv[]) {
  
  
  /** definovanie poctu vlakien  */
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