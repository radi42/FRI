#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char** argv) {
    float a = 0;
    float b = 0;
    float c = 0;
    float D = 0;
    float x1 = 0;
    float x2 = 0;

    printf("Zadajte koeficient a:\n");
    scanf("%f", &a);
    printf("Zadajte koeficient b:\n");
    scanf("%f", &b);
    printf("Zadajte koeficient c:\n");
    scanf("%f", &c);

    // Vypocitaj diskriminant
    D = pow(b,2) - (4*a*c);
    if(D < 0)
    {
        printf("D = %f => Rovnica nema realne riesenie.\n", D);
        return 1;
    }
    else
    {
        // Vypocitaj korene
        x1 = (-b - sqrt(D))/(2*a);
        x2 = (-b + sqrt(D))/(2*a);

        printf("Korene kvadratickej rovnice %fx^2+%fx+%f\n=> x1 = %f\n=> x2 = %f", a, b, c, x1, x2);
    }

    return 0;
}

// napr. pre rovnicu (x+1)(x-3) = x^2-2x-3 => x1 = -1, x2 = 3
