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
    int* pole[2];
    pole[0] = (int *)malloc(3 * sizeof(int));
    pole[1] = (int *)malloc(3 * sizeof(int));

    pole[0][1] = 10;
    vypisMaticu(2, 3, pole);

    free(pole[0]);
    pole[0] = NULL;
    free(pole[1]);
    pole[1] = NULL;
    return 0;
}

