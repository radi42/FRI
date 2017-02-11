#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void prvociselnyRozklad(int paNum);
int jePrvocislo(int paNum);

int main(int argc, char** argv) {
    int a = 0;
    printf("Zadajte cislo\n");
    scanf("%d", &a);
    printf("Prvociselny rozklad cisla %d\n", a);
    prvociselnyRozklad(a);
    return 0;
}

void prvociselnyRozklad(int paNum) {
    if(paNum <= 1)
    {
        printf("%s\n", "Neplatne cislo - iba kladne vacsie rovne 2");
        return;
    }

    int i;
    int trafiliSmePrvocislo = 1; // este nevieme ci sme trafili prvocislo - premenna nutna, lebo v pripade prvocisel > 3 cyklus for neprebehne dostatocny pocet krat
    for(i = 2; i <= paNum; i++)
    {
        if(jePrvocislo(i) == 0)
        {
            while(paNum % i == 0)
            {
                printf("%d ", i);
                paNum = paNum / i;
                trafiliSmePrvocislo = 0;

                //if(paNum == 1) break;
            }
        }
    }

    if(trafiliSmePrvocislo == 1) printf("%d ", paNum);
}

// Vracia 1 ak nie je prvocislo, 0 ak je prvocislo
int jePrvocislo(int paNum) {
    int i;
    int sqrtNum = sqrt(paNum) + 1;
    for(i = 2; i < sqrtNum; i++)
    {
        if(paNum % i == 0) return 1;
    }
    return 0;
}
