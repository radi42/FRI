/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, novembra 9, 10:01
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>
#include <string.h>

void naplnPole(int pocetRiadkov, int pocetStlpcov, int a, int b, int pole[pocetRiadkov][pocetStlpcov] ){
    for(int j = 0;j<pocetRiadkov;j++)
    {
    for (int i = 0; i < pocetStlpcov; i++){
        pole[j][i] = a + rand() %(b-a + 1);  //random cisla od 0 - b - a + 1 (horna hranica - dolna + 1))
    }
    }
}

void vypisPole(int pocetRiadkov, int pocetStlpcov, int pole[pocetRiadkov][pocetStlpcov]){

    for(int j = 0;j<pocetRiadkov;j++)
    {
    for (int i = 0; i < pocetStlpcov; i++){
      printf("%d ", pole[j][i]);
    }
   
    printf("\n");
    }
}
int NajdiMinimumMatice(int pocetRiadkov, int pocetStlpcov, int pole[pocetRiadkov][pocetStlpcov])
{
    int minimum =pole[0][0];
    for(int j = 0;j<pocetRiadkov;j++)
    {
    for (int i = 0; i < pocetStlpcov; i++){
      if(pole[j][i]<minimum)
      {
        minimum=pole[j][i];
      }
    }
  }
    return minimum;
}
void NajdiMinimumRiadka(int pocetRiadkov, int pocetStlpcov, int pole[pocetRiadkov][pocetStlpcov])
{   int poc =0;
    int minimum;
    for(int j = 0;j<pocetRiadkov;j++)
    {
        minimum=pole[j][0];
    for (int i = 0; i < pocetStlpcov; i++){
      if(pole[j][i]<minimum)
      {
        minimum=pole[j][i];
      }
    }   poc++;
        printf(" Minimum riadka %d je: %d \n",poc,minimum);
  }

}

void dealokujPole(int pocetRiadkov, int pocetStlpcov, int pole[pocetRiadkov][pocetStlpcov])
{
 free(pole);
 pole=NULL;
}

void zmenVelkostPola(int *pole[], int staraVelkost, int novaVelkost){
    if(novaVelkost > staraVelkost){
        int *novePole = (int *)calloc(novaVelkost, sizeof(int));
        for(int i = 0; i < staraVelkost; i++){
            novePole[i] = (*pole)[i];
        }
        free(*pole);
        *pole = novePole;
        free(novePole);
    }
}

void vymenSmernikyPoli(int *pole1[], int *pole2[]){
    int *pomPole = *pole1;
    *pole1 = *pole2;
    *pole2 = pomPole;
}


int main(int argc, char** argv) {
   
    int pocetRiadkov;
    int pocetStlpcov;
    int min;
    int max;
    int minimumMatice;
    printf("Zadaj pocet riadkov: \n");
    scanf("%d",&pocetRiadkov);
    printf("\n");
    printf("Zadaj pocet stlpcov:\n");
    scanf("%d",&pocetStlpcov);
    printf("\n");
    printf("Zadaj od:\n");
    scanf("%d",&min);
    printf("\n");
    printf("Zadaj do:\n");
    scanf("%d",&max);
    printf("\n");
    int (*pole) [pocetStlpcov];
    pole = (int(*)[pocetStlpcov])malloc(pocetRiadkov * sizeof(int[pocetStlpcov]));
    
    naplnPole(pocetRiadkov,pocetStlpcov,min,max,pole);
    vypisPole(pocetRiadkov,pocetStlpcov,pole);
    NajdiMinimumRiadka(pocetRiadkov,pocetStlpcov,pole);
    minimumMatice = NajdiMinimumMatice(pocetRiadkov,pocetStlpcov,pole);
    printf("Minimum matice je: %d",minimumMatice);
   
    //dealokujPole(pocetRiadkov,pocetStlpcov,pole);
    

    /* fgets(veta,49,stdin);
    pocetZnakov=strlen(veta)-1;
    zmenVelkostPola(&veta,50,pocetZnakov);
    printf("Veta je: %s",veta );*/
    
    /*int n;
    
    printf("Zadaj velkost pola: \n");
    scanf("%d", &n);
    
    int pole[n];
    naplnPole(pole, n, 10, 90);
    vypisPole(pole, n);*/
    
    /*int n;
    printf("Zadaj velkost pola: \n");
    scanf("%d", &n);
    
    //Dynamicke pole nejde s [] ale iba so smernikom teda *pole
    //int *pole = (int *)malloc(n*sizeof(int));   
    //bajty ktore vlozime do pola kukame na ne ako na Integer (int *) a alokujeme si v pameti miesto pomocu malloc n prvkov * velkost INTu
    //calloc je to iste co malloc len s tym ze sa nas pyta kolko poloziek bude a ake su velke  
    
    int *pole = (int *)calloc(n, sizeof(int));  
    naplnPole(pole, n, 10, 90);
    vypisPole(pole, n);
    
    int n2;
    printf("Zadaj novu velkost pola: \n");
    scanf("%d", &n2);
    
    //zmenVelkostPola(&pole,n,n2);
    pole = realloc(pole, n2);
    vypisPole(pole, n2);
    
    free(pole); //zmazeme alokovane miesto v pameti*/
    /////////////////////////////
    //Vymenenie smernikov poli //
    /////////////////////////////
    /*int n1 = 10;
    int n2 = 20;
    
    printf("Zadaj velkost pola1: \n");
    scanf("%d", &n1);
    int *pole1 = (int *)calloc(n1, sizeof(int));
    naplnPole(pole1, n1, 10, 90);
    
    printf("Zadaj velkost pola2: \n");
    scanf("%d", &n2);
    int *pole2 = (int *)calloc(n2, sizeof(int));  
    naplnPole(pole2, n2, 10, 90);
        
    printf("Polia pred vymenou: \n");
    vypisPole(pole1, n1);
    vypisPole(pole2, n2);
    
    printf("Polia po vymene: \n");
    vymenSmernikyPoli(&pole1, &pole2);
    vypisPole(pole1, n2);
    vypisPole(pole2, n1);
    
    free(pole1);
    free(pole2);*/
    
    return (EXIT_SUCCESS);
}