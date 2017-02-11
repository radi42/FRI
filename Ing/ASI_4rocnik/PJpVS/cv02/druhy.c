#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    char meno[100];

//    printf("zadaj svoje meno \n");
//    scanf("%s",meno);
//    printf("1 metoda scanf vypise: %s \n",meno);
//    scanf("%s",meno);
//    printf("2 metoda scanf vypise: %s \n",meno);
    /* scanf precita slovo len po medzeru, retazec s medzerou treba nacitat dvakrat */
    
    char str1[100];

    printf("zadaj svoje meno \n");
    gets(str1); /*gets treba nacitat dvakrat v pripade, ze predtym sa pouzilo scanf */
    gets(str1); /*gets dokaze precitat aj retazec s medzerou po enter */
    printf("metoda gets vypise: %s \n",str1);

    char str2[100];

    printf("zadaj svoje meno \n");
    fgets(str2,100,stdin); /*fgets precita a vypise retazec aj s medzerou a ukonci riadok */
    printf("metoda fgets vypise: %s \n",str2);
    
    return 0;
}