#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* strIns(char *paDest, int paPos, char *paSrc)
{
    int destSize = 0;
    int srcSize = 0;
    int i;

    i = 0;
    while(1)
    {
        if(paSrc[i] == '\0') break;
        srcSize++;
        i++;
    }
    printf("srcSize = %d\n", srcSize);

    i = 0;
    while(1)
    {
        if(paDest[i] == '\0') break;
        destSize++;
        i++;
    }
    printf("destSize = %d\n", destSize);

    i = 0;
    while(1)
    {
        if(paDest[i] == '\0') break;
        else if(i == paPos)
        {
            int j;
            for(j = destSize - 1; j >= paPos; j--)
            {
                paDest[j+srcSize] = paDest[j];
            }

            int k = 0;
            for(j++; j < paPos + srcSize; j++)
            {
                paDest[j] = paSrc[k];
                k++;
            }
        }
        i++;
    }
    return paDest;
}

int main(int argc, char** argv)
{
    char *dest = malloc(101);
    strcpy(dest, "0123456789");
    printf("Povodny retazec:\n%s\n", dest);
    char *src = malloc(101);
    strcpy(src, "abc");
    printf("Vkladany retazec:\n%s\n", src);
    strIns(dest, 5, src);
    printf("Rozsireny retazec:\n%s\n", dest);
    return 0;
}
