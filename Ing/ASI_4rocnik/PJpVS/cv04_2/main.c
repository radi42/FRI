/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, októbra 26, 10:40
 */

#include <stdio.h>
#include <stdlib.h>
#include "cv04.h"

/*
 * Nacitat z klavesnice kym nezadam nulu hocijakej velkosti po zadani nuly a potom vypisat
 */
int a;
int velkostPola (int pole[])
{  
    int velkostPola = 0 ;  
    while(pole[velkostPola]!=0)
    {
        velkostPola++;
    }  
        return velkostPola;
}
 
void zmenVelkostPola(int *pole[], int staraVelkost, int novaVelkost)
{
 if(novaVelkost > staraVelkost)
 {
     int *novePole = (int *)calloc(novaVelkost,sizeof(int));
     for (int i =0 ; i<staraVelkost; i++)
     {
         novePole[i]=(*pole[i]);
     }
     free(*pole);
     *pole = novePole;
 }
}
 
void vymenPolia(int *pole1[], int *pole2[])
{
    int *pomPole = *pole1;
    *pole1 = *pole2;
    *pole2 = pomPole;
}
 
int main(int argc, char** argv) {
    int n, n2;
   
    printf ("Zadaj velkost pola \n");
    scanf ("%i", &n);
   
    int *pole1 = (int *)calloc(n,sizeof(int));
   
    naplnPole(pole1, n, 10, 90);  
    vypisPole(pole1,n);
   
     printf ("Zadaj velkost pola \n");
    scanf ("%i", &n2);
   
    int *pole2 = (int *)calloc(n2,sizeof(int));
    naplnPole(pole2, n2, 10, 90);  
    vypisPole(pole2,n2);
   
    vymenPolia(&pole1,&pole2);
   
    printf("\nPo vymene: \n");
   
    vypisPole(pole1,n2);
    vypisPole(pole2,n);
   
    printf("Dlzka pola 1 je: %i",velkostPola(pole1));
    printf("Dlzka pola 2 je: %i",velkostPola(pole2));
       
    free(pole1);
    free(pole2);
    return (EXIT_SUCCESS);
}