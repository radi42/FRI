#include <stdio.h>
#include <stdlib.h>

void vypisRetazce(int m, int n, char matica[][n])
{
    for(int i = 0; i < m; i++)
    {
        printf("%s\t", matica[i]);
    }
    printf("\n");
}

int main(int argc, char** argv)
{
    char retazce1[10][20];      // staticke pole retazcov
    char retazce2[10][20] = {"ahoj", "ano", "nie"};
    char retazce3[][20] = {"ahoj", "ano", "nie"};
//    char retazce4[10][] = {"ahoj", "ano", "nie"};     // toto nefunguje - nevie, kolko ma najviac naalokovat stlpcov
//    char retazce5[][] = {"ahoj", "ano", "nie"};       // toto nefunguje - nevie, kolko ma najviac naalokovat riadkov a stlpcov

    // deklaracie s vyuzitim smernikov
    char* retazce6[10];     // pole smernikov na char
    char(* retazce7)[10];   // smernik na pole charov
    char** retazce8;        // smernik na smernik na char

    // rozne hratky s polom retazcov
    char retazce11[10][20] = {"ahoj", "ano", "nie"};
    vypisRetazce(10, 20, retazce11);

    char retazce12[][20] = {"ahoj", "ano", "nie"};
    vypisRetazce(3, 20, retazce12);

    char *retazce13[10] = {"ahoj", "ano", "nie"};
    printf("%s\t", retazce13[0]);
    printf("%s\t", retazce13[1]);
    printf("%s\t\n", retazce13[2]);

    char *retazce14[] = {"ahoj", "ano", "nie"};
    printf("%s\t", retazce14[0]);
    printf("%s\t", retazce14[1]);
    printf("%s\t\n", retazce14[2]);

    char (*retazce15)[20] = &"ahoj";    // WARNING na nekompatibilny typ smernika
    printf("%s\t\n", retazce15[0]);

    char (*retazce16)[5] = &"ahoj";
    printf("%s\t\n", retazce16[0]);

    char (*retazce17)[] = &"ahoj";
    printf("%s\t\n", retazce17);

    char *retazce18 = *retazce11;
    printf("%s\t\n", retazce18);

    char *retazce19 = *retazce13;
    printf("%s\t\n", retazce19);
    return 0;
}
