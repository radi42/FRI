/* 
 * File:   main.c
 * Author: IKO
 *
 * Created on Streda, 2016, januára 20, 12:12
 */

#include <stdio.h>
#include <stdlib.h>

int velkostSuboru(FILE *subor) {
    int zaciatok = ftell(subor);
    fseek(subor, 0L, SEEK_END);
    int velkost = ftell(subor);
    fseek(subor, zaciatok, SEEK_SET);
    return velkost;
}

/*
 * 
 */
void nacitajString(char * nazov) {
    FILE*subor;
    FILE*subor2;
    subor = fopen(nazov, "r");
    subor2= fopen("pis.txt","w");
    char **string;
    string = malloc(3 * sizeof (int*));
    int i;
    for (i = 0; i < 3; i++) {
        string[i] = malloc(200 * sizeof (char*));
        fgets(string[i], 200, subor);
        printf("%s\n", string[i]);
        int j;
        for (j = 0; j < 200; j++) {
            if ((int) string[i][j] < 91 && (int) string[i][j] > 64) {
                string[i][j] =tolower(string[i][j]);
            } else if ((int) string[i][j] < 123 && (int) string[i][j] > 96) {
                string[i][j] =toupper(string[i][j]);
            }
        }
        
        printf("%s\n", string[i]);
        fputs(string[i],subor2);
        
        free(string[i]);
    }
    free(string);
    fclose(subor);

}

int main(int argc, char** argv) {
    nacitajString("Citaj.txt");
    return (EXIT_SUCCESS);
}

