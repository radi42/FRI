#include <stdio.h>

void init(int *a, signed char *c, double *x)
{
    *a = 1;
    *c = 2;
    *x = 3.0;
}

int main()
{
    int a;
    signed char c;
    double x;
    init(&a, &c, &x);

    printf("5 + !(3 && 0) =\t\t\t%d\n", 5 + !(3 && 0));
    printf("x * a && c =\t\t\t%d\n", x * a && c);
    printf("4 + 5 * c =\t\t\t%d\n", 4 + 5 * c);
    printf("2 || x != 10 =\t\t\t%d\n", 2 || x != 10);
    printf("(x = --a) && (a = c++) =\t%d\n", (x = --a) && (a = c++));
    init(&a, &c, &x);
    printf("(x = a--) && (a = c) =\t\t%d\n", (x = a--) && (a = c));
    init(&a, &c, &x);
    printf("a / 7 =\t\t\t\t%d\n", a / 7);
    printf("a++ < c-- ? x + 2 : c - a =\t%f\n", a++ < c-- ? x + 2 : c - a);
    return 0;
}
