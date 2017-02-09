#include <pthread.h> 
#include <semaphore.h> 
#include <stdio.h>

sem_t semA, semB;
int max_kapacita;
int kapacita = 0;
int pocet_kobyl;
pthread_mutex_t mut = PTHREAD_MUTEX_INITIALIZER;

void * spravca(void * param)
{
    while(1)
    {
        pthread_mutex_lock(&mut);

        kapacita = max_kapacita;
        printf("Spravca naplnil valov\n");
        int z;
        for (z = 0; z < max_kapacita; z++)
            sem_post(&semB);
        pthread_mutex_unlock(&mut);
        
        sem_wait(&semA);
        sleep(1);
    }
}

void * kobyla(void * param)
{ 
    while(1)
    {
        sem_wait(&semB);
        
        sleep(1);
        
        pthread_mutex_lock(&mut);
        if (kapacita == 0) continue;
        kapacita--;
        printf("kobyla %d zozrala jedlo, kapacita ostava : %d\n",param,kapacita);
        
        if (kapacita == 0)
        {
            printf("Posledna kobyla %d zaerdzala\n",param);

            sem_post(&semA);
        }
        
        pthread_mutex_unlock(&mut);
        sched_yield();
    }
}

main(int argc, char *argv[])
{
    pocet_kobyl = atoi(argv[1]);
    max_kapacita = atoi(argv[2]);

    sem_init(&semA, 0, 0); 
    sem_init(&semB, 0, 0);
    pthread_mutex_init(&mut,NULL);
    
    pthread_t tid;
    pthread_t zvierata[pocet_kobyl]; 	
 
    pthread_create(&tid, NULL, spravca, NULL); 

    int i;
    for (i = 1; i <= pocet_kobyl; i++)
    {
        pthread_create(&zvierata[i], NULL, kobyla, (void *)i);
    }

    for (i = 1; i <= pocet_kobyl; i++)
        pthread_join(zvierata[i], NULL);

    pthread_join(tid,NULL);
    pthread_mutex_destroy(&mut);
    return 0;
}