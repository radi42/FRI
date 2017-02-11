#include <stdio.h>
#include <stdlib.h>
#include <complex.h>
#include <math.h>

void vypocitajKvadratickuRovnicu(double *a, double *b, double *c, double *diskriminant, double complex *x1, double complex *x2)
{
    *diskriminant = (*b)*(*b) - 4*(*a)*(*c);
    if(*diskriminant > 0)
    {
        *x1 = (-(*b) + sqrt(*diskriminant)) / (2*(*a));
        *x2 = (-(*b) - sqrt(*diskriminant)) / (2*(*a));
    }
    else if(*diskriminant == 0)
    {
        *x1 = (-(*b) + sqrt(*diskriminant)) / (2*(*a));
    }
    else
    {
         double complex dComplex = 0 - (*diskriminant) * I;
         printf("dComplex = ( %+.2f ) + ( %+.2f )i\n", creal(dComplex), cimag(dComplex));
         printf("Druha odmocnina imaginarnej zlozky diskriminantu = %+.2fi\n", sqrt(cimag(dComplex)));
         *x1 = (-(*b) + sqrt(cimag(dComplex)) * I) / (2*(*a));
         *x2 = (-(*b) - sqrt(cimag(dComplex)) * I) / (2*(*a));
    }
}

int main(int argc, char** argv)
{
    double complex x1, x2;
    double a = 1;
    double b = 1;
    double c = 1;
    double d;

    printf("Kvadraticka rovnica:\n%fx^2 + %fx + %f\n\n", a, b, c);
    vypocitajKvadratickuRovnicu(&a, &b, &c, &d, &x1, &x2);
    printf("Diskriminant\nD = %f\n\n", d);
    if(d > 0)
    {
        printf("x1 = %f\nx2 = %f\n", creal(x1), creal(x2));
    }
    else if(d == 0)
    {
        printf("x1 = %f\n", creal(x1));
    }
    else
    {
         printf("x1 = ( %+.2f ) + ( %+.2f )i\nx2 = ( %+.2f ) + ( %+.2f )i\n",
                creal(x1), cimag(x1), creal(x2), cimag(x2));
    }

    return 0;
}


