#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* reverse(char *paSrc)
{
    int i = 0;
    int dlzkaRetazca = 0;
    while(1)
    {
        if(paSrc[i] == '\0') break;
        dlzkaRetazca++;
        i++;
    }

    int j = dlzkaRetazca - 1;
    for(i = 0; i < j; i++)
    {
        if(paSrc[i] >= 'a' && paSrc[i] <= 'z') paSrc[i] = paSrc[i] - 'a' + 'A';
    }
    return paSrc;
}

int main(int argc, char** argv)
{
    char *ret1 = malloc(101);
    strcpy(ret1, "VeLkE + mALe PiSMEna!!");
    printf("%s\n", ret1);
    reverse(ret1);
    printf("%s\n", ret1);

    free(ret1);
    return 0;
}

