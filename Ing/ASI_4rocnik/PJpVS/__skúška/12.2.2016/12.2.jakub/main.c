/* 
 * File:   main.c
 * Author: jakub
 *
 * Created on Piatok, 2016, februára 12, 9:46
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

typedef struct polozka {
    char* data;
    struct polozka *dalsi;
} POLOZKA;

typedef struct zoznam {
    POLOZKA *prvy;
    int size;
} ZOZNAM;

typedef struct meno {
    char* data;
    int mesiac;
    int den;
} MENO;

int pocetSlov(FILE * subor) {
    int pocetSlov = 0;
    while (!feof(subor)) {
        char c = fgetc(subor); //cita znaky az po \n 
        if (c == '\n') { 
            pocetSlov++;
        }        
    }
    fseek(subor, 0, SEEK_SET); //kurzor na zaciatok suboru
    return pocetSlov-1; //-1 lebo v skutocnosti rata pocet riadkov, v poslednom su nuly a ziadne slovo/meno
}

int najdlhsiRiadok(FILE * subor) {
    int max = 0;
    int pomocna = 0;
    while (!feof(subor)) {
        char c = fgetc(subor); //do pomocnej pocita znaky az po \n
        pomocna++;
        if (c == '\n') {
            if (max < pomocna) {
                max = pomocna;
            }
            pomocna = 0;
        }
    }
    fseek(subor, 0, SEEK_SET);
    return max - 2; //-2 lebo na konci kazdeho riadka sa enter rata ako 2 znaky
}

void vloz(ZOZNAM *zoznam, int pos, char* data) {
    if (zoznam == NULL) { //ak je zoznam prazdny, koncim
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
        if (i == zoznam->size - 1) //ak je meno posledne v zozname, vypise ho bez ciarky
            printf("%s", pom->data);
        else printf("%s, ", pom->data); //ak nie je posledne, vypise ho s ciarkou a medzerou
        pom = pom->dalsi;
    }
}

int jeDatumOk(int den, int mesiac) {
    if (mesiac <=0 || mesiac > 12)
        return 0;
    if (den <=0 || den > dajPocetDniVMesiaci(mesiac))
        return 0;
    return 1;
}

int dajPocetDniVMesiaci(int mesiac) {
    if (mesiac == 2)
        return 29;
    else if (mesiac == 4 ||mesiac == 6 ||mesiac == 9 ||mesiac == 11)
        return 30;
    else //if (mesiac == 1 ||mesiac == 3 ||mesiac == 5 ||mesiac == 7 ||mesiac == 8 ||mesiac == 10 mesiac == 12 )
        return 31;
}

char* rozparsuj(char* pomocna, int *mesiac, int *den) {
    int znak = 0; //index v premennej pomocna
    int dlzka=0; //pocet znakov pre 1 slovo
    while (pomocna[znak] != ' ') //hladam prvu medzeru pre dlzku prveho cisla-mesiac
    {
        znak++;
        dlzka++;
    }
    int mes = parseInt(pomocna, znak - dlzka, dlzka);
    (*mesiac) = mes;
    znak++; //preskocim medzeru
    dlzka=0; //resetnem
    
    while (pomocna[znak] != ' ') //hladam druhu medzeru-zistenie druheho cisla
    {
        znak++;
        dlzka++;
    }
    (*den) = parseInt(pomocna, znak - dlzka, dlzka);        
    znak++;
    dlzka = 0; //reset
    
    while(pomocna[znak + dlzka] != '\n' && pomocna[znak + dlzka] != '\r') //zistim koniec riadka
    {
        dlzka++;
    }
    char * meno = malloc(dlzka * sizeof (char*)); //alokujem premennu meno
    memcpy( meno, &pomocna[znak], dlzka ); //naplnim premennu meno
    return meno;
}

int parseInt(char* pomocna, int zaciatok, int dlzka) {
    int cislo;
    char subbuff[dlzka + 1]; //vytvorim premennu kde vlozim substring
    memcpy(subbuff, &pomocna[zaciatok], dlzka); // substring
    subbuff[dlzka] = '\0'; //ukoncienie stringu
    sscanf(subbuff, "%d", &cislo); //precitam cislo do premennej cislo
    return cislo;
}

int main(int argc, char** argv) {
    FILE*subor;
    ZOZNAM **zoz;
    zoz = (ZOZNAM*)malloc(12 * sizeof (ZOZNAM)); ////alokujem riadky zoznamu (12 riadkov - 12 mesiacov)
    int i;
    for (i = 0; i < 12; i++) { //alokujem stlpce
        zoz[i] = (ZOZNAM*)malloc(dajPocetDniVMesiaci(i + 1) * sizeof (ZOZNAM));
    }

    subor = fopen(argv[1], "r");
    int pocet = pocetSlov(subor); //pocet slov-riadkov
    int najdlhsi = najdlhsiRiadok(subor); //dlzka najdlhsieho riadka

    printf("Pocet: %d slov\nNajdlhsi riadok: %d znakov\n", pocet, najdlhsi);
    for (i = 0; i < 12; i++) { //inicializacia prvkov pola
        int j;
        for (j = 0; j < dajPocetDniVMesiaci(i + 1); j++) {
            zoz[i][j].size = 0;
            zoz[i][j].prvy = NULL;
        }
    }
    char * pomocna;
    int mesiac;
    int den;
    char* meno;
    pomocna = malloc(najdlhsi * sizeof (char*));
    for (i = 0; i < pocet; i++) {
        fgets(pomocna, najdlhsi, subor); //nacitame riadok i
        meno = rozparsuj(pomocna, &mesiac, &den); ////rozparsujeme riadok i
        //printf("Pomocna: %s; den: %d; mes: %d; meno: %s;\n", pomocna, den, mesiac, meno);
        if (jeDatumOk(den, mesiac) == 1)
        {
            vloz(&zoz[mesiac - 1][den - 1], &zoz[mesiac - 1][den - 1].size, meno); //vlozime meno na svoje miesto
        }
        free(meno);
    }
    free(pomocna);
    for (i = 0; i < 12; i++) { //vypisujem pre mesiace a k nim pocet dni
        int j;
        for (j = 0; j < dajPocetDniVMesiaci(i+1); j++) {  // +1 kvoli indexovaniu od nuly
            if (zoz[i][j].size > 0) {
                printf("Mena pre datum %d.%d.: ", j + 1, i + 1);
                vypis(&zoz[i][j]);
                printf("\n");
            }
        }
    }
    for (i = 0; i < 12; i++) {
        free(zoz[i]);
    }
    free(zoz);
    
    fclose(subor);
    return (EXIT_SUCCESS);
}
