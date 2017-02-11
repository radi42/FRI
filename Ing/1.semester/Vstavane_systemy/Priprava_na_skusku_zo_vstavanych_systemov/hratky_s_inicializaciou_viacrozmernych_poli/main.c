#include <stdio.h>
#include <stdlib.h>

void vypisMaticu(int matica[][3])
{
    for(int i = 0; i < 2; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            printf("%d\t", matica[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}

int main(int argc, char** argv)
{
    int matica_1[2][3] = { {0, 1, 2}, {3, 4, 5} };
    int matica_2[2][3] = { { 0, 1, 2 } };
    int matica_3[2][3] = { [1] = { 0, 1, 2 } };
    int matica_4[2][3] = { [1] = { 0, 1, 2 }, [0][2] = 9 };
    int matica_5[2][3] = { 0 };     // WARNING
    int matica_6[2][3] = { 0, 1 };  // WARNING
    int matica_7[][3] = { { 0, 1, 2 }, { 1, [2] = 1 } };

    // Nasledovne inicializacie nie su spravne
//    int matica_8[2][] = { { 0, 1, 2 }, { 3, 4, 5} };
//    int n = 3;
//    int m = 2;
//    int matica_9[2][n] = { 0 };
//    int matica_10[m][3] = { 0 };
//    int matica_11[m][n] = { 0 };

    printf("Matica 1:\n");
    vypisMaticu(matica_1);

    printf("Matica 2:\n");
    vypisMaticu(matica_2);

    printf("Matica 3:\n");
    vypisMaticu(matica_3);

    printf("Matica 4:\n");
    vypisMaticu(matica_4);

    printf("Matica 5:\n");
    vypisMaticu(matica_5);

    printf("Matica 6:\n");
    vypisMaticu(matica_6);

    printf("Matica 7:\n");
    vypisMaticu(matica_7);
    return 0;
}
