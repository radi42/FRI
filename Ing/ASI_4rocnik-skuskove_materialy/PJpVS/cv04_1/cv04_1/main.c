/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, októbra 19, 11:11
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */

const int dlzka = 30;


void vypisPole(int pole[], int dlzkaPola)
{
    for (int i = 0; i < dlzkaPola; i++ )
    {
        printf("%d ",pole[i]);
    }
    printf("\n");
}
 
void naplnPole(int pole[], int dlzkaPola, int a, int b)
{
   for (int k=0;k<dlzka;k++)
    {
        pole[k]= a + rand() % (b - a + 1);
    }
}
 
void vymenCisla(int *p_a, int *p_b)
{
    int pom = *p_a;
    *p_a = *p_b;
    *p_b = pom;
}
 
void utriedPole(int pole[])
{
    for (int i=0; i < dlzka; i++)
    {
        for (int j = 0; j<dlzka-i;j++)
        {
            if(pole[j]>pole[j+1])
            {
             vymenCisla(&pole[j],&pole[j+1]);  
            }
           
        }
    }
}

int main(int argc, char** argv) {
 
    const int dlzka = 30;
    int pole[dlzka];
   
    naplnPole(pole,dlzka, 10, 90);
    printf("Pole pred utriedenim: \n");
    vypisPole(pole,dlzka);
    utriedPole(pole);
    printf("Pole po utriedeni: \n");
    vypisPole(pole,dlzka);
   
    
    return (EXIT_SUCCESS);
}
