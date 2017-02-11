#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define typ double   // ako by sa to dalo zmenit jednoducho na linearne zretazeny zoznam, a potom pouzivat definovanu konstantu

typedef struct prvok
{
    double data;
    struct prvok *nas;
} Prvok;

typedef struct linZoz
{
    double *pole;
    Prvok *zac;
    Prvok *kon;
    int pocet;
} LinZoz;

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

int main()
{
    return 0;
}
