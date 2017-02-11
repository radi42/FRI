#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    int den,mesiac,rok,priestupny,maxDen;

    printf("Zadaj den, mesiac a rok (od-enter-uj) \n");
    scanf("%d",&den);
    scanf("%d",&mesiac);
    scanf("%d",&rok);
    if(rok<=1900)
    {
	printf("rok je neplatny\n");
	return 0;
    }
    
    if(mesiac<1 || mesiac>12)
    {
	printf("mesiac je neplatny\n");
	return 0;
    }

    if(den<1 || den>31)
    {
	printf("den je neplatny\n");
	return 0;
    }

    if((rok%4==0 && rok%100!=0) || rok%400==0)
	priestupny=1;
    else
	priestupny=0;

    if(priestupny==1)
	printf("rok je priestupny.\n");
    if(priestupny==0)
	printf("rok nie je priestupny.\n");

    switch(mesiac)	/*case musi byt po jednom mesiaci!!!*/
    {
	case 1,3,5,7,8,10,12:
	    maxDen=31;
	break;
	case 4,6,9,11:
	    maxDen=30;
	break;
	case 2:
	    if(priestupny==1 && den>29) {printf("datum je neplatny.\n"); return 0;}
	    else if(priestupny==0 && den>28) {printf("datum je neplatny.\n"); return 0;}
	break;
	if(den<=maxDen)
    }

    return 0;
}