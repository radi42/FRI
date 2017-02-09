#include <stdio.h>
#include <pthread.h>

#define KLIENTOV	5
#define POCET_CISIEL    20

long int cislo, je_nove_cislo=0, precitalo=0;
pthread_mutex_t MUTEX;
pthread_cond_t nove_cislo, vsetci_precitali;

 
void * generuj(void * param) {
  int i;
  for(i=0; i < POCET_CISIEL; i++) {

	pthread_mutex_lock(&MUTEX);
	cislo = random() % 100;
	printf("Server vygeneroval nove cislo %d\n", cislo);
        je_nove_cislo = 1;
	pthread_cond_broadcast(&nove_cislo);

	while(precitalo < KLIENTOV) {
		pthread_cond_wait(&vsetci_precitali, &MUTEX);
	}
	precitalo = 0;
	pthread_mutex_unlock(&MUTEX);
	printf("vsetci klienti precitali cislo, kolo %d sa skoncilo\n", i);
        sleep(random() % 3);

  } /* for */
}

void * klient(void * param) {

  int i, id;
  id = *(int *)param;
  for(i = 0; i < POCET_CISIEL; i++) {
	pthread_mutex_lock(&MUTEX);
        while(je_nove_cislo != 1) {
		pthread_cond_wait(&nove_cislo, &MUTEX);
	}
	printf("klient c. %d prevzal cislo %d\n", id, cislo);
	
	if (++precitalo >= KLIENTOV) {
		je_nove_cislo = 0;
		/* precitalo = 0; */
		pthread_cond_broadcast(&vsetci_precitali);
	}
	else {
		pthread_cond_wait(&vsetci_precitali, &MUTEX);
	}

	pthread_mutex_unlock(&MUTEX);
	sleep(random() % 3);

  } /* for */

}

int main(int argc, char * argv[]) {

  int poradie[KLIENTOV], i;
  pthread_t klienti[KLIENTOV];
  pthread_t generator;

  precitalo = 0;
  
  if (pthread_mutex_init(&MUTEX, NULL) != 0 ) {
	perror("chyba pri vytvarani mutexu");
	exit(1);
  }

  pthread_cond_init(&nove_cislo, NULL);
  pthread_cond_init(&vsetci_precitali, NULL);

  if (pthread_create(&generator, NULL, generuj, NULL) != 0) {
	perror("nepodarilo sa vytvorit generator");
  }
  
 for(i = 0; i < KLIENTOV; i++) {
	poradie[i] = i+1;
	if (pthread_create(&klienti[i], NULL, klient, &poradie[i]) != 0) {
	  perror("nepodarilo sa vytvorit klienta ");
	  exit(1);
	}
  } /* for */
 
  for(i = 0; i < KLIENTOV; i++) {
   if (pthread_join(klienti[i], NULL) != 0) {
	perror("chyba pri joine!");
	exit(1);
  	}
  }

  if (pthread_join(generator,  NULL) !=0) {
	perror("chyba pri joine!");
	exit(1);
  } /* if */

    pthread_mutex_destroy(&MUTEX);
    pthread_cond_destroy(&nove_cislo);
    pthread_cond_destroy(&vsetci_precitali);


}
