#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

float **create(int m, int n)
{
    // alokujem riadky. riadky su typu float*
    float** mat = malloc(m * sizeof(float*));    //taketo pole je rozhadzane v pamati; ked na jednej strane urobim n hviezdiciek, na druhej strane bude n-1 hviezdiciek

    // inicializacia poloziek pola. polozky pola su smerniky na polia floatov
    for(int i = 0; i < n; i++)
    {
        mat[i] = malloc(n * sizeof(float));     // alokuj polozky
        memset(mat[i], 0, n * sizeof(float));   // inicializuj polozky
    }
    return mat;
}

// funkcia uvolni maticu a nastavi odkaz na povodnu maticu na NULL
// ak ma nieco funkcia vratit cez parameter, treba tam dat o jednu hviezdicu navyse.
// pri volani tejto fukcie potom ako parameter treba dat adresu dvojrozmerneho pola
void delete(int m, int n, float ***matrix)
{
//    (*matrix)[][]
    // dealokaciu robime v opacnom poradi ako alokaciu
    // najskor uvolnime stlpce, potom riadky
    for(int i = 0; i < m; i++)
    {
        free(*matrix[i]);   // uvolni riadok
    }

    free(*matrix);
    *matrix = NULL;
}

//float **delete(int m, int n, float **matrix)
//{
//    // dealokaciu robime v opacnom poradi ako alokaciu
//    // najskor uvolnime stlpce, potom riadky
//    for(int i = 0; i < m; i++)
//    {
//        free(matrix[i]);   // uvolni riadok
//    }
//
//    free(matrix);
//}

int main(int argc, char **argv)
{
    int m = 4;
    int n = 5;
    float **mat = create(m, n);

    printf("%p\n", mat);    // vypise adresu
    delete(m, n, &mat);
//    mat = NULL;   // funkcia delete uz
    printf("%p\n", &mat);    // vypise adresu
    return 0;
}
