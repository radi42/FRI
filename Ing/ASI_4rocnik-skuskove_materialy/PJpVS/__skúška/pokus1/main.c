/* 
 * File:   main.c
 * Author: IKO
 *
 * 
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define Abeceda 26

typedef struct polozka {
    char* data;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int size;
    char znak1;
    char znak2;
} ZOZNAM;

int pocetSlov(FILE * subor) {
    int pocetSlov = 0;
    while (!feof(subor)) {      //testuje end-of-file
        char c = fgetc(subor);
        if (c == '\n') {
            pocetSlov++;
        }
    }
    fseek(subor, 0, SEEK_SET);  //prejde na 0. (1.) pozíciu v súbore
    return pocetSlov;
}

int najdlhsieSlovo(FILE * subor) {
    int max = 0;
    int pomocna = 0;
    while (!feof(subor)) {
        char c = fgetc(subor);
        pomocna++;
        if (c == '\n') {
            if (max < pomocna) {
                max = pomocna;
            }
            pomocna = 0;
        }
    }
    fseek(subor, 0, SEEK_SET);
    return max + 1;
}

void vloz(ZOZNAM *zoznam, int pos, char* data) {
    if (zoznam == NULL) {
        return;
    }
    if (pos < 0) {
        pos = 0;
    } else if (pos > (*zoznam).size) {
        pos = zoznam->size;
    }
    POLOZKA *pomPolozka = (POLOZKA*) malloc(sizeof (POLOZKA));
    pomPolozka->data = strdup(data);
    if (pos == 0) {
        if (zoznam->size == 0) {
            pomPolozka->dalsi = NULL;
            zoznam->prvy = pomPolozka;
        } else {
            pomPolozka->dalsi = zoznam->prvy;
            zoznam->prvy = pomPolozka;
        }
    } else {
        int i = 0;
        POLOZKA *pom2 = zoznam->prvy;
        while (i < pos - 1) {
            pom2 = pom2->dalsi;
            i++;
        }
        pomPolozka->dalsi = pom2->dalsi;
        pom2->dalsi = pomPolozka;
    }
    zoznam->size++;
}

void vypis(ZOZNAM *zoznam) {
    int i;
    POLOZKA *pom = zoznam->prvy;
    for (i = 0; i < zoznam->size; i++) {
        printf(" -> %s", pom->data);
        pom = pom->dalsi;
    }
}

int main(int argc, char** argv) {
    FILE*subor;
    ZOZNAM** zoz;
    //[Abeceda][Abeceda];
    zoz = (ZOZNAM*)malloc(Abeceda * sizeof (ZOZNAM));
    int i;
    for (i = 0; i < Abeceda; i++) {
        zoz[i] = (ZOZNAM*)malloc(Abeceda * sizeof (ZOZNAM));
    }

    subor = fopen(argv[1], "r");
    int pocet = pocetSlov(subor);
    int najdlhsie = najdlhsieSlovo(subor);

    printf("Pocet: %d slov\n\nNajdlhsie: %d znakov\n\n", pocet, najdlhsie);
    for (i = 0; i < Abeceda; i++) {
        int j;
        for (j = 0; j < Abeceda; j++) {
            zoz[i][j].znak1 = i + 97;
            zoz[i][j].znak2 = j + 97;
            zoz[i][j].size = 0;
            zoz[i][j].prvy = NULL;
        }
    }
    char * pomocna;
    pomocna = malloc(najdlhsie * sizeof (char*));
    for (i = 0; i < pocet; i++) {
        fgets(pomocna, najdlhsie, subor);
        vloz(&zoz[pomocna[0] - 97][pomocna[1] - 97], zoz[pomocna[0] - 97][pomocna[1] - 97].size, pomocna);
    }
    free(pomocna);
    for (i = 0; i < Abeceda; i++) {
        int j;
        for (j = 0; j < Abeceda; j++) {
            if (zoz[i][j].size > 0) {
                printf("%c %c", zoz[i][j].znak1, zoz[i][j].znak2);
                vypis(&zoz[i][j]);
                printf("\n");
            }
        }

    }
    for (i = 0; i < Abeceda; i++) {
        free(zoz[i]);
    }
    free(zoz);

    return (EXIT_SUCCESS);
}
