/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Streda, 2016, januára 20, 12:38
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int nahodne(int od, int po) {
    return od + (rand() % po);
}

void nacitaj(char * nazov, int *pole) {

}

void vypis(int *paPole, int paR) {
    int i;
    for (i = 0; i < paR; i++) {
        printf("%d ", paPole[i]);
    }
    printf("\n");
}

int main(int argc, char** argv) {
    int rozmer;
    printf("zadaj velkosť matice");
    scanf("%d", &rozmer);
    

    return (EXIT_SUCCESS);
}

