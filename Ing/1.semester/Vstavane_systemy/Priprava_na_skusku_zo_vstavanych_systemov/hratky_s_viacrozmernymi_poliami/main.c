#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    int matica[2][3];

    for(int i = 0; i < 2; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            matica[i][j] = i * 10 + j;
        }
    }

    for(int i = 0; i < 2; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            printf("%d\t", matica[i][j]);
        }
        printf("\n");
    }
    printf("\n");

    // Hratky so smernikmi a dvojrozmernym polom

    printf("*matica = matica[0]\t\t%p = %p\n", *matica, matica[0]);
    printf("**matica = matica[0][0]\t\t%d = %d\n", **matica, matica[0][0]);
    printf("*matica + 1 = &matica[1]\t%p = %p\t NEPLATI\n", *matica + 1, &matica[1]);
    printf("*matica + 1 = &matica[0][1]\t%p = %p\n", *matica + 1, &matica[0][1]);
    printf("*(matica + 1) = matica[1]\t%p = %p\n", *(matica + 1), matica[1]);
    printf("**(matica + 1) = matica[1][0]\t%d = %d\n", **(matica + 1), matica[1][0]);
    printf("*(*matica + 1) = matica[0][1]\t%d = %d\n", *(*matica + 1), matica[0][1]);

    printf("\n");

    int (*p_3) = matica;    // WARNING
    int *p_2 = *matica;
    int *p_1 = matica;      // WARNING

    printf("%p\n", p_3);
    printf("%p\n", p_2);
    printf("%p\n", p_1);
    return 0;
}
