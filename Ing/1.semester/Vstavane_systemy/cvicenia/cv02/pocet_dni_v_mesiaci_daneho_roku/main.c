#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int jeRokPriestupny(int paRok);
int pocetDni(int mesiac, int rok);

int main(int argc, char** argv) {
    int rok = 0;
    int mesiac = 0;

    printf("Zadajte rok:\n");
    scanf("%d", &rok);
    printf("Zadajte mesiac:\n");
    scanf("%d", &mesiac);
    int pocet = pocetDni(mesiac, rok);
    if(pocet != -1) printf("%d. mesiac v roku %d ma %d dni.", mesiac, rok, pocet);
    else printf("Neplatne udaje\n");
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

int pocetDni(int mesiac, int rok)
{
    switch(mesiac)
    {
    case 1:
        return 30;
        break;
    case 2:
        if(jeRokPriestupny(rok) == 1)
        {
            printf("Rok je priestupny\n");
            return 29;
        }
        printf("Rok nie je priestupny\n");
        return 28;
        break;
    case 3:
        return 31;
        break;
    case 4:
        return 30;
        break;
    case 5:
        return 31;
        break;
    case 6:
        return 30;
        break;
    case 7:
        return 31;
        break;
    case 8:
        return 31;
        break;
    case 9:
        return 30;
        break;
    case 10:
        return 31;
        break;
    case 11:
        return 30;
        break;
    case 12:
        return 31;
        break;
    }
    return -1;
}
