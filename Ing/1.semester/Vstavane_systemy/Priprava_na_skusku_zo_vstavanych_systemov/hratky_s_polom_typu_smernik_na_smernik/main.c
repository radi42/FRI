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

int main(int argc, char** argv)
{
    int **pole;
    pole = (int **)malloc(2 * sizeof(int*));    // alokuj pole o 2 riadkoch
    pole[0] = (int *)malloc(3 * sizeof(int));   // a 3 stlpcoch
    pole[1] = (int *)malloc(3 * sizeof(int));   // a 3 stlpcoch

    free(pole[0]);
    free(pole[1]);
    free(pole);
    pole = NULL;
    return 0;
}
