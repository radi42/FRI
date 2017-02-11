#include <stdio.h>
#include <stdlib.h>

void vypisMaticu(int m, int n, int **matica)
{
    for(int i = 0; i < m; i++)
    {
        for(int j = 0; j < n; j++)
        {
            printf("%d\t", matica[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

void vypisMaticuCezSmerniky_2(int m, int n, int matica[m][n])
{
    for(int (*p_riadok)[n] = matica; p_riadok < matica + m; p_riadok++)
    {
        for(int *p_element = *p_riadok; p_element < *p_riadok + n; p_element++)
        {
            printf("%d\t", *p_element);
        }
        printf("\n");
    }
    printf("\n");
}

int main(int argc, char** argv)
{
    int pole1[10];
    int pole2[5];
    int (*pPoleA)[10];
    int (*pPoleB)[];    // smernik na pole nespecifikovanej velkosti - neuplny typ

    pPoleA = &pole1;
    printf("pPoleA = &pole1\t\t%p = %p\n", pPoleA, &pole1);

    pPoleB = &pole1;
    printf("pPoleB = &pole1\t\t%p = %p\n", pPoleB, &pole1);

    pPoleB = &pole2;
    printf("pPoleB = &pole2\t\t%p = %p\n", pPoleB, &pole2);

    //*pPoleA == pPoleA[0];  // je to pravda?
    printf("*pPoleA = pPoleA[0]\t%p = %p\n", *pPoleA, pPoleA[0]);

    printf("\n");

    // POROVNAVANIE pPoleA a pole1
    printf("POROVNAVANIE pPoleA a pole1\n");
    //*pPoleA == pPoleA[0] == pole1 == &pole1[0]    // dokaz ze to plati
    printf("*pPoleA\t\t%p\n", *pPoleA);
    printf("pPoleA[0]\t%p\n", pPoleA[0]);
    printf("pole1\t\t%p\n", pole1);
    printf("&pole1[0]\t%p\n", &pole1[0]);

    printf("\n");

    printf("**pPoleA\t%d\n", **pPoleA);
    printf("(*pPoleA)[0]\t%d\n", (*pPoleA)[0]);
    printf("*(pPoleA[0]\t%d\n", *(pPoleA[0]));
    printf("pPoleA[0][0]\t%d\n", pPoleA[0][0]);
    printf("pole1[0]\t%d\n", pole1[0]);

    printf("\n");
    printf("\n");

    // POROVNAVANIE pPoleB a pole2
    printf("POROVNAVANIE pPoleB a pole2\n");
    printf("*pPoleB\t\t%p\n", *pPoleB);
//    printf("pPoleB[0]\t%p\n", pPoleB[0]);         // neda sa
    printf("pole2\t\t%p\n", pole2);
    printf("&pole2[0]\t%p\n", &pole2[0]);

    printf("\n");

    printf("**pPoleB\t%d\n", **pPoleB);
    printf("(*pPoleB)[0]\t%d\n", (*pPoleB)[0]);
//    printf("*(pPoleB[0]\t%d\n", *(pPoleB[0]));    // neda sa
//    printf("pPoleB[0][0]\t%d\n", pPoleB[0][0]);   // neda sa
    printf("pole2[0]\t%d\n", pole2[0]);

    printf("\n");
    printf("\n");
    printf("Dvojrozmerne polia typu smernik na pole v dynamickej pamati\n");
    int (*pole)[3];     // pole je smernik na pole 3 intov
    pole = (int(*)[3]) malloc(2 * 3 * sizeof(int));     // alokuj 2 riadky a 3 stlpce o velkosti int
    pole[0][1] = 10;

    vypisMaticuCezSmerniky_2(2, 3, pole);

    free(pole);
    pole = NULL;

    return 0;
}


