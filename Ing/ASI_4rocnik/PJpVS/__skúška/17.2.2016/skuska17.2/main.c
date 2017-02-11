/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Streda, 2016, februára 17, 7:45
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define pocetMesiacov 12

typedef struct teplota {
    double min_t;
    double max_t;
    double rel_v;
    struct teplota* dalsi;
} TEPLOTA;

typedef struct zoznam {
    TEPLOTA *prvy;
    int size;
} ZOZNAM;

void vloz(ZOZNAM *zoznam, int pos, double min_t, double max_t, double rel_v) {
    if (zoznam == NULL) {
        return;
    }
    if (pos < 0) {
        pos = 0;
    } else if (pos > (*zoznam).size) {
        pos = zoznam->size;
    }
    TEPLOTA *pomPolozka = (TEPLOTA*) malloc(sizeof (TEPLOTA));
    pomPolozka->min_t = min_t;
    pomPolozka->max_t = max_t;
    pomPolozka->rel_v = rel_v;
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
        TEPLOTA *pom2 = zoznam->prvy;
        while (i < pos - 1) {
            pom2 = pom2->dalsi;
            i++;
        }
        pomPolozka->dalsi = pom2->dalsi;
        pom2->dalsi = pomPolozka;
    }
    zoznam->size++;
}

void vypis(TEPLOTA *polozka) {
    printf("Min. teplota: %.1f Max. teplota: %.1f Max. vlhkost %.0f %\n", polozka->min_t, polozka->max_t, polozka->rel_v);
}

TEPLOTA * najdi(ZOZNAM **zoz, int mesiac) {
    TEPLOTA *pomTeplota = (TEPLOTA*) malloc(sizeof (TEPLOTA));
    double max_t = 0;
    double min_t = 100;
    double rel_v = 0;
    pomTeplota->max_t = max_t;
    pomTeplota->min_t = min_t;
    pomTeplota->rel_v = rel_v;
    pomTeplota->dalsi = NULL;
    if (mesiac == 1) {
        int j;
        for (j = 0; j < 29; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                TEPLOTA *pomTeplota2 = (TEPLOTA*) malloc(sizeof (TEPLOTA));
                pomTeplota2 = zoz[mesiac][j].prvy;
                while (pomTeplota2 != NULL) {
                    max_t = pomTeplota2->max_t;
                    min_t = pomTeplota2->min_t;
                    rel_v = pomTeplota2->rel_v;
                    if (pomTeplota->max_t < max_t) {
                        pomTeplota->max_t = max_t;
                    }
                    if (pomTeplota->min_t > min_t) {
                        pomTeplota->min_t = min_t;
                    }
                    if (pomTeplota->rel_v < rel_v) {
                        pomTeplota->rel_v = rel_v;
                    }
                    pomTeplota2 = pomTeplota2->dalsi;
                }
                free(pomTeplota2);
            }
        }
    } else if (mesiac == 3 || mesiac == 5 || mesiac == 8 || mesiac == 10) {
        int j;
        for (j = 0; j < 30; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                TEPLOTA *pomTeplota2 = (TEPLOTA*) malloc(sizeof (TEPLOTA));
                pomTeplota2 = zoz[mesiac][j].prvy;
                while (pomTeplota2 != NULL) {
                    max_t = pomTeplota2->max_t;
                    min_t = pomTeplota2->min_t;
                    rel_v = pomTeplota2->rel_v;
                    if (pomTeplota->max_t < max_t) {
                        pomTeplota->max_t = max_t;
                    }
                    if (pomTeplota->min_t > min_t) {
                        pomTeplota->min_t = min_t;
                    }
                    if (pomTeplota->rel_v < rel_v) {
                        pomTeplota->rel_v = rel_v;
                    }
                    pomTeplota2 = pomTeplota2->dalsi;
                }
                free(pomTeplota2);
            }
        }
    } else {
        int j;
        for (j = 0; j < 31; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                TEPLOTA *pomTeplota2 = (TEPLOTA*) malloc(sizeof (TEPLOTA));
                pomTeplota2 = zoz[mesiac][j].prvy;
                while (pomTeplota2 != NULL) {
                    max_t = pomTeplota2->max_t;
                    min_t = pomTeplota2->min_t;
                    rel_v = pomTeplota2->rel_v;
                    if (pomTeplota->max_t < max_t) {
                        pomTeplota->max_t = max_t;
                    }
                    if (pomTeplota->max_t > min_t) {
                        pomTeplota->min_t = min_t;
                    }
                    if (pomTeplota->rel_v < rel_v) {
                        pomTeplota->rel_v = rel_v;
                    }
                    pomTeplota2 = pomTeplota2->dalsi;
                }
                free(pomTeplota2);
            }
        }
    }
    return pomTeplota;
}

void vkladanie(FILE * subor) {
    ZOZNAM **zoz;
    zoz = malloc((pocetMesiacov) * sizeof (ZOZNAM));
    int i;
    for (i = 0; i <= pocetMesiacov; i++) {
        if (i == 2) {
            zoz[i] = malloc(31 * sizeof (ZOZNAM));
            int j;
            for (j = 0; j < 30; j++) {
                zoz[i][j].size = 0;
                zoz[i][j].prvy = NULL;
            }

        } else if (i == 4 || i == 6 || i == 9 || i == 11) {
            zoz[i] = malloc(32 * sizeof (ZOZNAM));
            int j;
            for (j = 0; j < 31; j++) {
                zoz[i][j].size = 0;
                zoz[i][j].prvy = NULL;
            }
        } else {
            zoz[i] = malloc(33 * sizeof (ZOZNAM));
            int j;
            for (j = 0; j < 32; j++) {
                zoz[i][j].size = 0;
                zoz[i][j].prvy = NULL;
            }
        }
    }

    int den = -1;
    int mesiac = -1;
    double min_t;
    double max_t;
    double rel_v;
    while (den != 0 && mesiac != 0) {
        fscanf(subor, "%d", &mesiac);
        fscanf(subor, "%d", &den);
        fscanf(subor, "%lf", &min_t);
        fscanf(subor, "%lf", &max_t);
        fscanf(subor, "%lf", &rel_v);
        if (mesiac > 0 && mesiac < 13) {
            if (den > 0) {
                if (mesiac == 2) {
                    if (den < 30) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac - 1][den - 1].size, min_t, max_t, rel_v);
                    }
                } else if (mesiac == 4 || mesiac == 6 || mesiac == 9 || mesiac == 11) {
                    if (den < 31) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, min_t, max_t, rel_v);
                    }
                } else {
                    if (den < 32) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, min_t, max_t, rel_v);
                    }
                }
            }
        }
    }

    for (i = 0; i < pocetMesiacov; i++) {
        TEPLOTA *pomPolozka = (TEPLOTA*) malloc(sizeof (TEPLOTA));

        pomPolozka = najdi(zoz, i);
        if (pomPolozka != NULL) {
            printf("Mesiac: %d ", i + 1);
            vypis(pomPolozka);
        }
        free(pomPolozka);
    }

    for (i = 0; i < pocetMesiacov; i++) {
        free(zoz[i]);
    }
    free(zoz);
}

int main(int argc, char** argv) {
    FILE*subor;
    if (argc < 2) {
        printf("Nebol zadany nazov suboru\n");
        return (EXIT_FAILURE);
    }
    subor = fopen(argv[1], "r");
    if (subor == NULL) {
        printf("subor neplatny\n");
        return (EXIT_FAILURE);
    }
    vkladanie(subor);

    fclose(subor);
    return (EXIT_SUCCESS);
}
