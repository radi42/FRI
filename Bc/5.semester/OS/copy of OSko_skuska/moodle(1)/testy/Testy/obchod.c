#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>

/* celkovy pocet kosikov  */
#define POC_KOSIKOV 3
/* celkovy pocet pokladni */
#define POC_POKLADNI 2
/* max. interval  medzi prichodom 2 zakaznikov */
#define PRICHOD 2000
/* max. doba nakupu 1 zakaznika */
#define NAKUP 5000
/* doba obsluhy zakaznika pri pokladni */
#define OBSLUHA 3000
/* program skonci po obsluzeni POC_ZAK zakaznikov */
#define POC_ZAK 6

pthread_mutex_t mutx_k; /* mutex na tesovanie volnych kosikov   */
pthread_mutex_t mutx_p; /* mutex na tesovanie volnych pokladni  */
pthread_mutex_t mutx_i; /* mutex na pristup k poradiu zakaznika */

pthread_cond_t cond_k = PTHREAD_COND_INITIALIZER; /* podmienka pre kosiky   */
pthread_cond_t cond_p = PTHREAD_COND_INITIALIZER; /* podmienka pre pokladne */
pthread_cond_t cond_i = PTHREAD_COND_INITIALIZER; /* podmienka pre poradie  */

int kosiky = POC_KOSIKOV;      /* pocet volnych kosikov  */
int pokladne = POC_POKLADNI;   /* pocet volnych pokladni */
int i;  /* kolko zakaznikov uz vstupilo */

void *zakaznik(void *);
void rndsleep(int maxdelay);

int main(void) 
{
pthread_t zak[POC_ZAK]; /* vlakna zakaznikov */

 pthread_mutex_init(&mutx_k,NULL);
 pthread_mutex_init(&mutx_p,NULL);
 pthread_mutex_init(&mutx_i,NULL);
 
 /* Postupne budu prichadzat zakaznici: */
 for (i=0; i< POC_ZAK; i++) {
   rndsleep(PRICHOD);  /* doba medzi vstupm 2 zakaznikov */

   pthread_mutex_lock(&mutx_i);
   if (pthread_create(&(zak[i]),NULL,zakaznik,NULL)) {
     pthread_mutex_unlock(&mutx_i);
     printf("Chyba pri tvorbe vlakna %d. zakaznika",i+1);
     break;
   }
   pthread_cond_wait(&cond_i, &mutx_i);
   pthread_mutex_unlock(&mutx_i);
 }
 
 /* Pockame kym dobehnu vsetky vytvorene vlakna: */
 for (i--; i>=0; i--) pthread_join(zak[i],NULL);
 
 i = 0;
 /* Zrusime mutexy: */
 if (pthread_mutex_destroy(&mutx_i)) {
   puts("mutx_i destroy error");
   i=1;
 }
 if (pthread_mutex_destroy(&mutx_k)) {
   puts("mutx_k destroy error");
   i=1;
 }
 if (pthread_mutex_destroy(&mutx_p)) {
   puts("mutx_p destroy error");
   i=1;
 }
 return(i);
}

void *zakaznik(void *param)
{
int poradie;  /* kolkeho zakaznika vlakno predstavuje */

 /* Zistime kolkeho zakaznika vlakno predstavuje: */
 pthread_mutex_lock(&mutx_i);
 poradie = i+1;
 pthread_cond_signal(&cond_i);
 pthread_mutex_unlock(&mutx_i);
 printf("z%d caka kosik\n",poradie);
 
 /* Zakaznik pocka na volny kosik: */
 pthread_mutex_lock(&mutx_k);
 while (kosiky == 0) pthread_cond_wait(&cond_k, &mutx_k);
 kosiky--;
 pthread_mutex_unlock(&mutx_k);
 printf("\tz%d dostal kosik\n",poradie);
 
 /* Zakaznik si naplni kosik */
 rndsleep(NAKUP);
 
 /* Zakaznik caka na volnu pokladnu */
 printf("\t\tz%d caka pokl.\n",poradie);
 pthread_mutex_lock(&mutx_p);
 while (pokladne == 0) pthread_cond_wait(&cond_p, &mutx_p);
 pokladne--;
 pthread_mutex_unlock(&mutx_p);
 printf("\t\t\tz%d dostal pokl.\n",poradie);
 
 /* Zakaznik je obsluhovany pri pokladni */
 rndsleep(OBSLUHA);
 
 /* Zakaznik odchadza, uvolni pokladnu aj kosik: */
 pthread_mutex_lock(&mutx_p);
 pokladne++;
 pthread_cond_signal(&cond_p);
 pthread_mutex_unlock(&mutx_p);
 
 pthread_mutex_lock(&mutx_k);
 kosiky++;
 pthread_cond_signal(&cond_k);
 pthread_mutex_unlock(&mutx_k);
 printf("\t\t\t\tz%d odisiel\n",poradie);
}

/* Nahodne oneskorenie najviac o maxdelay milisekund */
void rndsleep(int maxdelay)
{
struct timespec delay;
long rnd_time;

  rnd_time = 1 + (int) ((float)maxdelay*rand()/(RAND_MAX+1.0));
  delay.tv_nsec = 1000000 * (rnd_time % 1000);
  delay.tv_sec = (int)(rnd_time/1000);
  nanosleep(&delay,NULL);
  //printf(" wait %i\n",delay.tv_nsec);
}