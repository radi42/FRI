#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int jeRokPriestupny(int paRok);

int main(int argc, char** argv) {
    int rok = 0;

    printf("Zadajte rok:\n");
    scanf("%d", &rok);
    printf("Rok %d ", rok);
    if(jeRokPriestupny(rok) == 1) printf("je priestupny");
    else printf("nie je priestupny");
    return 0;
}

// vracia 1 ak je priestupny, 0 ak nie je
int jeRokPriestupny(int paRok)
{
    // kazdy stvrty rok je priestupny, ale roky delitelne 100 su prestupne len vtedy, ak su delitelne 400
    printf("Je delitelny 100 %d\n", paRok % 100 == 0);
    printf("Je delitelny 400 %d\n", paRok % 400 == 0);
    printf("Je delitelny 4 %d\n", paRok % 4 == 0);
    return ((!(paRok % 100 == 0) && (paRok % 4 == 0)) || (paRok % 400 == 0));
}
