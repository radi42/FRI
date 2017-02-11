#include <stdlib.h>
#include <stdio.h>

// ****************** TYPY POLI ******************

int main(int argc, char** argv)
{
    int pole_1[5];      // pole pevnej velkosti

    int n = 5;
    int pole_2[n];      // pole variabilnej velkosti (VLA)

    int *pole_3 = (int *)malloc(5 * sizeof(int));

    printf("sizoef(pole_1) =\t%lu\n", sizeof(pole_1));
    printf("pole_1 =\t\t%p\n", pole_1);
    printf("&pole_1 =\t\t%p\n", &pole_1);
    printf("&(*pole) =\t\t%p\n\n", &(*pole_1));

    printf("sizoef(pole_2) =\t%lu\n", sizeof(pole_2));
    printf("pole_2 =\t\t%p\n", pole_2);
    printf("&pole_2 =\t\t%p\n", &pole_2);
    printf("&(*pole) =\t\t%p\n\n", &(*pole_2));

    printf("sizoef(pole_3) =\t%lu\n", sizeof(pole_3));
    printf("pole_3 =\t\t%p\n", pole_3);
    printf("&pole_3 =\t\t%p\n", &pole_3);
    printf("&(*pole) =\t\t%p\n\n", &(*pole_3));

    free(pole_3);
    pole_3 = NULL;
    return 0;
}
