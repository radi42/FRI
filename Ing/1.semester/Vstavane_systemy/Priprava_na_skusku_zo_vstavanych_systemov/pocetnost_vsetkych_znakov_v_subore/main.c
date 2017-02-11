#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc, char **argv)
{
    int *pocetnostiZnakov = calloc(CHAR_MAX, sizeof(int));
    for(int i = 0; i < CHAR_MAX; i++) pocetnostiZnakov[i] = 0;

    FILE *subor = fopen("/home/andrej/Documents/Priprava_na_skusku_zo_vstavanych_systemov/pocetnost_vsetkych_znakov_v_subore/main.c", "r");

    char *buffer = malloc(200);
    char* buffer_addr = buffer;
    int pos;

    while(fgets(buffer, 199, subor))
    {
        buffer_addr = buffer;
        for(buffer_addr; buffer_addr < buffer + 200; buffer_addr++)
        {
            if(*buffer_addr == '\0') break;

            pos = (int)(*buffer_addr);
            pocetnostiZnakov[pos] = pocetnostiZnakov[pos] + 1;
        }
//        printf(buffer);
    }

    puts("");
    printf("Znak\tPocetnost\n");
    for(int i = 0; i < CHAR_MAX; i++)
        {
            printf("%c\t%d\n", i, pocetnostiZnakov[i]);
        }

    free(buffer);
    fclose(subor);
    free(pocetnostiZnakov);
    return 0;
}
