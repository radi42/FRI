#include <stdio.h>
#include <stdlib.h>

void swapInt(int *paInt1, int *paInt2)
{
    int swap = *paInt1;
    *paInt1 = *paInt2;
    *paInt2 = swap;
}

int main(int argc, char** argv)
{
    int a = 5;
    int b = -4;
    // predtym
    printf("Predtym:\na = %d\tb = %d\n", a, b);
    // prehod
    swapInt(&a, &b);
    // potom
    printf("Swap:\na = %d\tb = %d\n", a, b);
    return 0;
}

