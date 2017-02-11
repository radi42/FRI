/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Štvrtok, 2015, novembra 26, 7:26
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */

typedef struct polozka {
    int data;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int pocet;
} ZOZNAM;

void vloz(ZOZNAM *zoznam, int pos, int data) {
    if (zoznam == NULL) {
        return;
    }
    
    if (pos<0) {
        pos = 0;
    } else if (pos > (*zoznam).pocet) {
        pos = zoznam->pocet;
    }
    POLOZKA *pomPolozka = (POLOZKA *)malloc(sizeof(POLOZKA));
    pomPolozka->data = data;
    
    if (pos == 0) {
        if (zoznam->pocet == 0) {
            pomPolozka->dalsi = NULL;
            zoznam->prvy = pomPolozka;
        } else {        
            pomPolozka->dalsi = zoznam->prvy;
            zoznam->prvy = pomPolozka;
        }
    } else {
        int i = 0;
        POLOZKA *pom2 = zoznam->prvy;
        while (i < pos) {
            pom2 = pom2->dalsi;
            i++;
        }
        pomPolozka->dalsi = pom2->dalsi;
        pom2->dalsi = pomPolozka;
    }
    zoznam->pocet++;
}

void vypis(ZOZNAM *zoznam, char* subort, char *suborb) {
    FILE *ft = fopen(subort,"w");
    FILE *fb = fopen(subort,"wb");
    
    POLOZKA *pom = zoznam->prvy;
    while (pom != NULL) {
        fprintf(ft, "%d ", pom->data);
        fwrite(&(pom->data),sizeof(pom->data),1,fb);
        pom = pom->dalsi;
    }
    fclose(ft);
    fclose(fb);
}

int main() {
    
    ZOZNAM zoz;
    zoz.prvy = NULL;
    zoz.pocet = 0;
    
    for (int i = 0; i <10; i++) {
        vloz(&zoz, i, i);
    }
    
    vypis(&zoz,"zoz.txt","zoz.bin");
    
    return 0;
}

