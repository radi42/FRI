#include <stdio.h>
#include <stdlib.h>

void swapPointers(int **a, int **b)
{
    int *tmp = *a;
    *a = *b;
    *b = tmp;
}

int main(int argc, char** argv)
{
    int iA, iB;
    int *pA = &iA, *pB = &iB;

    printf("Zadaj 2 cele cisla:\n");
    scanf("%d%d", &iA, &iB);

    printf("Pred vymenou smernikov:\t a = %d\tb = %d\n", iA, iB);
    printf("Pred vymenou smernikov:\t &a = %p\t&b = %p\n", pA, pB);
    swapPointers(&pA, &pB);
    printf("Po vymene smernikov:\t a = %d\tb = %d\n", iA, iB);
    printf("Po vymene smernikov:\t &a = %p\t&b = %p\n", pA, pB);
    return 0;
}
