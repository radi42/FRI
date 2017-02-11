#include <stdio.h>
#include <stdlib.h>

int min(int paA, int paB, int paC);

int main(int argc, char** argv) {
    int a = 0;
    int b = 0;
    int c = 0;
    //printf("%d%d%d\n", a, b, c);
    printf("Prve cislo\n");
    scanf("%d", &a);
    printf("Druhe cislo\n");
    scanf("%d", &b);
    printf("Tretie cislo\n");
    scanf("%d", &c);
    printf("min = %d", min(a, b, c));
    return 0;
}

int min(int paA, int paB, int paC) {
    int tempMin = 0;

    // Prve porovnavanie
    if(paA < paB) tempMin=paA;
    else tempMin=paB;

    // Druhe porovnavanie
    if(tempMin < paC) return tempMin;
    else return paC;
}
