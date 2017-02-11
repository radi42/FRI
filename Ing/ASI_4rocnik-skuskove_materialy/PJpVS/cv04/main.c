#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

// vymeni premenne na adresach 
// switchVariables(&a, &b);

void switchVariables(int *pa, int *pb) {
    int tmp = *pa;
    *pa = *pb;
    *pb = tmp;
}

int myRand(int from, int to) {
    return from + (rand() % to);
}

void getRandomArray(int array[], int size, int from, int to) {
    int i;
    for (i = 0; i < size; i++) {
        array[i] = myRand(from, to);
    }
}

void bubbleSort(int array[], int size) {
    int i, j;
    for (i = 0; i < size; i++) {
        for (j = 0; j < size; j++) {
            if (array[j] > array[j + 1]) {
                //nicer
                switchVariables(&array[j], &array[j + 1]);
                //quick?
                //switchVariables(array + j, array + j + 1);
            }
        }
    }
}

void showArray(int array[], int size) {
    int i;
    for (i = 0; i < size; i++) {
        printf("%d ", array[i]);
    }
}

bool main() {

    srand(time(NULL));
    
    int size = 30;
    int array[size];
    getRandomArray(array, size, 1, 100);
    bubbleSort(array, size);
    showArray(array, size);

    return (EXIT_SUCCESS);
}

