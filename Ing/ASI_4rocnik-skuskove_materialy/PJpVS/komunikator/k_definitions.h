#include <semaphore.h>

#ifndef K_DEFINITIONS_H
#define	K_DEFINITIONS_H

#ifdef	__cplusplus
extern "C" {
#endif

#define BUFFER_LENGTH 300
extern char *endMsg;

typedef struct data {
    char userName[10];
    sem_t sem;
    int socket;
    int stop;
} DATA;

void stop(DATA *data);
int isStopped(DATA *data);
int printError(char *str);
void *writeData(void *data);

#ifdef	__cplusplus
}
#endif

#endif	/* K_DEFINITIONS_H */

