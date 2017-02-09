#include <pthread.h> 
#include <semaphore.h> 
#include <stdio.h>

void * spravca(void *); 
void * kobyla(void *); 
pthread_t tid[2]; 
sem_t semA, semB;
int kapacita = 20;
int pocet_kobyl = 10;
pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;

main(int argc, char *argv[])
{

sem_init(&semA, 0, 0); 
sem_init(&semB, 0, 20);
pthread_mutex_init(&mut,NULL);

pthread_create(&tid[0], NULL, spravca, NULL); 
pthread_create(&tid[1], NULL, kobyla, NULL);

pthread_mutex_destroy(&mut);
pthread_join(tid[0],NULL);
pthread_join(tid[1],NULL);

}

void * spravca(void * param)
{
int i;
 for (i = 0; i < 3; i++)
 {
  pthread_mutex_lock(&mut);
 // sem_post(&semB);
  sem_wait(&semA);
  
   printf("Spravca naplnil valov\n");
 int z;
 for (z = 0; z < 20; z++)
	sem_post(&semB);
  pthread_mutex_unlock(&mut);
  }   


}


void * kobyla(void * param)
{ 
  int j;
  for (j = 0; j < 3; j++)
  {
  while(kapacita > 0)
  {
	  sem_wait(&semB);
	  pthread_mutex_lock(&mut);
	  kapacita--;
	  
	  printf("kobyla zozrala jedlo, kapacita ostava : %d\n",kapacita);
	  pthread_mutex_unlock(&mut);
  }
		printf("Posledna kobyla zaerdzala\n");
  
		kapacita = 20;
		sem_post(&semA);
                                                                                                                             
	}
}



