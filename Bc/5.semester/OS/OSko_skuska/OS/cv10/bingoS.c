#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>

#define MEM_SZ 4096
#define NUM_KLIENTOV 1
#define POCET_TAHOV 10

struct sharedmem_t { /* vlastna struktura zdielanej pamate */
	int cislo; /* vytiahnute cislo */
};

struct semun{
	int val;
	struct semid_ds *buf;
	unsigned short *array;
	struct seminfo *_buf;
};



int main (int argc, char *argv[])
{
	int tahy = 1;
	int sem_id;
	void *shared_memory = (void *)0;
	struct sharedmem_t *shared_data;
	int shmid;
	/* vytvorenie zdielaneho segmentu */
	shmid = shmget((key_t)1234, MEM_SZ, 0666 | IPC_CREAT);
	if (shmid == -1) {
		fprintf(stderr, "shmget error\n");
		exit(EXIT_FAILURE);
	}
	shared_memory = shmat(shmid, (void *)0, 0);
	if (shared_memory == (void *)-1) {
		fprintf(stderr, "shmat error \n");
		exit(EXIT_FAILURE);
	}
	
	shared_data = (struct sharedmem_t *)shared_memory;
	
	//semafor
	
	struct semun sem_val;
	struct sembuf* set;
	set = (struct sembuf*) malloc(sizeof(struct sembuf));
	sem_id=semget((key_t)5834,2,0666|IPC_CREAT);
	semctl(sem_id,0,SETVAL,0);
	semctl(sem_id,1,SETVAL,0);
	
	while(1) {
		
		printf("Generating number\n");
		sleep(2);
		int nahodicka = rand() % 100;				
		printf("Round %d. number: %d\n",tahy,nahodicka);
		shared_data->cislo = nahodicka; // zapis do zdielanej pamate
		
		set->sem_op= NUM_KLIENTOV;
		set->sem_num = 1;
		set->sem_flg=SEM_UNDO;
		semop(sem_id,set,1);
		
		if(tahy==POCET_TAHOV){
			semctl(sem_id,0,IPC_RMID);
			shmdt(shared_memory);
			exit(EXIT_SUCCESS);
		}
		
		set->sem_op= - NUM_KLIENTOV;
		set->sem_num=0;
		set->sem_flg=SEM_UNDO;
		semop(sem_id,set,1);
		
		
		tahy++;
	}
	
}