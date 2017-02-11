#include <stdio.h>

int main()
{
    printf("~1:\t\t%d\n", ~1);
    printf("~(char)1:\t%d\n", ~(char)1);
    printf("(char)~1:\t%d\n", (char)~1);

    printf("\n");

    int dword = 123;

    printf("dword & (1<<n)\n");
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, dword & (1<<i));

    printf("\n");
    printf("\n");

    printf("(dword>>n) & 1\n");
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, (dword>>i) & 1);

    printf("\n");
    printf("\n");

    dword = 0;
    printf("(dword>>n) & 1\t dword = 0\n");
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, (dword>>i) & 1);

    printf("\n");
    printf("\n");

    dword = dword | (1<<7) | (1<<15) | (1<<23);
    printf("(dword>>n) & 1\t zmen zopar bitov na 1\n");
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, (dword>>i) & 1);

    printf("\n");
    printf("\n");

    dword = dword & ~(1<<7);
    printf("(dword>>n) & 1\t zmen zopar bitov na 0\n");
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, (dword>>i) & 1);

    printf("\n");
    printf("\n");

    printf("Zmen vsetky bity na opacnu hodnotu\n");
    for(int i = 0; i < 32; i++) dword = dword ^ (1<<i);
    for(int i = 0; i < 32; i++) printf("%d:\t%d\n", i, (dword>>i) & 1);

    printf("\n");
    printf("\n");

    return 0;
}
