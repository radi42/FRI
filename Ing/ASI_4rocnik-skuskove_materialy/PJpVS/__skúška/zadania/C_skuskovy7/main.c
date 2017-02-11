/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Štvrtok, 2016, januára 21, 11:18
 */

#include <stdio.h>
#include <stdlib.h>

void vypisbity(unsigned int vysledok, int paDlzka) {
    int pom[paDlzka];
    int zvysok;
    int paVelkost = paDlzka - 1;
    int i;
    for (i = 0; i < paDlzka; i++) {
        pom[i] = 0;
    }
    while (vysledok > 0) {
        zvysok = vysledok % 2;
        //printf("%d MOD 2 = %d\n%d DIV 2 =", vysledok, zvysok, vysledok);
        vysledok = vysledok / 2;
        //printf("%d\n", vysledok);
        pom[paVelkost] = zvysok;
        paVelkost--;
    }
    for (i = 0; i < paDlzka; i++) {
        printf("%d", pom[i]);
    }
    printf("\n");
}

/*
 * 
 */
int main(int argc, char** argv) {
    unsigned int cislo;

    char string[3];
    unsigned int pole[3];
    int i;
    for (i = 0; i < 4; i++) {
        pole[i] = i + 3 + i * 1 + i * i - 1 * i;
        pole[2] = 11;
        printf("%d\n", pole[i]);
        vypisbity(pole[i], 4);
        printf("\n");
    }
    cislo = 0;
    printf("%u\n", cislo);
    vypisbity(cislo, 16);
    for (i = 0; i < 3; i++) {
        cislo += pole[i];
        cislo = cislo << 4;
    }
    cislo += pole[3];
    printf("%u\n", cislo);
    vypisbity(cislo, 16);





    return (EXIT_SUCCESS);
}

