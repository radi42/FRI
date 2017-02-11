#include <stdio.h>
#include <time.h>

void fun1(int n, double *pA, double *pB)
{
    for(int i = 0; i < n; i++)
    {
        *pA += *pB;
        pA++;
        pB++;
    }
}

void fun2(int n, double *pA, double * restrict pB)
{
    for(int i = 0; i < n; i++)
    {
        *pA += *pB;
        pA++;
        pB++;
    }
}

int main()
{
#define MAXSIZE 100000000

    static double pole[MAXSIZE];

    clock_t start = clock();
    fun1(MAXSIZE/2, pole, pole + MAXSIZE/2);
    clock_t stop = clock();
    printf("Klasicke parametre: %.2f s.\n", (double)(stop - start)/CLOCKS_PER_SEC);

    start = clock();
    fun2(MAXSIZE/2, pole, pole + MAXSIZE/2);
    stop = clock();
    printf("Restrict parametre: %.2f s.\n", (double)(stop - start)/CLOCKS_PER_SEC);
    return 0;
}
