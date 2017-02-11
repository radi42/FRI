#include <stdio.h>
#include <stdlib.h>
#include <complex.h>

// Polynomy musia mat rovnaku dlzku!
void scitajPolynomy(double complex *pP1,
                    double complex *pP2,
                    double complex *pP3,
                    int polySize)
{
    int i;
    for(i = polySize - 1; i >= 0; i--)
    {
        pP3[i] = pP1[i] + pP2[i];
    }
}

void vypisPolynom(double complex *pPoly, int paVelkost)
{
    int i;
    for(i = paVelkost-1; i >= 0; i--)
    {
        if(creal(pPoly[i]) != 0 || cimag(pPoly[i]) != 0)
        {
            printf("(");
            if(creal(pPoly[i]) != 0)
            {
                printf("%+.2f", creal(pPoly[i]));
            }
            if(cimag(pPoly[i]) != 0)
            {
                printf("%+.2fi", cimag(pPoly[i]));
            }
            printf(")");
            printf("*x^%d", i);

            if(i > 0)
            {
                printf(" + ");
            }
        }
    }
}

void naplnPolynom1(double complex *pPoly, int paStupen)
{
    pPoly[0] = 1 + 1 * I;
    pPoly[1] = 0 + 0 * I;
    pPoly[2] = 4 + 4 * I;
}

void naplnPolynom2(double complex *pPoly, int paStupen)
{
    pPoly[0] = 1 + 1 * I;
    pPoly[1] = 2 + 2 * I;
    pPoly[2] = 0 + 0 * I;
}

int main(int argc, char** argv)
{
    int velkost = 3;
    double complex *p1 = malloc(velkost * sizeof(double complex));
    double complex *p2 = malloc(velkost * sizeof(double complex));

    naplnPolynom1(p1, velkost);
    naplnPolynom2(p2, velkost);

    printf("p1(x) = ");
    vypisPolynom(p1, velkost);
    printf("\n");
    printf("p2(x) = ");
    vypisPolynom(p2, velkost);
    printf("\n");

    double complex *p3 = malloc(velkost * sizeof(double complex));
    scitajPolynomy(p1, p2, p3, velkost);

    printf("p3(x) = p1(x) + p2(x)\n");
    printf("p3(x) = ");
    vypisPolynom(p3, velkost);

    free(p1);
    free(p2);
    free(p3);
    return 0;
}
