#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define VELKOST_BUFFRA 100

typedef struct poznamka
{
    int hodina, minuta;
    char text_poznamky[50];
} Poznamka;

typedef struct evidencia
{
    int pocet_poznamok;
    Poznamka poznamky[10];
} Evidencia;

void init_evidencia(Evidencia *evid)
{
    evid->pocet_poznamok = 0;
    memset(evid->poznamky, '\0', sizeof(evid->poznamky));
}

void pridaj_poznamku_do_evidencie(Poznamka *poz, Evidencia *evid)
{
    evid->poznamky[evid->pocet_poznamok] = *poz;
    evid->pocet_poznamok = evid->pocet_poznamok + 1;
}

void vypis_poznamky(Evidencia *evid)
{
    for(int i = 0; i < evid->pocet_poznamok; i++)
    {
        printf("%d:", evid->poznamky[i].hodina);

        if(evid->poznamky[i].minuta <= 9) printf("0%d", evid->poznamky[i].minuta);
        else printf("%d", evid->poznamky[i].minuta);

        printf(" %s", evid->poznamky[i].text_poznamky);
    }
}

void nacitajPoznamkyZoSuboru(FILE *subor, Evidencia *evid)
{
    char *buffer = malloc(VELKOST_BUFFRA);
    Poznamka *poz = malloc(sizeof(struct poznamka));

    while(fgets(buffer, VELKOST_BUFFRA, subor))
    {
        // nacitaj cas poznamky
        sscanf(buffer, "%d:%d", &(poz->hodina), &(poz->minuta));

        // nacitaj text poznamky
        int i = 5;  // lebo od piateho znaku sa vzdy zacina text poznamky
        strcpy(poz->text_poznamky, &buffer[i]);

        pridaj_poznamku_do_evidencie(poz, evid);
    }

    free(poz);
    free(buffer);
}

int main(int argc, char** argv)
{
    Evidencia *evid = malloc(sizeof(struct evidencia));
    init_evidencia(evid);

    FILE *subor= fopen(argv[1], "r");
    nacitajPoznamkyZoSuboru(subor, evid);
    fclose(subor);

    vypis_poznamky(evid);

    free(evid);
    return 0;
}
