#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
    int a = 0;
    char quit;
    int pocetCisel = 0;
    double sucet = 0;

    printf("Pre ukoncenie programu a vypisanie suctu a sucinu stlacte 'q'\n");

    while(1)
    {
        printf("Zadajte cislo\n");
        scanf("%d", &a);
        scanf("%c", &quit); //dve muchy jednou ranou - Z KLAVESNICE NACITAM JEDINY ZNAK, ten sa priradi do dvoch premennych ako cislo aj ako znak a potom sa zariadim podla hodnot tychto premennych; hlavne ze nemusim zadavat dva krat z klavesnice, aj ked mam dva krat po sebe scanf
        printf("Cislo = %d\n", a);
        if(quit == 'q')    // 'q' = -48
        {
            // vypis sucet a priemer cisel
            printf("Sucet = %f\n", sucet);
            printf("Priemer = %f/%d = %f\n", sucet, pocetCisel, sucet/pocetCisel);
            return 0;
        }
        else
        {
            pocetCisel++;
            sucet += a;
        }
    }
    return 0;
}
