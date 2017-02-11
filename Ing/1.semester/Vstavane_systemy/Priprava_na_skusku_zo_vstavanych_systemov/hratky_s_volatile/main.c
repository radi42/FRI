#include <stdio.h>
#include <time.h>

int main()
{
    // Klasicka premenna
    double d = 0;
    clock_t start = clock();
    for(int i = 0; i < 100000000; i++) d += d*i;
    clock_t stop = clock();
    printf("Klasicka premenna: %.2f s.\n", (double)(stop - start)/CLOCKS_PER_SEC);

    // Volatilna premenna
    volatile double vd = 0;
    start = clock();
    for(int i = 0; i < 100000000; i++) vd += vd*i;
    stop = clock();
    printf("Volatilna premenna: %.2f s.\n", (double)(stop - start)/CLOCKS_PER_SEC);
    return 0;
}
