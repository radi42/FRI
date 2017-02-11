#include <stdio.h>
#include <stdlib.h>

#define VELKOST_POLA 10

void naplnPole(int n, int pole[])
{
    int i;
    for(i=0; i<n; i++, pole++)  // i sa mi zvysuje po jednotke, pole sa mi zvysuje po styroch (lebo int ma 4 bajty)
    {
        *pole=i;    // udajne rychlejsie nez pole[i], lebo pri pole[i] vy sa musela zobrat bazicka adresa a pripocitat offset
    }
}

void vypisPole2(int* zac, int* kon)
{
    int* akt = zac;
    while(akt<=kon)
    {
        printf("%d ", *akt);
        akt++;
    }
    printf("\n");
}

int main(int argc, char** argv)
{
    int pole[VELKOST_POLA];
    naplnPole(VELKOST_POLA, pole);
    vypisPole2(pole, pole + VELKOST_POLA - 1);
    return 0;
}
