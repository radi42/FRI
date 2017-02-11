#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* substitute(char *paSrc, char *paPattern, char *paSub)
{
    int srcSize = 0;
    int patternSize = 0;
    int subSize = 0;
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
        if(paPattern[i] == '\0') break;
        patternSize++;
        i++;
    }
    printf("patternSize = %d\n", patternSize);

    i = 0;
    while(1)
    {
        if(paSub[i] == '\0') break;
        subSize++;
        i++;
    }
    printf("subSize = %d\n", subSize);


    i = 0;      //iterovanie cez src
    int j = 0;  //iterovanie cez pattern
    int k = 0;
    int rovnake = 0;    // rovnake: 1, rozne: 0
    while(1)
    {
        rovnake = 0;
        if(paSrc[i] == '\0') break;

        j = 0;
        if(paSrc[i] == paPattern[j])
        {
            k = i;
            for(j; j < patternSize; j++)
            {
                if(paPattern[j] == paSrc[k])
                {
                    rovnake = 1;
                }
                else
                {
                    rovnake = 0;
                    break;
                }
                k++;
            }

            if(rovnake == 1)
            {
                k = i;
                j = 0;
                for(j; j < subSize; j++)
                {
                    paSrc[k] = paSub[j];
                    k++;
                }
            }
        }
        i++;
    }

    return paSrc;
}

int main(int argc, char** argv)
{
    char *src = malloc(101);
    strcpy(src, "abc456abc789abc");
    printf("Povodny retazec:\n%s\n", src);

    char *pattern = malloc(101);
    strcpy(pattern, "abc");

    char *sub= malloc(101);
    strcpy(sub, "xyz");
    printf("Nahrad podretazec\n%s\nretazcom\n%s\n", pattern, src);
    substitute(src, pattern, sub);
    printf("Nahradeny retazec:\n%s\n", src);

    free(src);
    free(pattern);
    free(sub);
    return 0;
}

