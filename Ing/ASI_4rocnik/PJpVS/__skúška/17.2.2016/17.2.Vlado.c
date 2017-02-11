/* 
 * File:   main.c
 * Author: Vlado
 *
 * Created on Piatok, 2016, februára 17, 8:39
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define Mesiace 12

typedef struct polozka {
    double min;
    double max;
    double vlhkost;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int size;
} ZOZNAM;

// vlozi jeden prvok do zoznamu konkretneho na konkretnu poziciu "pos"
// povedz mu že si bol na doučovaní u spolužiaka a túto funckiu ste si spolu spravili, 
// preto si ju využil, ale že by sa to dalo jednoduchšie spraviť že stačí vkladať na koniec

void vloz(ZOZNAM *zoznam, int pos, double min, double max, double vlhkost) {
    if (zoznam == NULL) {
        return;
    }
    if (pos < 0) {
        pos = 0;
    } else if (pos > (*zoznam).size) {
        pos = zoznam->size;
    }
    POLOZKA *pomPolozka = (POLOZKA*) malloc(sizeof (POLOZKA));
    pomPolozka->min = min;
    pomPolozka->max = max;
    pomPolozka->vlhkost = vlhkost;
    if (pos == 0) { //ak vkladam na poziciu 0 
        if (zoznam->size == 0) { //ešte tam nič nie je
            pomPolozka->dalsi = NULL;
            zoznam->prvy = pomPolozka;
        } else { //treba posunuť ostatne prvky(ak tam niečo už bolo))
            pomPolozka->dalsi = zoznam->prvy;
            zoznam->prvy = pomPolozka;
        }
    } else { //inak ak vkladam na inu poziciu
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
// len vypise polozku, pouziva sa na to, aby vypisalo najdenu polozku s maximom a minimom...
void vypis(POLOZKA *polozka) {
    printf("Min. teplota: %.2f Max. teplota: %.2f Max. vlhkost %.0f %\n", polozka->min, polozka->max, polozka->vlhkost);
}

// vrati ti novu polozku vytvorenu s udajmy min z celeho mesiaca, max z celeho mesiaca a max velhkost celho mesiaca
// postupne prechádza každý den mesiaca a hladá max, min a max vlhkost
// je to ifované podla toho, aký to je mesiac a potom sa prejde postupne každý den.. každý den može obsahoať zoznam, tak sa každý den prejde celý zoznam.... 
POLOZKA * najdi(ZOZNAM **zoz, int mesiac) {
    POLOZKA *pomPolozka = (POLOZKA*) malloc(sizeof (POLOZKA));
    double max = 0;
    double min = 100;
    double vlhkost = 0;
    pomPolozka->max = max;
    pomPolozka->min = min;
    pomPolozka->vlhkost = vlhkost;
    pomPolozka->dalsi = NULL;
    if (mesiac == 2) {
        int j;
        for (j = 0; j < 29; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                POLOZKA *pomPolozka2 = (POLOZKA*) malloc(sizeof (POLOZKA));
                pomPolozka2 = zoz[mesiac][j].prvy;
                while (pomPolozka2 != NULL) {
                    max = pomPolozka2->max;
                    min = pomPolozka2->min;
                    vlhkost = pomPolozka2->vlhkost;
                    if (pomPolozka->max < max) {
                        pomPolozka->max = max;
                    }
                    if (pomPolozka->max > min) {
                        pomPolozka->min = min;
                    }
                    if (pomPolozka->vlhkost < vlhkost) {
                        pomPolozka->vlhkost = vlhkost;
                    }
                    pomPolozka2 = pomPolozka2->dalsi;
                }
                free(pomPolozka2);
            }
        }
    } else if (mesiac == 4 || mesiac == 6 || mesiac == 9 || mesiac == 11) {
        int j;
        for (j = 0; j < 30; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                POLOZKA *pomPolozka2 = (POLOZKA*) malloc(sizeof (POLOZKA));
                pomPolozka2 = zoz[mesiac][j].prvy;
                while (pomPolozka2 != NULL) {
                    max = pomPolozka2->max;
                    min = pomPolozka2->min;
                    vlhkost = pomPolozka2->vlhkost;
                    if (pomPolozka->max < max) {
                        pomPolozka->max = max;
                    }
                    if (pomPolozka->max > min) {
                        pomPolozka->min = min;
                    }
                    if (pomPolozka->vlhkost < vlhkost) {
                        pomPolozka->vlhkost = vlhkost;
                    }
                    pomPolozka2 = pomPolozka2->dalsi;
                }
                free(pomPolozka2);
            }
        }
    } else {
        int j;
        for (j = 0; j < 31; j++) {
            if (zoz[mesiac][j].prvy != NULL) {
                POLOZKA *pomPolozka2 = (POLOZKA*) malloc(sizeof (POLOZKA));
                pomPolozka2 = zoz[mesiac][j].prvy;
                while (pomPolozka2 != NULL) {
                    max = pomPolozka2->max;
                    min = pomPolozka2->min;
                    vlhkost = pomPolozka2->vlhkost;
                    if (pomPolozka->max < max) {
                        pomPolozka->max = max;
                    }
                    if (pomPolozka->max > min) {
                        pomPolozka->min = min;
                    }
                    if (pomPolozka->vlhkost < vlhkost) {
                        pomPolozka->vlhkost = vlhkost;
                    }
                    pomPolozka2 = pomPolozka2->dalsi;
                }
                free(pomPolozka2);
            }
        }
    }
    return pomPolozka;
}

void vkladanie(FILE * subor) {
    ZOZNAM **zoz;
    zoz = malloc((Mesiace) * sizeof (ZOZNAM));
    int i;
    for (i = 0; i <= Mesiace; i++) {//alokovanie miesta v pamäti pre pole typu smerník na smerník(matica)
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
    double min;
    double max;
    double vlhkost;
    while (den != 0 && mesiac != 0) {
        fscanf(subor, "%d", &mesiac);
        fscanf(subor, "%d", &den);
        fscanf(subor, "%lf", &min);
        fscanf(subor, "%lf", &max);
        fscanf(subor, "%lf", &vlhkost);
        if (mesiac > 0 && mesiac < 13) {
            if (den > 0) {
                if (mesiac == 2) {
                    if (den < 30) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac - 1][den - 1].size, min, max, vlhkost);
                        //printf("nacitane: %d %d %.2f %.2f %.0f\n", den, mesiac, min, max, vlhkost);
                    }
                } else if (mesiac == 4 || mesiac == 6 || mesiac == 9 || mesiac == 11) {
                    if (den < 31) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, min, max, vlhkost);
                        //printf("nacitane: %d %d %.2f %.2f %.0f\n", den, mesiac, min, max, vlhkost);
                    }
                } else {
                    if (den < 32) {
                        vloz(&zoz[mesiac - 1][den - 1], zoz[mesiac][den].size, min, max, vlhkost);
                        //printf("nacitane: %d %d %.2f %.2f %.0f\n", den, mesiac, min, max, vlhkost);
                    }
                }
            }
        }
    }

    for (i = 0; i < Mesiace; i++) {
        POLOZKA *pomPolozka = (POLOZKA*) malloc(sizeof (POLOZKA));

        pomPolozka = najdi(zoz, i);
        if (pomPolozka != NULL) {
            printf("Mesiac: %d ", i + 1);
            vypis(pomPolozka);
        }
        free(pomPolozka);
    }




    for (i = 0; i < Mesiace; i++) { // uvolnenie pola typu smernik na smerník z pamäte
        free(zoz[i]);
    }
    free(zoz);
}

int main(int argc, char** argv) {
    FILE*subor;
    if (argc < 2) {
        printf("Nedostatok argumentov !\n");
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

