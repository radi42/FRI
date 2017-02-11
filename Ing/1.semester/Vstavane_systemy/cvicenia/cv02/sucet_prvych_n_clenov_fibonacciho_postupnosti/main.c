#include <stdio.h>
#include <stdlib.h>

int ntyFibonacci(int paPorCislo);

int main(int argc, char** argv) {
    int a = 0;  // poradove cislo posledneho clena suctu fib. postupnosti
    int sucet = 0;
    printf("Po kolky clen sa ma pocitat sucet Fibonacciho postupnosti\n");
    scanf("%d", &a);

    int i;
    for(i = 1; i <= a; i++)
    {
        printf("%d, ", ntyFibonacci(i));
        sucet += ntyFibonacci(i);
    }
    printf("\n");
    printf("Sucet prvych %d clenov Fibonnaciho postupnosti = %d\n", a, sucet);
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
