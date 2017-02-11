#include <stdlib.h>
#include <stdio.h>

enum cis1 {JEDEN, DVA, TRI = 50, STYRI};
enum cis2 {PAT = 49, SEST, SEDEM = 50, OSEM};

int main()
{
    double c = JEDEN;
    double *d = &c;
    printf("%f\n", c);
    printf("%p\n", d);
    c = PAT + 1.0 + JEDEN;
    printf("%f\n", c);
    return 0;
}
