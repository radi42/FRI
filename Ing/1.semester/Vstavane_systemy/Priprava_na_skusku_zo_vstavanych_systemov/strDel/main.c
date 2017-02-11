#include <string.h>
#include <stdio.h>
#include <stdlib.h>


#define POC_DLZKA_SLOVA 20

// funkcia vymaze pocet znakov 'count' v retazci 'src' od pozicie 'pos'
void strDel(char *src, char *dest, int pos, int count)
{
    printf("Index znaku, od ktoreho vymazavame:\t%d\n", pos);
    printf("Kolko znakov mame vymazat:\t\t%d\n", count);

    char *src_addr = src;
    char *dest_addr = dest;
    for(src_addr; src_addr < src + POC_DLZKA_SLOVA; src_addr++)
    {
        if(*src_addr == '\0') break;

//        putc(*src_addr, stdout);
//
//        if(src_addr == src + pos)
//        {
//            printf("\tOdtialto zacinam vymazavat");
//        }
//
//        if(src_addr == src + count)
//        {
//            printf("\tTu koncim vymazavanie");
//        }

        if(src_addr < src + pos || src_addr > src + count)
        {
            *dest_addr = *src_addr;
//            putc(*src_addr, stdout);
            dest_addr++;
        }

//        putc('\n', stdout);
    }
}

int main(int argc, char **argv)
{
    char *retazec = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(retazec, '\0', POC_DLZKA_SLOVA);
    strncpy(retazec, "totohento islo het", POC_DLZKA_SLOVA);

    // Vypis nejake info o zdrojovom retazci
    puts(retazec);
    printf("Dlzka retazca:\t\t\t\t%d\n", strnlen(retazec, POC_DLZKA_SLOVA));

    char *upr_ret = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(upr_ret, '\0', POC_DLZKA_SLOVA);

    strDel(retazec, upr_ret, 4, 8);
    puts("");

    puts(upr_ret);
    printf("Dlzka upraveneho retazca: %d\n", strnlen(upr_ret, POC_DLZKA_SLOVA));
    puts("");

    free(upr_ret);
    free(retazec);
    return 0;
}
