/*
 * File:   main.c
 * Author: miamka
 *
 * Created on Piatok, 2016, január 22, 8:57
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 *
 */


int main(int argc, char** argv)
{
    FILE *fPointer;
    int pocet=0;
//    printf("zadaj subor:");
    char nazov[200];
//    scanf("%s",nazov);
    strncpy(nazov, "/home/andrej/Documents/Priprava_na_skusku_zo_vstavanych_systemov/skuska_22_1/vstup.txt", 200);
    fPointer=fopen(nazov,"r");
    if (fPointer == NULL)
    {
        printf("neexistujuci subor\n");
        return (EXIT_FAILURE);
    }


    char struktura[20][256];
    for(int i = 0; i < 20; i++)
        for(int j = 0; j < 256; j++) struktura[i][j] = '\0';


    printf("nacitane:\n");
    while(fgets(struktura[pocet], 100, fPointer))
    {
        printf("%d| %s", pocet, struktura[pocet]);
        pocet++;
    }

    char pomoc[20];
    for(int g=0; g < pocet ; g++)
    {
        for(int h=g+1; h< pocet; h++)
        {
            if(strcmp(struktura[g],struktura[h]) > 0)
            {
                strcpy(pomoc,struktura[g]);
                strcpy(struktura[g],struktura[h]);
                strcpy(struktura[h],pomoc);
            }

        }
    }

    printf("\n");
    printf("\n");
    printf("zoradene:\n");
    for (int i = 0; i < pocet; i++)
    {
        printf("%s", struktura[i]);
    }

    char *slovo = malloc(256);
    for(int i = 0; i < 256; i++) slovo[i] = '\0';

    printf("\n");
    printf("Celkovy pocet riadkov:\t%d\n", pocet);
    printf("zadaj nove slovo: ");
    scanf("%s", slovo);

    strcpy(struktura[pocet], slovo);
    pocet=pocet+1;

    for (int i = 0; i < pocet; i++)
    {
        printf("%lu\n", strlen(struktura[i]));
        if(struktura[i][strlen(struktura[i]) - 1] != '\n') struktura[i][strlen(struktura[i])] = '\n';
    }

    for (int i = 0; i < pocet; i++)
    {
        printf("%s", struktura[i]);
    }

    FILE *fPointer1;
    fPointer1=fopen("vystup.txt","w");
    for(int g=0; g<pocet; g++)
    {
        fprintf(fPointer1,"%s",struktura[g]);
    }
    fclose(fPointer1);
    free(slovo);

    return (EXIT_SUCCESS);
}
