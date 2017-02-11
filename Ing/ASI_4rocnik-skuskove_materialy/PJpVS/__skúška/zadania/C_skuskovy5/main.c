/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Streda, 2016, januára 20, 18:02
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
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

int kuzelna(int ** matica, int size) {
    int i;
    int suma = 0;
    int suma2 = 0;
    int suma3 = 0;
    int suma4 = 0;
    for (i = 0; i < size; i++) {
        suma = 0;
        suma2 = 0;
        suma3 = 0;
        int j;
        for (j = 0; j < size; j++) {
            suma += matica[0][j];
            suma2 += matica[i][j];
            suma3 += matica[j][i];
            if (i == j) {
                suma4 += matica[i][j];
            }

        }
        if ((suma != suma2) || (suma != suma3)) {
            return 2;
        }
    }
    if (suma != suma4) {
        return 2;
    }
    return 1;

}

void nacitaj(int ** * paPole, int paR, int paS) {
    *paPole = malloc(paR * sizeof (int*));
    int i;
    for (i = 0; i < paR; i++) {
        (*paPole)[i] = malloc(paS * sizeof (int *));
        int j;
        for (j = 0; j < paS; j++) {
            //srand(time(NULL) * i + 1 * j + 1 * 8);
            (*paPole)[i][j] = myRand(1, 10);
        }
    }
}

void uvolni(int ** * paPole, int paR, int paS) {
    int i;
    for (i = 0; i < paR; i++) {
        free((*paPole)[i]);
    }
    free(*paPole);
    *paPole = NULL;
}

int main(int argc, char** argv) {
    int i;
    for (i = 0; i < 100000; i++) {
        srand(time(NULL) * i * i * 8 + 10 + i * 65);
        int rozmer = 4;
        //scanf("%d", &rozmer);
        int **matica;
        nacitaj(&matica, rozmer, rozmer);
        //vypis(matica, rozmer, rozmer);
        if (kuzelna(matica, rozmer) == 2) {
            printf("nie je kuzelna\n");
        } else {
            printf("je kuzelna\n");
        }
        uvolni(&matica, rozmer, rozmer);

    }

    int rozmer = 4;
    //scanf("%d", &rozmer);
    int **matica;
    nacitaj(&matica, rozmer, rozmer);
    //vypis(matica, rozmer, rozmer);
    if (kuzelna(matica, rozmer) == 2) {
        printf("nie je kuzelna\n");
    } else {
        printf("je kuzelna\n");
    }
    uvolni(&matica, rozmer, rozmer);

    return (EXIT_SUCCESS);
}

