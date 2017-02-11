#include <stdlib.h>
#include <stdio.h>
#include <string.h>

struct osoba
{
    char meno[20];
    int vek;
    struct osoba *otec;
    struct osoba *mama;
};

void vypisOsobu(struct osoba *os)
{
    printf("Osoba %s, vek %d", os->meno, (*os).vek);
    if((*os).otec != NULL) printf(", otec: %s", os->otec->meno);
    if((*os).mama != NULL) printf(", mama: %s", os->mama->meno);
    printf("\n");
}

int main(int argc, char** argv)
{
    struct osoba otec = {"Milan"};
    struct osoba mama = {.otec = NULL, NULL, .meno = "Anna", 46};   // C99
    struct osoba dieta1, dieta2;
    struct osoba *p_otec = &otec;

    vypisOsobu(p_otec);
    vypisOsobu(&mama);

    printf("\n");

    strncpy(dieta1.meno, "Peter", 19);
    dieta1.meno[19] = '\0';
    dieta1.vek = 20;
    dieta1.otec = p_otec;
    dieta1.mama = &mama;

    dieta2 = dieta1;
    (*dieta2.mama).vek = 48;    // interesantne
    dieta2.otec->vek = 50;      // este interesantnejsie

    vypisOsobu(p_otec);
    vypisOsobu(&mama);
    vypisOsobu(&dieta1);
    vypisOsobu(&dieta2);

    return 0;
}
