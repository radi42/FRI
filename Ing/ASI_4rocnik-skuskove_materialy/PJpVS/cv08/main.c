/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, novembra 9, 11:18
 */

#include <stdio.h>
#include <stdlib.h>

#include <ctype.h>
#include <time.h>
#include <string.h>

void alokuj(int **pole2D, int riadky, int stlpce) {
    (pole2D) = malloc(riadky * sizeof(int(*)));
    for (int i=0; i<riadky; i++) {
        (*pole2D) = malloc(riadky * sizeof(int(*)));
    }
}

void dealokuj(int **pole2D, int riadky, int stlpce) {
    (pole2D) = malloc(riadky * sizeof(int(*)));
    for (int i=0; i<riadky; i++) {
        (*pole2D) = malloc(riadky * sizeof(int(*)));
    }
}

//void naplnPole(int pocetRiadkov, int pocetStlpcov, int a, int b, int pole[pocetRiadkov][pocetStlpcov] ){
//    for(int j = 0;j<pocetRiadkov;j++)
//    {
//    for (int i = 0; i < pocetStlpcov; i++){
//        pole[j][i] = a + rand() %(b-a + 1);  //random cisla od 0 - b - a + 1 (horna hranica - dolna + 1))
//    }
//    }
//}

//void vypisPole(int pocetRiadkov, int pocetStlpcov, int pole[pocetRiadkov][pocetStlpcov]){
//
//    for(int j = 0;j<pocetRiadkov;j++)
//    {
//    for (int i = 0; i < pocetStlpcov; i++){
//      printf("%d ", pole[j][i]);
//    }
//   
//    printf("\n");
//    }
//}

/**
int main(int argc, char** argv) {
   
    int pocetRiadkov;
    int pocetStlpcov;
    int min;
    int max;
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
    
   
    //menu
    
    
    int volba;
    while (scanf("%d",&volba),volba>20) {

    }
    
    return (EXIT_SUCCESS);
}
*/

