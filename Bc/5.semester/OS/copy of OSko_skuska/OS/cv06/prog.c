#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <fcntl.h>
#include <sched.h>

#define BUFSIZE 2048

int main(int argc, char * argv[]) {

 int fdpipe[2]; // 0 - citanie, 1 - zapis
 int pid, status, fd;
 char buf[BUFSIZE];
 size_t count;
        
  if (pipe(fdpipe) < 0) {
      perror("Chyba pri volani pipe:");
      exit(1);
    }
                
  switch(pid=fork()) {
  case -1: // chyba pri vloani fork()
    perror("Chyba pri volani fork:");
    exit(1);
  case 0: // kod potomka
      close(fdpipe[1]);  // DOLEZITE!!!
      close(0); // zatvorime standardny vstup
      dup2(fdpipe[0], 0); // zduplikuj deskriptor rury do deskriptora stdin
      execl("/usr/bin/wc", "/usr/bin/wc", (char *) NULL);
      perror("Chyba pri volani execl:");
      exit(1);
 default: // kod predka
    if ((fd = open("/home/orjesek/.bashrc", O_RDONLY)) == -1) {
	  perror("Chyba pri otvarani suboru:");
          exit(1);
        }
while((count = read(fd, buf, BUFSIZE)) > 0) {
  write(fdpipe[1], buf, count);
 }
  close(fdpipe[1]); // DOLEZITE!!!!
  wait(&status); // pockame na dokoncenie potomka
  printf("Potomok ukonceny.\n");
} // switch
} // main