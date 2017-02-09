#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t mutex;
int kap_valov,n_kobyl,stav_valov;
pthread_cond_t emp_valov,fill;

void* spravca(void* param){
		while(1){
		pthread_mutex_lock(&mutex);
		while(stav_valov>0){
			pthread_cond_wait(&emp_valov,&mutex);
		}
		stav_valov = kap_valov;
		printf("Spravca naplna valov\n");
		int i;
		for(i=0;i<5;i++){
			printf("%d/5\n",i+1,kap_valov);
			sleep(1);
		}
		printf("Spravca naplnil valov\n");
		pthread_cond_broadcast(&fill);
		pthread_mutex_unlock(&mutex);
		}
}

void* kobyla(void* param){
	while(1){
	int vyhladnutie = rand() % 15 + 5;
	sleep(vyhladnutie);
	pthread_mutex_lock(&mutex);
	while(stav_valov==0){pthread_cond_wait(&fill,&mutex);}
	stav_valov--;
	printf("Kobila cislo %d sa nazrala\n",param);
	printf("Vo valove zostalo jedlo pre %d kobyl\n", stav_valov);
	if(stav_valov==0){
		printf("kobyla cislo %d erdzi\n",param);
		pthread_cond_broadcast(&emp_valov);
		pthread_cond_wait(&fill,&mutex);
		}
	pthread_mutex_unlock(&mutex);
	}
	return;
}

void* test(void* param){
	printf("test of proces %d\n",param);
}

int main(int argc, char* argv[])
{
	kap_valov = atoi(argv[1]);
	n_kobyl = atoi(argv[2]);
	stav_valov = kap_valov;
	pthread_t tid[n_kobyl];
	pthread_t sprav_t;
	pthread_mutex_init(&mutex,NULL);
	pthread_cond_init(&emp_valov,NULL);
	pthread_cond_init(&fill,NULL);
	pthread_create(&sprav_t,NULL,&spravca,NULL);
	int i;
	for(i=0;i<n_kobyl;i++){
		pthread_create(&tid[i],NULL,&kobyla,(void*)(i+1));
	}
	for(i=0;i<n_kobyl;i++){
		pthread_join(tid[i],NULL);
	}
	pthread_join(sprav_t,NULL);
	
}
