#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <stdbool.h>

#define ARR_SIZE 10

void initPole(char pole[][ARR_SIZE])
{
    for(int i = 0; i < ARR_SIZE; i++)
    {
        for(int j = 0; j < ARR_SIZE; j++)
        {
            pole[i][j] = '\0';
        }
    }
}

void vypisPole(char pole[][ARR_SIZE])
{
    for(int j = 0; j < ARR_SIZE; j++)
    {
        printf("%s", pole[j]);
    }
}

void nacitajSuborDoStruktury(FILE *subor, char pole[][ARR_SIZE])
{
    // inicializuj buffer
    char slovo[ARR_SIZE];
    memset(slovo, '\0', sizeof(ARR_SIZE));

    // nacitaj subor do struktury
    int i = 0;
//    while(!feof(subor))
//    {
//        fgets(slovo, sizeof(slovo), subor);
//        strcpy(pole[i], slovo);
//        i++;
//    }

    while(fgets(slovo, sizeof(slovo), subor))
    {
        strcpy(pole[i], slovo);
        i++;
    }
}

void najblizsieNajmensieZacPismenoSlova(char pole[][ARR_SIZE], int odkial, int *ret_index_slova)
{
    char aktualny = CHAR_MAX;
    for(int i = odkial; i < ARR_SIZE; i++)
    {
        if(pole[i][0] != '\0')
        {
            if(pole[i][0] < aktualny)
            {
                *ret_index_slova = i;
                aktualny = pole[i][0];
            }
        }
    }
}

// Vlozi slovo 'slovo' do pola 'pole'
_Bool vloz(char slovo[ARR_SIZE], char pole[][ARR_SIZE])
{
    int pocetSlov = 0;
    // skontroluj, ci sa tam slovo vojde
    for(int i = 0; i < ARR_SIZE; i++)
    {
        if(pole[i][0] != '\0') pocetSlov++;
    }

    if(pocetSlov >= ARR_SIZE)
    {
        perror("Nedostatok miesta");
        return false;
    }

    // zisti prvy znak
    char prvyZnak = slovo[0];
    // prejdi cele pole, ci sa tam to zaciatocne pismeno slova uz nenachadza
        //ak sa nachadza, vloz ho na koniec
        //ak sa nenachadza, vloz ho na abecedne najblizsie miesto
    for(int i = 0; i < ARR_SIZE; i++)
    {
        if(prvyZnak == pole[i][0])
        {

        }
    }
    return true;
}

int main(int argc, char** argv)
{
    char pole[ARR_SIZE][ARR_SIZE];

    // inicializuj pole
    initPole(pole);

    // otvor subor
    FILE *subor = fopen("zadanie.txt", "r");

    nacitajSuborDoStruktury(subor, pole);

    fclose(subor);

    // kontrolny vypis pola
    vypisPole(pole);

    // padding
    putc('\n', stdout);

    // uprav poradie prvkov v strukture podla zadania
    int pocetSlov = 0;
    // vypis zaciatocne pismena slov a pocet slov
    puts("Zaciatocne pismena slov:");
    for(int i = 0; i < ARR_SIZE; i++)
    {
        if(pole[i][0] != '\0')
        {
            putc(pole[i][0], stdout);
            pocetSlov++;
        }
    }

    putc('\n', stdout);
    putc('\n', stdout);

    printf("Pocet slov: %d", pocetSlov);

    putc('\n', stdout);
    putc('\n', stdout);

    // najdi index slova s takym zaciatocnym pismenom, ktore ma najmensi ascii kod
    int indexNajmensiehoAsciiZnaku = 0;
    char presuvaneSlovo[ARR_SIZE];

    for(int i = 0; i < pocetSlov; i++)
    {
        najblizsieNajmensieZacPismenoSlova(pole, i, &indexNajmensiehoAsciiZnaku);
        printf("%d, ", indexNajmensiehoAsciiZnaku);

        if(indexNajmensiehoAsciiZnaku <= i) continue;
        else
        {
            // inicializuj premennu
            for(int j = 0; j < ARR_SIZE; j++) presuvaneSlovo[j] = '\0';
            // skopiruj do premennej najdene slovo
            strcpy(presuvaneSlovo, pole[indexNajmensiehoAsciiZnaku]);

            _Bool jeTamNewLine = false;
            for(int j = 0; j < ARR_SIZE; j++)
            {
                if(presuvaneSlovo[j] == '\n') jeTamNewLine = true;
            }

            if(!jeTamNewLine)
            {
                strcat(presuvaneSlovo, "\n");
            }

            // uprac prvky zospodu nahor
            for(int j = indexNajmensiehoAsciiZnaku - 1; j >= i; j--)
            {
                strcpy(pole[j+1], pole[j]);
            }

            memset(pole[i], '\0', ARR_SIZE);
            strcpy(pole[i], presuvaneSlovo);
        }
    }

    putc('\n', stdout);
    putc('\n', stdout);

    vypisPole(pole);

    // vypis vysledok
    return 0;
}
