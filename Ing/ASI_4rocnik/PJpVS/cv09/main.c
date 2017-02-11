/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, novembra 16, 11:23
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */

void vypis(int cisla[], int dlzka)
{
    int i;
    for (i=0; i<dlzka; i++)
    {
        printf(" %d", cisla[i]);//vracia 0-91                
    }
    printf("\n");
}

int vzostup (const void* a, const void* b)
{
    int pomA = *(int*)a;
    int pomB = *(int*)b;
    if (pomA<pomB)
	return -1;
    else if(pomA>pomB)
	return 1;
    else return 0;	
}

int zostup (const void* a, const void* b)
{
    int pomA = *(int*)a;
    int pomB = *(int*)b;
    if (pomA>pomB)
        return -1;
    else if(pomA<pomB)
        return 1;
    else return 0;     
}

int main(int argc, char** argv) {
    
    FILE *myFile;
    myFile = fopen("aaa.txt", "r");

    int cisla[10];
    int i;

    if (myFile == NULL)
    {
        printf("Error Reading File\n");
        exit (0);
    }
    for (i = 0; i < 10; i++)
    {
        fscanf(myFile, "%d,", &cisla[i] );
    }

    printf("\n");
    
    for (i = 0; i < 10; i++)
    {
           printf("%d ", cisla[i]);
    }

    fclose(myFile);
    
    qsort(cisla, i, sizeof(int), vzostup);
    printf("\n");
    vypis(cisla, i);
    
    
    FILE *f = fopen("vzostup.txt", "w");
    if (f == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }
 
    int j=0;
    for (j=0;j<i;j++)
    {
        fprintf(f, "%d\n ", cisla[j]);
    }
 
    fclose(f);
    
    
    qsort(cisla, i, sizeof(int), zostup);
    //printf("\n");
    vypis(cisla, i);
    
    FILE *g = fopen("zostup.txt", "w");
    if (g == NULL)
    {
        printf("Error opening file!\n");
        exit(1);
    }
 
    int k=0;
    for (k=0;k<i;k++)
    {
        fprintf(g, "%d\n ", cisla[k]);
    }
 
    fclose(g);
   
    return (EXIT_SUCCESS);
}

