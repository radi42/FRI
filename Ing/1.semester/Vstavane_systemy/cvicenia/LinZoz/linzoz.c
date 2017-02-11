#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "linzoz.h"

//#include "dynzoz.c"   // takyto include sa nepouziva, lebo by liker krical, ze mame rovnako

#define typ double   // ako by sa to dalo zmenit jednoducho na linearne zretazeny zoznam, a potom pouzivat definovanu konstantu

// definicie struktur uz nepotrebujem, lebo su uz deklarovane v hlavickovom subore
struct prvok
{
    double data;
    struct prvok *nas;
};

struct linZoz
{
    double *pole;
    Prvok *zac;
    Prvok *kon;
    int pocet;
};

void init(LinZoz *zoz)
{
    zoz->pocet = 0;
    zoz->zac = zoz->kon = NULL;
}

void dispose(LinZoz *zoz)
{

    // preiterujeme sa na danu poziciu
    Prvok *akt = zoz->zac;
    while(akt != NULL)
    {
        Prvok *pom = akt;
        akt = akt->nas;
        free(pom);
    }
    zoz->pocet = 0;
    zoz->zac = zoz->kon = NULL;
}

void add(LinZoz *zoz, double data)
{
    Prvok *pom = malloc(sizeof(Prvok));
    pom->data = data;
    pom->nas = NULL;

    if(zoz->pocet == 0)
    {
        zoz->zac = zoz->kon = pom;
    }
    else
    {
        zoz->kon->nas = pom;
        zoz->kon = pom;
    }
    zoz->pocet++;
}

void print(const LinZoz *zoz)
{
    Prvok *akt = zoz->zac;
    while (akt != NULL)
    {
        printf("%f\n", akt->data);
        akt = akt->nas;
    }
    printf("\n");
}

int main()
{
    LinZoz *zoz;

    init(zoz);

    add(zoz, 1.0);
    add(zoz, 2.0);
    add(zoz, 3.0);

    print(zoz);

    dispose(zoz);

    return 0;
}
