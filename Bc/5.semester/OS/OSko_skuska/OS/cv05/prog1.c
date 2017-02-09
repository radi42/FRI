#include <stdio.h>
#include <unistd.h>

int main(void){
	printf("Start\n");
	pid_t pid = fork();
	
	if(pid > 0)
	{
		printf("Parent\n");
		int status;
		waitpid(pid, &status, 0);
	}
	else if (pid == 0)
	{
		printf("Child\n");
	}
	else perror("Fork");
	
	printf("Done\n");
	return 0;
}