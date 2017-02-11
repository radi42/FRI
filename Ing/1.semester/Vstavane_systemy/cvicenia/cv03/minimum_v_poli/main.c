#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int minimum(int *pPole, int paSize)
{
    int min = pPole[0];

    if(paSize >= 2)
    {
        int i;
        for(i = 1; i < paSize; i++)
        {
            if(pPole[i] < min) min = pPole[i];
        }
    }
    return min;
}

int* randomArrayFiller(int *pPole, int paSize, int paDolnaHranica, int paHornaHranica)
{
    // inicializuj RNG
    srand(time(NULL));
    // napln pole nahodnymi cislami z rozsahu
    int i;
    for(i = 0; i < paSize; i++)
    {
        pPole[i] = rand() % paHornaHranica + paDolnaHranica;
    }
    return pPole;
}

int main(int argc, char** argv) {
    int pole[10] = {};
    printf("Pocet prvkov v poli je: %ld\n", sizeof(pole)/sizeof(int));
    int velkostPola = sizeof(pole)/sizeof(int);
    int dh = 5;
    int hh = 50;
    int *odovzdanePole = randomArrayFiller(pole, velkostPola, dh, hh);

    // vypis pola odovzdaneho fukciou
    int i;
    for(i = 0; i < velkostPola; i++)
    {
        printf("%d, ", odovzdanePole[i]);
    }
    printf("\n");

    // vypis povodneho pola
    for(i = 0; i < velkostPola; i++)
    {
        printf("%d, ", pole[i]);
    }
    printf("\n");

    int min = minimum(pole, velkostPola);
    printf("Minimum pre 'pole' = %d\n", min);
    min = minimum(odovzdanePole, velkostPola);
    printf("Minimum pre 'odovzdanePole' = %d\n", min);
    return 0;
}
