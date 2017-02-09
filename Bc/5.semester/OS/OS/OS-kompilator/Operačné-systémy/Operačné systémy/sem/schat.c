/**
* SEMESTRALKA Z OPERACNYCH SYSTEMOV
*
*	  SimpleChat by Mek
*	  ^^^^^^^^^^^^^^^^^
*	  Autor: Matej Kurpel
*	  Kruzok: 5ZI035
*
**/

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <ncurses.h>
#include <signal.h>
#include <fcntl.h>

#define PORT "56000"
#define BUFFER_SIZE 1024

// globalne premenne
int i,x,y;
const char* uhore_t=" SimpleChat - semestralna praca z OS     FRI UNIZA 2008    Matej Kurpel, 5ZI035 ";
const char* udole_t=" /q - Koniec                                                                    ";
const char* udole_t2=" Ctrl-C - Koniec                                                                ";
WINDOW *hore,*bhore,*dole,*uhore,*udole; // bhore je len ramcek, hore je to, do coho piseme (invisible)
char nick[10];

void koniec(int val)
{
	endwin();
	exit(val);
} 

void ncurses_rezim(void)
{
	initscr();
	keypad(stdscr,TRUE);
	cbreak();
	if(has_colors()==FALSE)
	{
		endwin();
		printf("Tvoj terminal nepodporuje farby!\n");
		exit(1);
	}
	start_color();nonl();
	init_color(COLOR_WHITE,1000,1000,1000);
	init_pair(1,COLOR_WHITE,COLOR_BLUE);
	init_pair(2,COLOR_WHITE,COLOR_BLACK);
	init_pair(3,COLOR_GREEN,COLOR_BLACK);
	init_pair(4,COLOR_RED,COLOR_BLACK);

	do {
	attrset(COLOR_PAIR(2));
	printw("Zadaj svoj nick: ");
	attrset(COLOR_PAIR(3));
	getnstr(nick,10);
	attrset(COLOR_PAIR(0));
	} while (strcmp(nick,"")==0);

	bhore=newwin(19,80,1,0);
	wborder(bhore,0,0,0,0,0,0,0,0);
	wrefresh(bhore);
	hore=newwin(17,77,2,2);
	scrollok(hore,TRUE);
	dole=newwin(3,80,20,0);
	scrollok(dole,TRUE);
	keypad(dole,TRUE);
	wborder(dole,0,0,0,0,0,0,0,0);
	wrefresh(dole);
	uhore=newwin(1,80,0,0);
	udole=newwin(1,80,23,0);
	wattrset(uhore,COLOR_PAIR(1));
	wattrset(udole,COLOR_PAIR(1));
	wprintw(uhore,uhore_t);
	wrefresh(uhore);
	wrefresh(udole);
	
	signal(SIGINT,koniec); // pri ctrl-c sa konzola stihne vratit do normalu
	signal(SIGTERM,koniec); // pri poziadavke na ukoncenie
}

char* spoj(char *co, char *s_cim)
{
	char *zal;
	zal=(char *)malloc(255*sizeof(char));
	sprintf(zal,"%s%s",co,s_cim);
	return zal;
}

void pouzitie(char *prog)
{
	fprintf(stderr,"\nPriklady pouzitia:\n");
	fprintf(stderr,"^^^^^^^^^^^^^^^^^^\n");
	fprintf(stderr,"%s -s %s          - spusti server na porte %s\n",prog,PORT,PORT);
	fprintf(stderr,"%s -c frios %s    - pripoji sa na server na adrese frios:%s\n\nDefaultny port je %s.\n\n",prog,PORT,PORT,PORT);
	koniec(1);
}

void *get_in_addr(struct sockaddr *sa)
{
	// vrati sockaddr, IPv4 ci IPv6:
	if (sa->sa_family == AF_INET) {
		return &(((struct sockaddr_in*)sa)->sin_addr);
	}

	return &(((struct sockaddr_in6*)sa)->sin6_addr);
}

int main(int argc, char *argv[])
{
	if ((argc<2) || ((strcmp(argv[1],"-s")!=0) && (strcmp(argv[1],"-c")!=0)) )
	{
		pouzitie(argv[0]);
	}
	
	char *port=PORT;
	int pip[2]; // nasa pipa na synchronizaciu zapisu do chat. okna
	char pipmsg[255]=""; // to, co bude chodit cez pipu
	char *wnick; // kompletny retazec s nickom i spravou, tak ako sa bude posielat
	int deffarba=1; // na ofarbenie nickov
	
	wnick=(char *)malloc(255*sizeof(char));
    if (strcmp(argv[1],"-s")==0)
    {
		// SERVER
		int sockfd,new_fd,numbytes;  // listen: sock_fd, nove spojenia: new_fd
		struct addrinfo hints,*servinfo,*p;
		struct sockaddr_storage their_addr; // info protistrany
		socklen_t sin_size;
		int yes=1;
		char s[INET6_ADDRSTRLEN];
		int rv,fid;
		char sprava[BUFFER_SIZE];

		if (argv[2]!=NULL)
		{
			port=(char *)malloc(strlen(argv[2])+1);
			strcpy(port,argv[2]);
		} else {
			port=(char *)malloc(strlen(PORT)+1);
			strcpy(port,PORT);
		}
		
		memset(&hints,0,sizeof hints);
		hints.ai_family=AF_UNSPEC;
		hints.ai_socktype=SOCK_STREAM;
		hints.ai_flags=AI_PASSIVE;

		if ((rv=getaddrinfo(NULL,port,&hints,&servinfo))==-1)
		{
			fprintf(stderr,"getaddrinfo: %s\n",gai_strerror(rv));
			exit(1);
		}

		for(p=servinfo;p!=NULL;p=p->ai_next)
		{
			if ((sockfd=socket(p->ai_family,p->ai_socktype,p->ai_protocol))==-1)
			{
				perror("socket");
				continue;
			}

			if (setsockopt(sockfd,SOL_SOCKET,SO_REUSEADDR,&yes,sizeof(int))==-1)
			{
				perror("setsockopt");
				exit(1);
			}

			if (bind(sockfd,p->ai_addr,p->ai_addrlen)==-1)
			{
				close(sockfd);
				perror("server: bind");
				continue;
			}
			break;
		}

		if (p==NULL)
		{
			fprintf(stderr,"chyba: bind\n");
			exit(2);
		}

		freeaddrinfo(servinfo);

		if (listen(sockfd,0)==-1)
		{
			perror("listen");
			koniec(1);
		}

		ncurses_rezim();
		
		while (1)
		{
			curs_set(0);
			wprintw(hore,"*** Cakam na pripojenie klienta...\n");
			wrefresh(hore);
			mvwprintw(udole,0,0,udole_t2);
			wrefresh(udole);

			sin_size=sizeof their_addr;
			new_fd=accept(sockfd,(struct sockaddr *)&their_addr,&sin_size);
			if (new_fd==-1)
			{
				perror("accept");
				continue;
			}

			inet_ntop(their_addr.ss_family,get_in_addr((struct sockaddr *)&their_addr),s,sizeof s);
			
			if (send(new_fd,"\x1B_1\n",5,0)==-1) perror("send");
			while (1)
			{
				// najprv sa musi dohodnut klient so serverom, az potom mozeme ist dalej
				if ((numbytes=recv(new_fd,sprava,BUFFER_SIZE-1,0))!=-1)
				{
					sprava[numbytes]='\0';
					if (strcmp(sprava,"\x1B_2\n")==0) break;
				}
			}
			
		wprintw(hore,"*** Pripojil sa klient z IP %s\n",s);
		wrefresh(hore);
		mvwprintw(udole,0,0,udole_t);
		wrefresh(udole);
			
		curs_set(1);
		
		wattrset(dole,COLOR_PAIR(3));
		mvwprintw(dole,1,2,"<%s> ",nick);
		wattrset(dole,COLOR_PAIR(0));
		wrefresh(dole);
		if (pipe(pip)==-1) perror("pipe");
		if ((fid=fork())==-1) perror("fork");
		if (fid!=0)// parent zatvori output pipy, child zatvori input pipy
		{
			close(pip[1]);
			fcntl(pip[0],F_SETFL,O_NONBLOCK);
		} else {
			close(pip[0]);
			fcntl(pip[1],F_SETFL,O_NONBLOCK);
		}
		fcntl(new_fd,F_SETFL,O_NONBLOCK);
		while (1)
		{
			if (fid!=0)
			{
			// parent, citanie
				usleep(500);
				if ((numbytes=recv(new_fd,sprava,BUFFER_SIZE-1,0))>0)
				{
					sprava[numbytes]='\0';
					getyx(dole,y,x);
					if (strcmp(sprava,"\x1BQuit\n")==0)
					{
						wprintw(hore,"*** Spojenie ukoncene.\n");
						wrefresh(hore);
						for (i=0;i<=79;i++) mvwaddch(udole,0,i,' ');
						wrefresh(udole);
						kill(fid,SIGKILL); // koniec zapisujuceho procesu, my pokracujeme
						break;
					} else {
						for (i=0;i<=strlen(sprava)-1;i++)
						{
							if (sprava[i]=='\x1B')
							{ // ofarbenie nicku druhej strany
								if (deffarba==1)
								{
									wattrset(hore,COLOR_PAIR(4));
									deffarba=0;
								} else {
									wattrset(hore,COLOR_PAIR(0));
									deffarba=1;
								}
							} else waddch(hore,sprava[i]);
						}
						wrefresh(hore); 
					}

					mvwprintw(dole,y,x,"");
					wrefresh(dole);
				}
				if ((read(pip[0],pipmsg,sizeof(pipmsg)))>0)
				{
					getyx(dole,y,x);
					for (i=0;i<=strlen(pipmsg)-1;i++)
					{
						if (pipmsg[i]=='\x1B')
						{ // ofarbenie nasho nicku
							if (deffarba==1)
							{
								wattrset(hore,COLOR_PAIR(3));
								deffarba=0;
							} else {
								wattrset(hore,COLOR_PAIR(0));
								deffarba=1;
							}
						} else waddch(hore,pipmsg[i]);
					}
					wrefresh(hore);
					mvwprintw(dole,y,x,"");
					wrefresh(dole);
					if (strcmp(pipmsg,"*** Spojenie ukoncene.\n")==0) break;
				}
			} else {
				// child, zapis
				do {
				mvwgetnstr(dole,1,5+strlen(nick),sprava,72-strlen(nick));
				} while (strcmp(sprava,"")==0);
				for (i=5+strlen(nick);i<=78;i++) mvwaddch(dole,1,i,' '); // vycisti dolne okno
				wrefresh(dole);
				if (strcmp(sprava,"/q")==0)
				{
					if (send(new_fd,"\x1BQuit\n",7,0)==-1) perror("send");
					write(pip[1],"*** Spojenie ukoncene.\n",(strlen("*** Spojenie ukoncene.\n")+1));
					for (i=0;i<=79;i++) mvwaddch(udole,0,i,' ');
					wrefresh(udole);
					kill(getpid(),SIGKILL); // koniec tohto zapisujuceho procesu
				} else {
					strcpy(wnick,spoj("\x1B<",spoj(nick,spoj(">\x1B ",spoj(sprava,"\n")))));
					if (send(new_fd,wnick,strlen(wnick)+1,0)==-1) perror("send");
					write(pip[1],wnick,strlen(wnick)+1);
				}
			}
		}
		close(new_fd);
		}
		koniec(0);
    } else {
		// KLIENT
		int sockfd,numbytes;  
		char sprava[BUFFER_SIZE];
		struct addrinfo hints,*servinfo,*p;
		int rv,fid;
		char s[INET6_ADDRSTRLEN];
		
		if (argv[3]!=NULL)
		{
			port=(char *)malloc(strlen(argv[3])+1);
			strcpy(port,argv[3]);
		} else {
			port=(char *)malloc(strlen(PORT)+1);
			strcpy(port,PORT);
		}
		
		memset(&hints,0,sizeof hints);
		hints.ai_family=AF_UNSPEC;
		hints.ai_socktype=SOCK_STREAM;

		if ((rv=getaddrinfo(argv[2],port,&hints,&servinfo))!=0)
		{
			fprintf(stderr,"getaddrinfo: %s\n",gai_strerror(rv));
			exit(1);
		}

		for(p=servinfo;p!=NULL;p=p->ai_next)
		{
			if ((sockfd=socket(p->ai_family,p->ai_socktype,p->ai_protocol)) == -1)
			{
				perror("socket");
				exit(1);
			}

			if (connect(sockfd,p->ai_addr,p->ai_addrlen)==-1)
			{
				close(sockfd);
				perror("connect");
				exit(1);
			}
			break;
		}
		inet_ntop(p->ai_family,get_in_addr((struct sockaddr *)p->ai_addr),s,sizeof s);
		ncurses_rezim();
		wprintw(hore,"*** Pripajam sa k %s\n",s);
		wrefresh(hore);

		if (p==NULL)
		{
			fprintf(stderr, "Chyba pripajania\n");
			koniec(2);
		}
		
			while(1)
			{
				// najprv sa musime dohodnut so serverom, az potom pokracujeme
				if ((numbytes=recv(sockfd,sprava,BUFFER_SIZE-1,0))!=-1)
				{
					sprava[numbytes]='\0';
					if (strcmp(sprava,"\x1B_1\n")==0)
					{
						if (send(sockfd,"\x1B_2\n",5,0)==-1) perror("send");
						break;
					}
				}
			}

		freeaddrinfo(servinfo);
		wprintw(hore,"*** Pripojene\n");
		wrefresh(hore);

		wattrset(dole,COLOR_PAIR(3));
		mvwprintw(dole,1,2,"<%s> ",nick);
		wattrset(dole,COLOR_PAIR(0));
		wrefresh(dole);
		mvwprintw(udole,0,0,udole_t);
		wrefresh(udole);
		if (pipe(pip)==-1) perror("pipe");
		if ((fid=fork())==-1) perror("fork");
		if (fid!=0)// parent zatvori output pipy, child zatvori input pipy
		{
			close(pip[1]);
			fcntl(pip[0],F_SETFL,O_NONBLOCK);
		} else {
			close(pip[0]);
			fcntl(pip[1],F_SETFL,O_NONBLOCK);
		}
		fcntl(sockfd,F_SETFL,O_NONBLOCK);
		while (1)
		{
			if (fid!=0)
			{
			// parent, citanie
				usleep(500);
				if ((numbytes=recv(sockfd,sprava,BUFFER_SIZE-1,0))>0)
				{
					sprava[numbytes]='\0';
					getyx(dole,y,x);
					if (strcmp(sprava,"\x1BQuit\n")==0)
					{
						wprintw(hore,"*** Spojenie ukoncene.\n");
						wrefresh(hore);
						kill(fid,SIGKILL); // koniec zapisujuceho procesu, my pokracujeme
						break;
					} else {
						for (i=0;i<=strlen(sprava)-1;i++)
						{
							if (sprava[i]=='\x1B')
							{ // ofarbenie nicku druhej strany
								if (deffarba==1)
								{
									wattrset(hore,COLOR_PAIR(4));
									deffarba=0;
								} else {
									wattrset(hore,COLOR_PAIR(0));
									deffarba=1;
								}
							} else waddch(hore,sprava[i]);
						}
						wrefresh(hore); 
					}

					mvwprintw(dole,y,x,"");
					wrefresh(dole);
				}
				if ((read(pip[0],pipmsg,sizeof(pipmsg)))>0)
				{
					getyx(dole,y,x);
					for (i=0;i<=strlen(pipmsg)-1;i++)
					{
						if (pipmsg[i]=='\x1B')
						{ // ofarbenie nasho nicku
							if (deffarba==1)
							{
								wattrset(hore,COLOR_PAIR(3));
								deffarba=0;
							} else {
								wattrset(hore,COLOR_PAIR(0));
								deffarba=1;
							}
						} else waddch(hore,pipmsg[i]);
					}
					wrefresh(hore);
					mvwprintw(dole,y,x,"");
					wrefresh(dole);
					if (strcmp(pipmsg,"*** Spojenie ukoncene.\n")==0) break;
				}
			} else {
				// child, zapis
				do {
				mvwgetnstr(dole,1,5+strlen(nick),sprava,72-strlen(nick));
				} while (strcmp(sprava,"")==0);
				for (i=5+strlen(nick);i<=78;i++) mvwaddch(dole,1,i,' '); // vycisti dolne okno
				wrefresh(dole);
				if (strcmp(sprava,"/q")==0)
				{
					if (send(sockfd,"\x1BQuit\n",7,0)==-1) perror("send");
					write(pip[1],"*** Spojenie ukoncene.\n",(strlen("*** Spojenie ukoncene.\n")+1));
					kill(getpid(),SIGKILL); // koniec tohto zapisujuceho procesu
				} else {
					strcpy(wnick,spoj("\x1B<",spoj(nick,spoj(">\x1B ",spoj(sprava,"\n")))));
					if (send(sockfd,wnick,strlen(wnick)+1,0)==-1) perror("send");
					write(pip[1],wnick,strlen(wnick)+1);
				}
			}
		}
		close(sockfd);
		koniec(0);
	}
	return 0; // aby sa kompilator nestazoval
}

