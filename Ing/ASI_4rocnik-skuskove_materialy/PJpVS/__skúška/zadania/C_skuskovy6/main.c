/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Štvrtok, 2016, januára 21, 10:09
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
int main(int argc, char** argv) {
    FILE * subor;
    subor = fopen("main.c", "r");
    if (subor == NULL) {
        printf("Error reading file");
    }
    int pole[127];
    int i;
    for (i = 0; i < 128; i++) {
        pole[i] = 0;
    }
    char znak;
    int velkost = 0;
    while (fscanf(subor, "%c", &znak) != EOF) {
        velkost++;
        int j;
        for (j = 0; j < 128; j++) {
            if (((int) znak == j)) {
                pole[j]++;
            }
        }
    }
    for (i = 0; i < 128; i++) {
        if ((pole[i] > 0)&&(i != 10)) {
            if (i == 13) {
                printf("[%d] \\n je v subore %d krat\n", i, pole[i]);
            } else {
                printf("[%d] %c je v subore %d krat\n", i, i, pole[i]);
            }
        }
    }
    printf("dokopy je v subore %d zankov\n", velkost);
    return (EXIT_SUCCESS);
}

