#include <stdio.h>
#include <stdlib.h>
#include <complex.h>

/// scitavanie polynomov funguje iba pre kladne jednociferne komplexne koeficienty a jednociferne kladne mocniny
char* sucetKomplexnychPolynomov(char* pP1, char* pP2)
{
    // zisti dlzku a stupen oboch polynomov
    int dlzkaP1, dlzkaP2 = 0;
    int stupenP1, stupenP2 = 0;

    int i=0;
    while(pP1[i] != '\0')
    {
        if(pP1[i] == '^')
        {
            if((pP1[i+1] - '0') > stupenP1) stupenP1 = pP1[i+1] - '0';
        }
        dlzkaP1++;
        i++;
    }
    printf("Dlzka polynomu p1 = %d\n", dlzkaP1);
    printf("Stupen polynomu p1 = %d\n", stupenP1);

    i=0;
    while(pP2[i] != '\0')
    {
        if(pP2[i] == '^')
        {
            if((pP2[i+1] - '0') > stupenP2) stupenP2 = pP2[i+1] - '0';
        }
        dlzkaP2++;
        i++;
    }
    printf("Dlzka polynomu p2 = %d\n", dlzkaP2);
    printf("Stupen polynomu p2 = %d\n", stupenP2);

    // naskladaj polynomy do poli
    double complex* poly1 = malloc((stupenP1 + 1) * sizeof(double complex));
    // inicializuj koeficienty polynomu na nuly
    for(i = stupenP1; i >= 0; i--)
    {
        poly1[i] = 0 + 0 * I;
    }

    i=0;
    int mocnina1;
    double real1, imag1;
    while(pP1[i] != '\0')
    {
//        if(pP1[i] == '-' && pP1[i+1] == '(')
//        {
//            // obrat znamienka koeficientom v zatvorke
//        }

        if(pP1[i] == '(')
        {
            // nacitaj realnu zlozku
            real1 = pP1[i+1] - '0';
            printf("%c ", pP1[i+1]);
            // nacitaj imaginarnu zlozku
            imag1 = pP1[i+3] - '0';
            printf("%c ", pP1[i+1]);
        }

        if(pP1[i] == '^')
        {
            // nacitaj mocninu
            printf("%c\n", pP1[i+1]);
            mocnina1 = pP1[i+1] - '0';
        }

        poly1[mocnina1] = real1 + imag1 * I;
        i++;
    }

    // kontrolny vypis
    for(i = stupenP1; i >= 0; i--)
    {
        printf("( %+.2f ) + ( %+.2f )i\n", creal(poly1[i]), cimag(poly1[i]));
    }

    // vytvor tretie pole o velkosti vacsieho polynomu

    // spocitaj koeficienty pri rovnakych mocninach
    return NULL;
}

int main(int argc, char** argv)
{
    char* p1 = "(1+1i)x^2+(2+2i)x^4+(3+3i)x^3+(3+0i)x^0";
    char* p2 = "(1+1i)x^2+(2+2i)x^3+(3+0i)x^1";
    sucetKomplexnychPolynomov(p1, p2);
//    printf("%s\n", sucetKomplexnychPolynomov(p1, p2));
    return 0;
}
