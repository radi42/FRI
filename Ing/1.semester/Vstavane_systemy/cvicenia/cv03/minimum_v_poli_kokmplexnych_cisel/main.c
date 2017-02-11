#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <complex.h>

double complex minimumAbsComplexNum(double complex *pPole, int paSize)
{
    double complex min = cabs(pPole[0]);
    if(paSize == 1)
    {
        return min;
    }

    int i;
    for(i = 0; i < paSize; i++)
    {
        if(cabs(pPole[i]) < cabs(min)) min = pPole[i];
    }


    return min;
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

    int i;
    for(i = 0; i < velkostPola; i++)
    {
        printf("( %+.2f ) + ( %+.2f )i\t abs = %f\n", creal(pole[i]), cimag(pole[i]), cabs(pole[i]));
    }

    double complex minAbs = minimumAbsComplexNum(pole, velkostPola);
    printf("Najmensie komplexne cislo v absolutnej hodnote je |( %+.2f ) + ( %+.2f )| = %f",
           creal(minAbs), cimag(minAbs), cabs(minAbs));

    return 0;
}
