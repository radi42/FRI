#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* caesarovaSifra(char *paSrc, char *paDest, int paShift)
{
    int i = 0;
    while(paSrc[i] != '\0')
    {
        if(paSrc[i] != ' ' &&
            (paSrc[i] >= 'a' && paSrc[i] <= 'z') ||
            (paSrc[i] >= 'A' && paSrc[i] <= 'Z') ||
            (paSrc[i] >= '0' && paSrc[i] <= '9'))
        {
            if(paSrc[i] >= 'a' && paSrc[i] <= 'z') paDest[i] = (paSrc[i] - 'a' + paShift) % 26 + 'a';
            if(paSrc[i] >= 'A' && paSrc[i] <= 'Z') paDest[i] = (paSrc[i] - 'A' + paShift) % 26 + 'A';
            if(paSrc[i] >= '0' && paSrc[i] <= '9') paDest[i] = (paSrc[i] - '0' + paShift) % 10 + '0';
        }
        else
        {
            paDest[i] = paSrc[i];
        }
        i++;
    }

    paDest[i] = '\0';
    return paDest;
}

int main(int argc, char** argv)
{
    int velkostRetazca = 100;
    int alokovanaVelkost = velkostRetazca + 1;  // +1 na null terminator
    char *src = malloc(alokovanaVelkost);
    strcpy(src, "Hello Worldz! 1234567890");
    char *dest = malloc(alokovanaVelkost);
    printf("Povodny retazec: \n%s\n", src);
    int shift = 1;
    char *destString = caesarovaSifra(src, dest, shift);
    printf("Adresa prveho znaku orezaneho retazca: \n%p\n", dest);
    printf("Adresa prveho znaku orezaneho retazca (funkcia): \n%p\n", destString);
    printf("Zasifrovany retazec: \n%s\n", destString);

    free(src);
    free(dest);
    return 0;
}

