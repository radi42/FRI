/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Streda, 2016, januára 20, 16:04
 */

#include <stdio.h>
#include <stdlib.h>

int overSam(char znak) {
    switch ((int) znak) {
        case 65: return 1;
        case 69: return 1;
        case 73: return 1;
        case 79:return 1;
        case 85:return 1;
        case 89:return 1;
    }
    return 2;
}

void vypis(char * string, int co) {
    int i;
    for (i = 0; i < 200; i++) {
        if (((int) string[i] < 91 && (int) string[i] > 64) || ((int) string[i] < 123 && (int) string[i] > 96)) {
            if (co == 0) {
                if (overSam(toupper(string[i])) == 1) {
                    printf("%c", string[i]);
                }
            } else if (co == 1) {
                if (overSam(toupper(string[i])) == 2) {
                    printf("%c", string[i]);
                }
            }
        } else if (co == 2) {
            printf("%c", string[i]);
        }
    }
}

int main(int argc, char** argv) {
    char *string;
    string = malloc(200 * sizeof (char*));
    gets(string);
    printf("Retazec je: %s\n", string);
    printf("Samohlasky su:");
    vypis(string, 0);
    printf(" \n");
    printf("Spoluhlasky su:");
    vypis(string, 1);
    printf(" \n");
    printf("Znaky su:");
    vypis(string, 2);
    printf(" \n");
    return (EXIT_SUCCESS);
}

