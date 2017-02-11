/* 
 * File:   main.c
 * Author: z500
 *
 * Created on Pondelok, 2015, októbra 5, 12:09
 */

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

using namespace std;

int main(int argc, char** argv) {
    char rodnecislo[50];
    int pocet;
    int rok;
    int mesiac;
    int den;
    int pom;
    char str[50];
fgets(str, 49,stdin);
str[strlen(str)]='\0';
int pomDlzka=strlen(str);
if (pomDlzka < 9 || pomDlzka > 10)
    return(EXIT_FAILURE);
 
for(int i=0;i<pomDlzka;i++){
    if(isdigit(str[i]))
        return(EXIT_FAILURE);
}
 
 
 
return (EXIT_SUCCESS);
 
   
}