#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <complex.h>
#include <string.h>
#include <math.h>

void printComplexArray(double complex *pPole, int paSize, char* paComplexType)
{
    int i;
    for(i = 0; i < paSize; i++)
    {
        if(strcmp(paComplexType, "-a") == 0) printf("( %+.2f ) + ( %+.2f )i\n", creal(pPole[i]), cimag(pPole[i]));
        else if(strcmp(paComplexType, "-g") == 0) printf("%.2f * sin( %+.2f ) + cos( %+.2f )i\n",
                                              cabs(pPole[i]), carg(pPole[i])/M_PI * 180, carg(pPole[i])/M_PI * 180);
    }
}

double complex* randomArrayFiller(double complex* pPole, int paSize,
                                  double reMin, double reMax, double imMin, double imMax)
{
    // skontroluj hodnoty
    printf("Interval realnej casti: < %.2f; %.2f >\n", reMin, reMax);
    printf("Interval imaginarnej casti: < %.2f; %.2f >\n", imMin, imMax);

    // inicializuj RNG
    srand(time(NULL));
    // napln pole nahodnymi cislami z rozsahu
    double re;
    double im;
    double desatinnaCast;
    double range;
    double div;
    int i;
    for(i = 0; i < paSize; i++)
    {
        range = (reMax - reMin);
        div = RAND_MAX / range;
        desatinnaCast = rand() / div;
//        printf("%.2f\n", reMin);
//        printf("%.2f\n", desatinnaCast);
        re = reMin + desatinnaCast;

        range = (imMax - imMin);
        div = RAND_MAX / range;
        desatinnaCast = rand() / div;
//        printf("%.2f\n", imMin);
//        printf("%.2f\n", desatinnaCast);
        im = imMin + desatinnaCast;

        pPole[i] = re + im * I;
//        printf("( %+.2f ) + ( %+.2f )i\n", creal(pPole[i]), cimag(pPole[i]));
//        printf("\n");
    }
    return pPole;
}

int main(int argc, char** argv) {
    if(argc < 2)
    {
        printf("Pouzitie: \nProgram treba spustat bud s parametrom \"-a\" (algebraicky vypis cisla), alebo \"-g\" (goniometricky vypis cisla)\nPri zadani viacerych argumentov sa berie do uvahy iba prvy z nich.");
        return 1;
    }

    double complex pole[10] = {};
    int velkostPola = sizeof(pole)/sizeof(double complex);
    printf("Pocet prvkov v poli je: %d\n", velkostPola);
//    double reMin = 1.1;
//    double reMax = 2.2;
    double reMin = -2.2;
    double reMax = -1.1;
    double imMin = -4.4;
    double imMax = -3.3;
    randomArrayFiller(pole, velkostPola, reMin, reMax, imMin, imMax);
    //double complex *odovzdanePole = randomArrayFiller(pole, velkostPola, reMin, reMax, imMin, imMax);

    printComplexArray(pole, velkostPola, argv[1]);

    int i;
    for(i = 0; i < argc; i++)
    {
        printf("%s ", argv[i]);
    }
    printf("Pocet argumentov: %d\n", argc);

    return 0;
}

