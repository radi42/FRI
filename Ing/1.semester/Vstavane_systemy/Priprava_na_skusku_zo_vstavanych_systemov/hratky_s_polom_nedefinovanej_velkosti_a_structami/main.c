#include <stdio.h>
#include <stdlib.h>

typedef struct dynArray
{
    int size;
    int elements[];
} DynArray;

void naplnDynArray(DynArray *dynArray)
{
    for(int i = 0; i < dynArray->size; i++) dynArray->elements[i] = i;
}

void vypisDynArray(DynArray *dynArray)
{
    for(int i = 0; i < dynArray->size; i++) printf("%d ", dynArray->elements[i]);
    printf("\n\n");
}

int main(int argc, char** argv)
{
    DynArray d1 = {0};

    printf("Zadajte velkost pola:\n");
    int n = 0;
    scanf("%d", &n);

    DynArray *d2 = malloc(sizeof(DynArray) + n * sizeof(int));
    (*d2).size = n;
    naplnDynArray(d2);

    n = n + 10;
    DynArray *d3 = malloc(sizeof(DynArray) + n * sizeof(int));
    *d3 = *d2;

    printf("DynArray 1:\n");
    vypisDynArray(&d1);
    printf("DynArray 2:\n");
    vypisDynArray(d2);
    printf("DynArray 3:\n");
    vypisDynArray(d3);
    printf("DynArray 3 pocet prvkov:\t%d\n", d3->size);

    free(d2);
    d2 = NULL;

    free(d3);
    d3 = NULL;
    return 0;
}
