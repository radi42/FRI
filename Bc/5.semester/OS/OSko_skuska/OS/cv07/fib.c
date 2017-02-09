#include <pthread.h>
#include <stdio.h>

struct thread_args{
    int *cislo;
};

void *thread_func(void *arg){
    int i = 1;
    while(i<10){
	printf("fib(%u) = %u\n",i,fib(i));
	i++;
    }
}

int main(int argc, char* argv[]){
    
    pthread_t pth;
    int i=0;
    pthread_create(&pth,NULL,thread_func,NULL);
    
    pthread_join(pth,NULL);
    return 0;
}

int fib(x){
    if(x == 1 || x == 2)return 1;
    return fib(x-1) + fib(x-2);
}