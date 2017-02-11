/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Štvrtok, 2016, januára 21, 14:47
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

/*
 * 
 */
int main(int argc, char** argv) {
    FILE * subor;
    subor = fopen("Citaj.txt", "r");
    if (subor == NULL) {
        printf("Error reading file\n");
        return (EXIT_FAILURE);
    }
    int velkost, cislo, pocet;
    pocet = 0;
    velkost = 0;
    while (fscanf(subor, "%d", &cislo) != EOF) {
        velkost++;
        if (cislo >= 0) {            
            int i;
            int pom = 0;
            int max = ((int) sqrt(cislo));
            if (max < 1) {
                max = 1;
            }
            for (i = 1; i <= max; i++) {
                if (cislo % i == 0) {
                    pom++;
                }
            }
            if ((pom == 1)&&(cislo > 1)) {
                printf("prvocislo %d\n", cislo);
                pocet++;
            }
        }
    }
    printf("z %d cisel bolo %d prvocisel\n", velkost, pocet);

    return (EXIT_SUCCESS);
}

