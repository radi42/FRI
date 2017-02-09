#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

const int DEF_THREAD_COUNT = 4;
const int DEF_FIB_MAX = 40;

typedef struct fib_params
{
	int n;
	int result;
	pthread_mutex_t *access;
	int work;
} fib_params_t;

int fib(int n)
{
	//printf("calculating fib(%d)\n", n);
	
	if (n <= 0)
		return 0;
	else if (n == 1)
		return 1;

	return fib(n - 1) + fib(n - 2);
}

void *fib_thread(void *param)
{
	fib_params_t *fib_params = (fib_params_t *)param;
    
	while (fib_params->work == 1)
	{
        //printf("in loop, sleeping\n");
		sleep(1);
        //printf("locking mutex\n");
		pthread_mutex_lock(fib_params->access);
        //printf("checking fib_params->n\n");
		if (fib_params->n != -1)
		{
            //printf("fib_params->n == %d\n", fib_params->n);
			fib_params->result = fib(fib_params->n);
			//printf("fib(%d) = %d\n", fib_params->n, fib_params->result);
            fib_params->n = -1;
		}
		pthread_mutex_unlock(fib_params->access);
	}
	printf("thread ends\n");
    
    pthread_mutex_destroy(fib_params->access);
    
    return NULL;
}

int main (int argc, char *argv[]) {
    int thread_count = DEF_THREAD_COUNT;
	int max_n = DEF_FIB_MAX;
    if (argc > 1)
        thread_count = atoi(argv[1]);
    if (argc > 2)
        max_n = atoi(argv[2]);
    if (thread_count == 0)
        thread_count = DEF_THREAD_COUNT;
    if (max_n == 0)
        max_n = DEF_FIB_MAX;
    
    printf("Calculating Fibbonaci from 0 to %d\n", max_n);
    printf("Creating %d threads\n", thread_count);
	fib_params_t params[thread_count];
	int i;
	for (i = 0; i < thread_count; i++)
	{
		params[i].work = 1;
        params[i].n = -1;
        params[i].result = -1;
        params[i].access = (pthread_mutex_t *)malloc(sizeof(pthread_mutex_t));
		pthread_mutex_init(params[i].access, NULL);
        pthread_t thread_id;
		pthread_create(&thread_id, NULL, &fib_thread, &params[i]);
        pthread_detach(thread_id);
	}
	
	int j;
	for (i = 0; i < max_n; i += thread_count) 
	{
        int work_threads = thread_count;
        if (work_threads > (max_n - i))
            work_threads = (max_n - i);
        
		//printf("iter: %d\n", i);
		for (j = 0; j < work_threads; j++)
		{
			int calc = i + j;
			//printf("calc fib(%d)\n", calc);
			pthread_mutex_lock(params[j].access);
			params[j].n = calc;
			pthread_mutex_unlock(params[j].access);
		}

		//printf("end for 1.\n");
		
		for (j = 0; j < work_threads; j++)
		{
			//printf("waiting for result of %d.thread\n", j);
			while(params[j].result == -1)
			{
				sleep(1);
			}
		}
		
		//printf("end for 2.\n");
		
		for (j = 0; j < work_threads; j++)
		{
			printf("fib(%d) = %d\n", i + j, params[j].result);
			params[j].result = -1;
		}
	}	

	for (i = 0; i < thread_count; i++)
	{
		params[i].work = 0;
	}

	printf("END\n");
	return 0;
}