#include <stdio.h>
#include <unistd.h>

int main(void){
	execlp("ls","ls","-lsa");
	printf("Koniec\n");
	return 0;
}