#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <sched.h>
#define NUM_THREADS 2

pthread_t sutaziaci[5];
pthread_t gen_cisla;
int cislo = 0;
int gen_cislo = 0;
int bignum = 0;
pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond_gen = PTHREAD_COND_INITIALIZER;
pthread_cond_t cond_hrac = PTHREAD_COND_INITIALIZER;



void * generator(void * parm) {
int j=0;
for(j=0;j<10;j++) {
  pthread_mutex_lock(&mut);
  
  
  sleep(1);
  srand ( time(NULL) );
  cislo = rand() % 80 + 1;
  printf("vygenerovane cislo: %d\n", cislo);
  gen_cislo = 1;
  pthread_cond_broadcast(&cond_gen);
  
   while(bignum < 5) {
   pthread_cond_wait(&cond_hrac, &mut);	
   } 
   bignum = 0;
  
  pthread_mutex_unlock(&mut);
 sched_yield();
  }
}
                                            
void * hrac(void * param) {
  int k;
    for(k=0;k<10;k++){
    
      pthread_mutex_lock(&mut);
      while (gen_cislo != 1 ) {
          pthread_cond_wait(&cond_gen, &mut);
      }

      printf("hrac: %d ", param);
      printf("precital cislo: %d\n", cislo);
      bignum++;
     
      if (bignum >= 5) {
         gen_cislo = 0;
         pthread_cond_broadcast(&cond_hrac);
      }
      else
       pthread_cond_wait(&cond_hrac, &mut);
      pthread_mutex_unlock(&mut);
     sched_yield();
     }
}

main( int argc, char *argv[] ) {
  int i=0;
  pthread_mutex_init(&mut,NULL);
  pthread_cond_init(&cond_hrac,NULL);
  pthread_cond_init(&cond_gen,NULL);  
  
  pthread_create(&gen_cisla, NULL, generator, NULL); 

  for (i = 1; i <= 5; i++)
  {
   
    pthread_create(&sutaziaci[i], NULL, hrac, (void *)i);
 
 }
  for (i = 1; i <= 5; i++)
      pthread_join(sutaziaci[i], NULL);
 
   pthread_join(gen_cisla, NULL);
   pthread_mutex_destroy(&mut);
   pthread_cond_destroy(&cond_gen);
   pthread_cond_destroy(&cond_hrac);
  
   return 0;
}