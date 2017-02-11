/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Piatok, 2016, februára 12, 8:39
 */

/*Nacitavanie roznych formatov cisel zo suboru
 * %i       - integer
 * %d / %u  - any number of decimal digits
 * %o       - octal integer
 * %f       - float
 * najdes pomocou scanf
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define Mesiace 12

typedef struct polozka {
    char* data;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int size;
} ZOZNAM;

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

void vypisPolozky(ZOZNAM *zoznam) {
    int i;
    POLOZKA *pom = zoznam->prvy;
    for (i = 0; i < zoznam->size; i++) {
        char * slovo;
        slovo = strdup(pom->data);
        slovo[strlen(slovo) - 2] = '\0';
        //slovo[strlen(slovo)-1] = '\0';
        printf("%s,", slovo);
        pom = pom->dalsi;
        free(slovo);
    }
}

void vypis(ZOZNAM **zoz) {
    int i;
    for (i = 0; i < Mesiace; i++) {
        if (i == 1) {                                       //povodne i==2
            int j;
            for (j = 0; j < 29; j++) {
                if (zoz[i][j].prvy != NULL) {
                    printf("Mena pre datum %d. %d.: ", j + 1, i + 1);
                    vypisPolozky(&zoz[i][j]);
                    printf("\n");
                }
            }
        } else if (i == 3 || i == 5 || i == 8 || i == 10) { //povodne vsetky o 1 vacsie
            int j;
            for (j = 0; j < 30; j++) {
                if (zoz[i][j].prvy != NULL) {
                    printf("Mena pre datum %d. %d.: ", j + 1, i + 1);
                    vypisPolozky(&zoz[i][j]);
                    printf("\n");
                }
            }
        } else {
            int j;
            for (j = 0; j < 31; j++) {
                if (zoz[i][j].prvy != NULL) {
                    printf("Mena pre datum %d. %d.: ", j + 1, i + 1);
                    vypisPolozky(&zoz[i][j]);
                    printf("\n");
                }
            }
        }
    }
}

void vkladanie(FILE * subor) {
    int najdlhsie = najdlhsieSlovo(subor);
    ZOZNAM **zoz;
    zoz = malloc((Mesiace) * sizeof (ZOZNAM));
    int i;
    for (i = 0; i <= Mesiace; i++) {
        if (i == 1) {                                       //povodne i==2
            zoz[i] = malloc(31 * sizeof (ZOZNAM));
            int j;
            for (j = 0; j < 30; j++) {
                zoz[i][j].size = 0;
                zoz[i][j].prvy = NULL;
            }

        } else if (i == 3 || i == 5 || i == 8 || i == 10) { //povodne vsetky o 1 vacsie
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
    char *slovo;
    slovo = malloc(najdlhsie * sizeof (char*));
    while (den != 0 && mesiac != 0) {
        fscanf(subor, "%d", &mesiac);
        fscanf(subor, "%d", &den);
        fgets(slovo, najdlhsie, subor);
        if (mesiac > 0 && mesiac < 13) {
            //printf("mesiac je 0<%d<13 ", mesiac);
            if (den > 0) {
                //printf("den je %d>0 ", mesiac);
                if (mesiac == 2) {
                    if (den < 30) {
                        //printf("den je %d<30 ", mesiac);
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac - 1][den - 1].size, slovo);
                        //printf("nacitane: %d %d %s", den, mesiac, slovo);
                    }
                } else if (mesiac == 4 || mesiac == 6 || mesiac == 9 || mesiac == 11) {
                    if (den < 31) {
                        //printf("den je %d<31 ", mesiac);
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, slovo);
                        //printf("nacitane: %d %d %s", den, mesiac, slovo);
                    }
                } else {
                    if (den < 32) {
                        //printf("den je %d<32 ", mesiac);
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, slovo);
                        //printf("nacitane: %d %d %s", den, mesiac, slovo);
                    }
                }
            }
        }
    }
    free(slovo);

    vypis(zoz);

    for (i = 0; i < Mesiace; i++) {
        free(zoz[i]);
    }
    free(zoz);
}

int main(int argc, char** argv) {
    FILE*subor;
    if (argc < 2) {
        printf("Nedostatok argumentov!\n");
        return (EXIT_FAILURE);
    }
    subor = fopen(argv[1], "r");
    if (subor == NULL) {
        printf("File NOT FOUND!\n");
        return (EXIT_FAILURE);
    }
    vkladanie(subor);

    fclose(subor);
    return (EXIT_SUCCESS);
}
