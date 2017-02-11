#include <stdio.h>
#include <stdlib.h>

char* trim(char *retazec)
{
    char *ret = retazec;
    char *orezanyRet = "";
    int indexZac = 0;
    int indexKon = 0;
    int dlzkaRetazca = 0;

    printf("Prijaty retazec:\n");

    // zisti dlzku retazca
    while(*(ret) != '\0')
    {
        printf("%c", *(ret));
        dlzkaRetazca = dlzkaRetazca + 1;
        ret++;
    }
    printf("\n");
    printf("Dlzka retazca = %d\n", dlzkaRetazca);

    // zisti poziciu prveho znaku, ktory nie je medzera
    ret = retazec;         // kedze sa nam adresa posunula jej inkrementovanim v predoslom cykle, musime ju resetovat
    while(*(ret) != '\0')
    {
        if(*(ret) == ' ')
        {
            indexZac++;
            ret++;
        }
        else break;
    }

    printf("Index prveho znaku = %d\n", indexZac);

    // zisti poziciu posledneho znaku, ktory nie je medzera
    // kedze sa nam adresa posunula jej inkrementovanim v predoslom cykle, musime ju resetovat na koniec, ale este pred nulovy terminator
    ret = retazec + dlzkaRetazca - 1;   // musime odpocitat jednotku, lebo nechceme brat koncovy null terminator
    while(*(ret) != '\0')
    {
        if(*(ret) == ' ')
        {
            indexKon++;
            ret--;
        }
        else break;
    }

    indexKon = dlzkaRetazca - indexKon - 1;
    printf("Index posledneho znaku = %d\n", indexKon);

    int i = indexZac;
    orezanyRet = malloc(indexKon-indexZac+2);   // 12 - 6 + 1 = 7 (dlzka retazca bez medzier) + 1 (null terminator) = 8
    char *adrOrezRet = orezanyRet;      // uloz adresu prveho prvku orezaneho retazca
    ret = retazec;      // resetuj adresu na adresu povodneho retazca
    ret = ret + indexZac;
    while(i <= indexKon)
    {
        *(orezanyRet) = *(ret);
        orezanyRet++;
        ret++;
        i++;
    }
    *(orezanyRet) = '\0';       // aby to bol retazec, musi mat na konci null terminator

    printf("Vypisany orezany retazec po znakoch\n");
    orezanyRet = adrOrezRet;        // reset adresy orezaneho retazca
    i = 0;
    while(i <= indexKon)
    {
        printf("%c", *(orezanyRet));
        orezanyRet++;
        i++;
    }
    printf("\n");
    return adrOrezRet;
}

int main(int argc, char** argv)
{
    char *string = "      retazec      ";
    printf("Povodny retazec: \n%s\n", string);
    printf("Adresa prveho znaku orezaneho retazca: \n%p\n", trim(string));
    return 0;
}
