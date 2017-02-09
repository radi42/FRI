#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <stdlib.h>

void signhandler(int signal){
    printf("Prisiel signal %d\n",signal);
    exit(1);
}

int main(void){

	signal(SIGINT,signhandler);
	int n=10;
	while(n--){
	    printf("%d\n",n);
	    sleep(1);
	}
	return 0;

}