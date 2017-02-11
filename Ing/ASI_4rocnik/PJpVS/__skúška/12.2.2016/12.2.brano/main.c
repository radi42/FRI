/* 
 * File:   main.c
 * Author: Branislav
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

#define pocet_mesiacov 12
#define velkost_slova 50

int mesiace[] = {31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

typedef struct {
    char value[velkost_slova];
    struct Meno* dalsi;
} Meno;

void vlozDoPola(int den, int mesiac, char meno[velkost_slova], Meno*** pole) {
    if (mesiac > pocet_mesiacov || mesiac < 1) {
        return;
    }
    mesiac--;
    if (mesiace[mesiac] < den || den < 0) {
        return;
    }
    den--;
    Meno* novy = (Meno*) malloc(sizeof (Meno));
    memcpy(novy->value, meno, sizeof (char)*velkost_slova);
    vlozDoZoznamu(&pole[mesiac][den], novy);
}

void vlozDoZoznamu(Meno** prvok, Meno* novy) {
    novy->dalsi = *prvok;
    *prvok = novy;
}

void vypisPole(Meno*** pole) {
    int i, k;
    for (i = 0; i < pocet_mesiacov; i++) {
        for (k = 0; k < mesiace[i]; k++) {
            printf("Mena pre datum %d.%d.: ", k + 1, i + 1);
            vypisZoznam(pole[i][k]);
            printf("\n");
        }
    }
}

void vypisZoznam(Meno* prvok) {
    while (prvok != NULL) {
        printf("%s,", prvok->value);
        prvok = prvok->dalsi;
    }
}

int main(int argc, char* argv[]) {
    Meno*** pole = (Meno***) malloc(sizeof (Meno**)*12);
    int i, k;
    int mesiac, den;
    char meno[velkost_slova]; //buffer
    FILE* vstup = fopen(argv[1], "r"); //otvorenie suboru
    if (vstup != NULL) {

        for (i = 0; i < pocet_mesiacov; i++) // alokacia
        {
            pole[i] = (Meno**) malloc(sizeof (Meno*) * mesiace[i]);

            for (k = 0; k < mesiace[i]; k++) {
                pole[i][k] = 0;
            }
        }

        if (vstup != NULL) {
            while (fscanf(vstup, "%d%d", &mesiac, &den) != EOF) {
                if (mesiac == den && mesiac == 0) {
                    break;
                }
                fgets(meno, velkost_slova, vstup);
                for (i = 0; i < velkost_slova; i++) {
                    if (meno[i] == '\n') {
                        meno[i] = '\0';
                        break;
                    }
                }

                vlozDoPola(den, mesiac, meno, pole);
            }
            fclose(vstup);
        }
        vypisPole(pole);

        for (i = 0; i < pocet_mesiacov; i++)//dealokacia
        {
            for (k = 0; k < mesiace[i]; k++) {
                Meno* temp = pole[i][k];
                while (temp != NULL) {
                    Meno* predosly = temp;
                    temp = temp->dalsi;
                    free(predosly);
                }
            }
            free(pole[i]);
        }
        
    } else {

        fprintf(stderr, "Subor nejde otvorit");

    }
    free(pole);
    return 0;
}
