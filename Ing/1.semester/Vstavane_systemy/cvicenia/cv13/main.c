#include <stdio.h>
#include <stdio.h>
#include <string.h>

int compareInt(const void *a, const void *b)
{
    const int *pomA = (const int *)a;   // smernik na int o velkosti 8 bajtov
    const int pomB = *((const int *)b); // premenna int o velkosti 4 bajty

    if(*pomA < pomB) return -1;
    else if(*pomA == pomB) return 0;
    else return 1;
}

int main()
{
#define SIZE 10
    int pole[SIZE]; // velkost pola definovana cez konstantu "define" bude znama uz pocas kompilacie. ak by sme to dali ako
    for(int i = 0; i<SIZE; i++)
    {
        pole[i] = rand() % 100;
    }

    for(int i = 0; i<SIZE; i++)
    {
        printf("%d", pole[i]);
        puts("");
    }

    puts("");
    puts("");

    qsort(pole, SIZE, sizeof(*pole), compareInt);

    for(int i = 0; i<SIZE; i++)
    {
        printf("%d", pole[i]);
        puts("");
    }
}


//// a je teraz smernik na pole 10 charov
//int compareStrings(const void *a, const void *b)
//{
//    const char (*pomA)[10] = (const char (*)[10])a;   // pomA je smernik na pole 10 charov; pravu stranu spravne pretypovat
//    const char (*pomB)[10] = (const char (*)[10])b;   // pole charov o velkosti SIZE bajtov
//    return strcmp(*pomA, pomB);
//}
//
//int main()
//{
//#define SIZE 5
//    char pole[SIZE][10]; // velkost pola definovana cez konstantu "define" bude znama uz pocas kompilacie. ak by sme to dali ako
//    for(int i = 0; i<SIZE; i++)
//    {
//        for(int j = 0; j<SIZE; j++)
//        {
//            pole[i][j] = rand() % ('z' - 'a' + 1) + 'a';
//        }
//    }
//
//    for(int i = 0; i<SIZE; i++)
//    {
//        printf("%s", pole[i]);
//        puts("");
//    }
//
//    qsort(pole, SIZE, sizeof(*pole), compareStrings);
//
//    puts("");
//    puts("");
//
//    for(int i = 0; i<SIZE; i++)
//    {
//        printf("%s", pole[i]);
//        puts("");
//    }
//}
