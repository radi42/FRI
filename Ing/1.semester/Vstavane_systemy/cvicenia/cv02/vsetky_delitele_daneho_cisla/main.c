#include <stdio.h>
#include <stdlib.h>

void delitele(int paNum);

int main(int argc, char** argv) {
    int a = 0;
    printf("Zadajte cislo\n");
    scanf("%d", &a);
    printf("Delitele cisla:\n");
    delitele(a);
    return 0;
}

void delitele(int paNum) {
    int i;
    int numHalf = paNum / 2;
    for(i = 2; i < numHalf; i++)
    {
        if(paNum % i == 0)
        {
            printf("%d, ", i);
        }
    }
}
