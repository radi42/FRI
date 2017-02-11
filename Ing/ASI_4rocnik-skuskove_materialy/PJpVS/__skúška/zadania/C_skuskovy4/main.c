/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Streda, 2016, januára 20, 16:48
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
void zisti(int * pole, int size) {
    int i;
    for (i = 0; i < size; i++) {
        int j;
        for (j = 0; j < size; j++) {
            if (pole[j] < pole[i]) {
                int k;
                for (k = j; k < size; k++) {
                    if ((pole[k] < pole[i])&&(pole[j] != pole[k])) {
                        if ((pole[i] * pole[i]) == (pole[j] * pole[j] + pole[k] * pole[k])) {
                            printf("%d %d %d\n", pole[i], pole[j], pole[k]);
                        }
                    }
                }
            }
        }
    }
}

int main(int argc, char** argv) {
    FILE*subor;
    subor = fopen("Citaj.txt", "r");
    int * pole;
    int cislo;
    int velkost = 0;
    int i;
    while (cislo>-1) {
        fscanf(subor, "%d", &cislo);
        velkost++;
    }
    subor = fopen("Citaj.txt", "r");
    velkost--;
    pole = malloc(velkost * sizeof (int*));
    for (i = 0; i < velkost; i++) {
        fscanf(subor, "%d", &cislo);
        pole[i] = cislo;
    }
    zisti(pole, velkost);
    free(pole);
    fclose(subor);

    return (EXIT_SUCCESS);
}

