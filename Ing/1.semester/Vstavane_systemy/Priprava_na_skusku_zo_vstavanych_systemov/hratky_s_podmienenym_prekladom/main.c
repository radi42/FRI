#include <stdio.h>

#ifndef _STDC_NO_COMPLEX
#include <complex.h>
#include <math.h>

double complex nacitajKomplexneCislo()
{
    double real, imag;
    scanf("%lf%lf", &real, &imag);
    return real + imag * I;
}

int main(int argc, char **argv)
{
    double complex a;
    double complex b;

    printf("Zadaj realnu a imaginarnu cast komplexneho cisla\n");
    a = nacitajKomplexneCislo();
    b = 1 + 1*I;

    printf("Sucet komplexnych cisel\n"
            "%.2f%+.2f a\n%.2f%+.2f je\n%.2f%+.2f",
            creal(a), cimag(a), creal(b), cimag(b),
            creal(a+b), cimag(a+b));
    return 0;
}

#else
int main(int argc, char **argv)
{
    printf("Komplexne cisla nie su podporovane kompilatorom\n");
    return 1;
}
#endif
