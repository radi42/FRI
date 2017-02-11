#include <stdio.h>
#include <stdarg.h>

int minInt(int pocetCisel, int a, ...)
{
    int min = a;
    printf("%d\n", a);
    va_list args;
    va_start(args, a);
//    printf("%d\n", pocetCisel);
    for(int i = 1; i < pocetCisel; i++)
    {
        int akt = va_arg(args, int);
        printf("%d\n", akt);
        if(akt < min) min = akt;
    }
    va_end(args);
    return min;
}

int main(int argc, char **argv)
{
    printf("Minimum z 2 cisel je\t%d\n", minInt(2, 10, 20));
    printf("Minimum z 3 cisel je\t%d\n", minInt(3, 10, 20, 5));
    printf("Minimum z 4 cisel je\t%d\n", minInt(4, 10, 20, 5, 7));
    return 0;
}
