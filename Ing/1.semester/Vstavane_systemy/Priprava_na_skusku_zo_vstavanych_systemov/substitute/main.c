#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define POC_DLZKA_SLOVA 40

// funkcia nahradi v retazci 'src' vsetky podretazce 'pattern' retazcom 'sub'
// a vysledny retazec ulozi do retazca 'dest'
void substitute(char *src, char *dest, char *pattern, char *sub)
{
    char *src_addr = src;
    char *dest_addr = dest;
    char *pattern_addr = pattern;
    int dlzkaPatternu = strnlen(pattern_addr, POC_DLZKA_SLOVA);
    int dlzkaZdroja = strnlen(src_addr, POC_DLZKA_SLOVA);

    puts(src_addr);         // Vypis zdrojovy retazec
    puts(pattern_addr);     // Vypis vzorovy retazec
    printf("Dlzka vzoroveho retazca:\t%d\n", dlzkaPatternu);

    char *slovo = malloc(dlzkaPatternu);
    for(src_addr; src_addr < src + dlzkaZdroja; src_addr++)
    {
        // nechod az za koniec zdrojoveho retazca
        if(src_addr + dlzkaPatternu > src + dlzkaZdroja) break;

        memcpy(slovo, src_addr, dlzkaPatternu);
        if(memcmp(slovo, pattern_addr, dlzkaPatternu - 1) == 0)
        {
            printf("%s\t<-Toto slovo treba nahradit\n", slovo);
        }
        else
        {
            printf("%s\n", slovo);
        }
    }
}

int main(int argc, char **argv)
{
    char *retazec = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(retazec, '\0', POC_DLZKA_SLOVA);
    strncpy(retazec, "na nana bla ble nana ble nana", POC_DLZKA_SLOVA);
//    printf("Dlzka zdrojoveho retazca:\t%d\n", strnlen(retazec, POC_DLZKA_SLOVA));
    retazec = realloc(retazec, strnlen(retazec, POC_DLZKA_SLOVA) + 1);

//    puts(retazec);

    char *vzor = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(vzor, '\0', POC_DLZKA_SLOVA);
    strncpy(vzor, "nana", POC_DLZKA_SLOVA);
    vzor = realloc(vzor, strnlen(vzor, POC_DLZKA_SLOVA) + 1);

    char *nahradzovaci_ret = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(nahradzovaci_ret, '\0', POC_DLZKA_SLOVA);
//    strncpy(nahradzovaci_ret, "wup", POC_DLZKA_SLOVA);
    strncpy(nahradzovaci_ret, "hejrup", POC_DLZKA_SLOVA);
    nahradzovaci_ret = realloc(nahradzovaci_ret, strnlen(nahradzovaci_ret, POC_DLZKA_SLOVA) + 1);

    char *vysl_retazec = calloc(POC_DLZKA_SLOVA, sizeof(char));
    memset(vysl_retazec, '\0', POC_DLZKA_SLOVA);

    substitute(retazec, vysl_retazec, vzor, nahradzovaci_ret);
//    puts("");

//    puts(vysl_retazec);

    free(vzor);
    free(vysl_retazec);
    free(retazec);
    return 0;
}
