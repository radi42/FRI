#include <stdio.h>
#include <stdlib.h>

void vypisMaticu(int m, int n, int matica[m][n])
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

void vypisMaticuCezSmerniky(int m, int n, int matica[m][n])
{
    for(int i = 0; i < m; i++)
    {
        for(int j = 0; j < n; j++)
        {
            printf("%d\t", *(*(matica + i)+j));
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
    int matica[2][3] = { {1,2,3}, {4,5,6} };
    vypisMaticu(2, 3, matica);
    vypisMaticuCezSmerniky(2, 3, matica);
    vypisMaticuCezSmerniky_2(2, 3, matica);
    return 0;
}

