#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int ntyFibonacci(int paPorCislo);

int main(int argc, char** argv) {
    int a = 0;
    printf("Zadajte poradove cislo Fibonacciho postupnosti\n");
    scanf("%d", &a);
    printf("%d. clen Fibonnaciho postupnosti = %d\n", a, ntyFibonacci(a));
    return 0;
}

int ntyFibonacci(int paPorCislo) {
    int ntyClen = 0;
    // Prve dva cleny Fibonacciho postupnosti
    if(paPorCislo == 1 || paPorCislo == 2) return 1;

    int a = 1;
    int b = 1;
    int i = 0;
    for(i = 1; i < paPorCislo - 1; i++)
    {
        ntyClen = a + b;
        a = b;
        b = ntyClen;
    }
    return ntyClen;
}
