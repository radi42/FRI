#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void findMinimum(int *array, int *size, int *minValue, int *minIndex)
{
    int i;
    *minValue = array[0];
    for(i=1; i<*size; i++)
    {
        if(array[i] < *minValue)
        {
            *minValue = array[i];
            *minIndex = i;
        }
    }
}

void fillArray(int *array, int *size)
{
    srand(time(NULL));
    int i;
    for(i=0; i<*size;i++,array++)
    {
        *array = rand() % 50;
    }
}

int main(int argc, char** argv)
{
    int min, minIndex = 0;
    int size = 5;
    int *arr = malloc(size * sizeof(int));
    fillArray(arr, &size);
    findMinimum(arr, &size, &min, &minIndex);

    // vypis pole
    int i;
    for(i=0; i<size; i++)
    {
        printf("%d\n", arr[i]);
    }

    printf("Minimum = %d\nIndex minima = %d\n", min, minIndex);
    free(arr);
    return 0;
}
