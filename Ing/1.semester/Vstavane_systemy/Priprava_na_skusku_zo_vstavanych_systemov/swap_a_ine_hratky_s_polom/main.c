#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ARR_SIZE 3

void naplnPole(int *pole)
{
    for(int i = 0; i < ARR_SIZE; i++)
    {
        pole[i] = i+1;
    }
}

void vypisPole(int *pole)
{
    for(int i = 0; i < ARR_SIZE; i++)
    {
        printf("%d\n", pole[i]);
    }
}

void prehodDveCisla(int *a, int *b)
{
    int tmp = *a;
    *a = *b;
    *b = tmp;
}

int main(int argc, char** argv)
{
    int pole[ARR_SIZE] = {0};

    naplnPole(pole);
    vypisPole(pole);
    putc('\n', stdout);
    prehodDveCisla(&pole[1], &pole[2]);
    vypisPole(pole);
    return 0;
}

