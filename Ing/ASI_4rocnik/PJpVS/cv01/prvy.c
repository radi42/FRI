#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    char meno[200];
    int rok;
    unsigned long long dlheCislo;

    printf("Zadaj meno: \n");
    scanf("%s",meno);
    printf("Zadaj rok narodenia: \n");
    scanf("%d",&rok);
    printf("Ahoj, %s, mas %d rokov.\n",meno,2015-rok);
    if (2015-rok > 17)
	printf("Mozes legalne chlastat!\n");
    else
	printf("Chod si tahat kacera.\n");
    return 0;
}