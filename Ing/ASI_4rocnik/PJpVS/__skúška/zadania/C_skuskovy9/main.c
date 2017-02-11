/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Štvrtok, 2016, januára 21, 15:50
 */

#include <stdio.h>
#include <stdlib.h>

int myRand(int from, int to) {

    return from + (rand() % to);
}

void vypis(int **paPole, int paR, int paS) {
    int i;
    for (i = 0; i < paR; i++) {
        int j;
        for (j = 0; j < paS; j++) {
            printf("%5d ", paPole[i][j]);
        }
        printf("\n");
    }
}

void vypis2(int *pole, int pocet) {
    int i;
    for (i = 0; i < pocet; i++) {
        printf("%5d ", pole[i]);
    }
    printf("\n");
}

void uvolni(int ** * paPole, int paR, int paS) {
    int i;
    for (i = 0; i < paR; i++) {
        free((*paPole)[i]);
    }
    free(*paPole);
    *paPole = NULL;
}

void nacitaj(int ** * paPole, int paR, int paS) {
    *paPole = malloc(paR * sizeof (int*));
    int i;
    for (i = 0; i < paR; i++) {
        (*paPole)[i] = malloc(paS * sizeof (int *));
        int j;
        for (j = 0; j < paS; j++) {
            srand(time(NULL) * i + 1 * j + 1 * 8);
            if (i == 0) {
                int pom = myRand(100, 899);
                if (pom % 2 == 0) {
                    (*paPole)[i][j] = pom;
                } else {
                    (*paPole)[i][j] = pom - 1;
                }
            } else {
                (*paPole)[i][j] = 0;
            }
        }
    }
}

int porovnaj(const void *a, const void *b) {
    int pA = *(int*) a;
    int pB = *(int*) b;
    if (pA > pB) {
        return 1;
    } else if (pA == pB) {
        return 0;
    }
    return -1;
}

void kopiruj(int ** pomocne, int ** pole, int pocet) {
    *pomocne = malloc(pocet * sizeof (int*));
    int i;
    for (i = 0; i < pocet; i++) {
        (*pomocne)[i] = (*pole)[i];
    }
}

void vypocitaj(int ***pole, int paR, int paS) {
    int * pomocne;
    kopiruj(&pomocne, pole[0], paS);                //kopiruje do pomocneho 0ty riadok
    qsort(pomocne, paS, sizeof (int), &porovnaj);   //utriedi pomocne
    int i;
    for (i = 0; i < paS; i++) {
        int hodnota = (*pole)[0][i];                
        //printf("%d", hodnota);
        int j;
        int viac = 0;
        int menej = 0;
        for (j = 0; j < paS; j++) {
            if (pomocne[j] == hodnota) {            // ak najde prvok tak vrati adresu predchodcu a nasledovnika z utriedeneho pola
                menej = j - 1;
                viac = j + 1;
            }
        }                                           // overuje či existuje predchodca a nasledovnik
        if (menej < 0) {
            (*pole)[1][i] = 0;
        } else {
            (*pole)[1][i] = pomocne[menej];
        }
        if (viac == paS) {
            (*pole)[2][i] = 0;
        } else {
            (*pole)[2][i] = pomocne[viac];
        }
    }
}

/*
 * 
 */
int main(int argc, char** argv) {
    int ** pole;
    int pocet;
    scanf("%d", &pocet);
    nacitaj(&pole, 3, pocet);
    vypis(pole, 3, pocet);
    printf("\n");
    vypocitaj(&pole, 3, pocet);
    vypis(pole, 3, pocet);
    uvolni(&pole, 3, pocet);
    return (EXIT_SUCCESS);
}

