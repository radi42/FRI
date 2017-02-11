/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, novembra 2, 11:27
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
 * 
 */
int main(int argc, char** argv) {

    int ** pole;
    
    pole = malloc(10 * sizeof(int*));
    
    for (int i=0; i<10; i++)
        pole[i] = malloc(20 * sizeof(int));
        
    srand(time(NULL));
    for (int i=0; i<10; i++)
        for (int j=0; j<20; j++)
            pole[i][j] = rand() % 51;
    
    for (int i=0; i<10; i++)
        for (int j=0; j<20; j++)
            printf("%d ",pole[i][j]); //upravit vypis ako maticu
    
    return (EXIT_SUCCESS);
}

