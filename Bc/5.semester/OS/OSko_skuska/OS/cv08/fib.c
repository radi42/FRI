#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>

int fib(int n)
{
if(n == 0) return 1;
if(n == 1) return 1;
return fib(n-2) + fib(n-1);
}

typedef struct _fib_data
{
int fib_arg;
int* pfree_threads;
pthread_mutex_t* pconsole_mutex;
pthread_mutex_t* pstart_mutex;
} fib_data;

void* thread_main(void* param)
{
fib_data data = *(fib_data*)param;
free(param);

int result = fib(data.fib_arg);

pthread_mutex_lock(data.pconsole_mutex);
printf("  fib(%d) = %d\n", data.fib_arg, result);
pthread_mutex_unlock(data.pconsole_mutex);

pthread_mutex_lock(data.pstart_mutex);
++(*data.pfree_threads);
pthread_mutex_unlock(data.pstart_mutex);

return NULL;
}

int main(int argc, const char* argv[])
{
int max_fib = 40;
int max_threads = (argc>1)?atoi(argv[1]):4;
if(max_threads == 0) max_threads = 4;

pthread_mutex_t console_mutex, start_mutex;
pthread_mutex_init(&console_mutex, NULL);
pthread_mutex_init(&start_mutex, NULL);


int free_threads = max_threads;
int f;

for(f=max_fib; f!=0; --f)
{
while(1)
{
pthread_mutex_lock(&start_mutex);
int found = free_threads;
pthread_mutex_unlock(&start_mutex);
if(found) break;
}
pthread_t t;
fib_data* pdata = malloc(sizeof(fib_data));
pdata->fib_arg = f-1;
pdata->pfree_threads = &free_threads;
pdata->pconsole_mutex = &console_mutex;
pdata->pstart_mutex = &start_mutex;

pthread_mutex_lock(&start_mutex);
--free_threads;
pthread_mutex_unlock(&start_mutex);
pthread_create(&t, NULL, thread_main, pdata);
pthread_detach(t);
}
while(1)
{
pthread_mutex_lock(&start_mutex);
int done = free_threads == max_threads;
pthread_mutex_unlock(&start_mutex);
if(done) break;
}
printf("Done\n");

pthread_mutex_destroy(&start_mutex);
pthread_mutex_destroy(&console_mutex);

return 0;
}