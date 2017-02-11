/* 
 * File:   main.c
 * Author: Branko
 *
 * Created on Pondelok, 2016, may 30, 15:05
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#include <time.h>
#include <pthread.h>

#include <sys/types.h>
#include <sys/socket.h>
#include<sys/time.h>
#include <netinet/in.h>
#include <netinet/udp.h>

#include <arpa/inet.h>
#include <net/if.h>
#include<errno.h>


#define PORTFROM 70
#define PORTTO 90
#define DestAdd "127.0.0.1"

/*
 * 
 */

void *NetThread (void *i)
{
   int Socket;
     struct sockaddr_in Dest;
     int port= *((int*)i);
     struct timeval tv;
     tv.tv_sec=10;
     tv.tv_usec=0;  
  
  
 if ((Socket = socket (AF_INET, SOCK_STREAM, 0)) == -1)
    {
      perror ("socket");
      exit (EXIT_FAILURE);
    }
  memset (&Dest, 0, sizeof (Dest));
 Dest.sin_family = AF_INET;
  Dest.sin_port = htons (port);
  if (inet_aton (DestAdd, &Dest.sin_addr) == 0)
    {
      fprintf (stderr, "%s is not a valid server address.\n", Dest);
      close (Socket);
      exit (EXIT_FAILURE);
    }
  
     
     
     if(setsockopt(Socket,SOL_SOCKET,SO_RCVTIMEO,(char*)&tv,sizeof(tv))<0)
     {
         printf("setsockopt\n");
     
     }
     
     
 if (connect (Socket, (struct sockaddr *) &Dest, sizeof (Dest))==0)
    {
      //perror("connect");      
      printf("port %d je otvoreny\n", port);
      close (Socket);
       
      
    }
  else{
     
      
      if(errno==ECONNREFUSED)
          //perror("connect");   
         printf("port %d je zmaknuty\n", port);
      else{
          if(errno==ETIMEDOUT)
          {
          
             printf("port %d cas vyprsal\n", port);
              errno=EINPROGRESS;
          }
          
          
      
      }
          
  }
free(i);
}


int main(int argc, char** argv) {
    int rc;
    void* status=NULL;
    int Port;
    pthread_t *threads=(pthread_t*)malloc(sizeof(pthread_t)*(PORTTO-PORTFROM+1));
    
    for(int Port = PORTFROM;Port<=PORTTO;Port++)
    {
        int *i = malloc(sizeof(int));
	    *i=Port;
	    rc=pthread_create(&threads[Port-PORTFROM], NULL, NetThread, (void*) i);
        if(rc)
        {
            printf("nevytvorilo sa vlakno");        
        }    
    }
    
    for(int Port = PORTFROM;Port<=PORTTO;Port++)
    {
        rc = pthread_join(threads[Port-PORTFROM], status);
        if (rc)
        {
            printf("ERROR; pthread_join() is %d\n", rc);
            exit(-1);
        }
    }    
    free(threads);
    return (EXIT_SUCCESS);
}


