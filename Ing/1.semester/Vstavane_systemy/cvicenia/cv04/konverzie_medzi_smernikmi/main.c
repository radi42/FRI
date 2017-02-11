#include <stdio.h>
#include <stdlib.h>
#include <limits.h> // limity pre cele cisla, <float.h> -> limity pre desatinne cisla

int main(int argc, char** argv)
{
    int i = INT_MAX, *pi = &i;
    short *ps = (short *) pi;
    int *pi_2 = (int * ) pi;

    printf("*pi = %d\n", *pi);
    printf("*ps = %d, *(ps + 1) = %d\n", *ps, *(ps + 1));
    printf("*pi_2 = %d\n", *pi_2);

    printf("pi = %p\n", pi);
    printf("ps = %p, ps + 1 = %p\n", ps, ps + 1);
    printf("pi_2 = %p\n", pi_2);
    return 0;
}

