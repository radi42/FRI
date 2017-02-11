/* 
 * File:   main.c
 * Author: IKO
 *
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct polozka {
    char* data;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int size;
    char znak;
} ZOZNAM;

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
        }
        pomPolozka->dalsi = zoznam->prvy;
        zoznam->prvy = pomPolozka;
    } else {
        int i = 0;
        POLOZKA *pom2 = zoznam->prvy;
        while (i < pos - 1) {
            pom2 = pom2->dalsi;
            i++;
        }
        pomPolozka->dalsi = pom2;
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
    ZOZNAM zoz[26];
    subor = fopen(argv[1], "r");
    int i = 0;
    for (i = 0; i < 26; i++) {
        zoz[i].znak = i + 97;
        zoz[i].size = 0;
        zoz[i].prvy = NULL;
    }
    for (i = 0; i < 8; i++) {
        char * pomocna;
        pomocna = malloc(20 * sizeof (char*));
        fgets(pomocna, 20, subor);
        int j;
        for (j = 0; j < 26; j++) {
            if (pomocna[0] == j + 97) {
                int pomoc = zoz[j].size;
                vloz(&zoz[j], pomoc, pomocna);
            }
        }
        free(pomocna);
    }
    for (i = 0; i < 26; i++) {
        printf("%c ", zoz[i].znak);
        if (zoz[i].size > 0) {
            vypis(&zoz[i]);
        }
        printf("\n");
    }
    return (EXIT_SUCCESS);
}

