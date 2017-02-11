#include <stdio.h>
#include <stdlib.h>

int jePrvocislo(int paNum);

int main(int argc, char** argv) {
    int a = 0;
    printf("Zadajte cislo\n");
    scanf("%d", &a);
    if(jePrvocislo(a) == 1) printf("NIE JE prvocislo");
    else printf("JE prvocislo ");
    return 0;
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
