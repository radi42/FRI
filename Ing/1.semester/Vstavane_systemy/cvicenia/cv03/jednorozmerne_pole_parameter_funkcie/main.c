#include <stdio.h>
#include <stdlib.h>

void funkcia(int n, int pole[n])
{
    printf("Pocet prvkov v poli odovzdanom ako parameter je: %d\n", sizeof(pole)/sizeof(int));
}

int main(int argc, char** argv) {
    int pole[10] = {};
    printf("Pocet prvkov v poli je: %ld\n", sizeof(pole)/sizeof(int));
    funkcia(10, pole);

    return 0;
}
