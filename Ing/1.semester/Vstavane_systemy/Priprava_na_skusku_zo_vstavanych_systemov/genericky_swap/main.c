#include <stdlib.h>
#include <stdio.h>
#include <string.h>

void genericSwap(void *a, void *b, size_t size)
{
//    char tmp[size];
    char *tmp = malloc(size);
    memcpy(tmp, a, size);
    memcpy(a, b, size);
    memcpy(b, tmp, size);
    free(tmp);
}

int main(int argc, char** argv)
{
    int iA, iB;
//    printf("Zadaj dve cele cisla:\n");
//    scanf("%d%d", &iA, &iB);
    iA = 3;
    iB = 6;
    printf("Pred vymenou:\t a = %d\tb = %d\n", iA, iB);
    genericSwap(&iA, &iB, sizeof(iA));
    printf("Po vymene:\t a = %d\tb = %d\n", iA, iB);
    return 0;
}
