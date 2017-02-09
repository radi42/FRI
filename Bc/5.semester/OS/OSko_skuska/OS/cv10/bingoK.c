#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>

#define MEM_SZ 4096 // velkost zdielaneho segmentu
#define POCET_TAHOV 10

struct sharedmem_t {
	int cislo;
};

struct semun{
	int val;
	struct semid_ds *buf;
	unsigned short *array;
	struct seminfo *_buf;
};

int main (int argc, char *argv[])
{

	void *shared_memory = (void *)0;
	struct sharedmem_t *shared_data;
	int shmid;
	srand((unsigned int)getpid());
	
	/* Vytvorenie zdielaneho segmentu */
	
	shmid = shmget((key_t)1234, MEM_SZ, 0666 | IPC_CREAT);
	shared_memory = shmat(shmid, (void *)0, 0);
	shared_data = (struct sharedmem_t *)shared_memory;
	
	//semafor
	
	int sem_id;
	struct semun sem_val;
	struct sembuf* set;
	set = (struct sembuf*) malloc(sizeof(struct sembuf));
	sem_id=semget((key_t)5834,0,0666|IPC_CREAT);
	int tah=1;
	
	while(tah<=POCET_TAHOV) {

		set->sem_op = -1;
		set->sem_num = 1;
		set->sem_flg = SEM_UNDO;
		semop(sem_id,set,1);

		printf("Waiting for number\n");
		sleep(2);		
		printf("Round %d. number: %d\n",tah, shared_data->cislo);

		set->sem_op = 0;
		set->sem_num = 1;
		set->sem_flg = SEM_UNDO;
		semop(sem_id,set,1);
		
		set->sem_op = 1;
		set->sem_num = 0;
		set->sem_flg = SEM_UNDO;
		semop(sem_id,set,1);
		tah++;
	
	}
	shmctl(shmid, IPC_RMID, 0);	
	shmdt(shared_memory);
	exit(EXIT_SUCCESS);
}