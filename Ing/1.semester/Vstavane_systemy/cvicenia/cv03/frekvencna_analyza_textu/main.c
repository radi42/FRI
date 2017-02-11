#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    char* strasneDlhyRetazec = malloc(65536);
    printf("Zadajte strasne dlhy retazec:\n");
    scanf("%s",strasneDlhyRetazec);
    printf("%s\n", strasneDlhyRetazec);
    printf("Frekvencna analyza textu:\n");

    int i = 0;
    int j = 0;
    int count;
    char c;
    while(strasneDlhyRetazec[i] != '\0')
    {
        count = 0;
        c = strasneDlhyRetazec[i];

        while(c == strasneDlhyRetazec[j] && strasneDlhyRetazec[j] != '\0')
        {
            count++;
        }

        printf("%c:\t%d", c, count);
    }

    return 0;
}
