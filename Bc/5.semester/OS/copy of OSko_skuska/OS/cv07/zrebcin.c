#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>

pthread_mutex_t mutex;
int kap_valov,n_kobyl,stav_valov;
pthread_t sprav_t;
void* spravca(void* param){
		stav_valov = kap_valov;
		printf("Spravca naplna valov\n");
		int i;
		for(i=0;i<kap_valov;i++){
			printf("%d/%d\n",i+1,kap_valov);
			sleep(1);
		}
		printf("Spravca naplnil valov\n");
	return;
}

void* kobyla(void* param){
	while(1){
	int vyhladnutie = rand() % 15 + 5;
	sleep(vyhladnutie);
	pthread_mutex_lock(&mutex);
		if(stav_valov==0){
			printf("kobyla cislo %d erdzi\n",param);
			pthread_create(&sprav_t,NULL,&spravca,NULL);
			pthread_join(sprav_t,NULL);
			stav_valov--;
		}else{
			stav_valov--;
		}
	printf("Kobila cislo %d sa nazrala\n",param);
	printf("Vo valove zostalo jedlo pre %d kobyl\n", stav_valov);
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
	pthread_mutex_init(&mutex,NULL);
	int i;
	for(i=0;i<n_kobyl;i++){
		pthread_create(&tid[i],NULL,&kobyla,(void*)i+1);
	}
	for(i=0;i<n_kobyl;i++){
		pthread_join(tid[i],NULL);
	}
	return 0;
}
