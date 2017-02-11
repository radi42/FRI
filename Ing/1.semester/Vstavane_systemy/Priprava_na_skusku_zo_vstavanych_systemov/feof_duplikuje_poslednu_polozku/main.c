#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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

void nacitajSuborDoStrukturyZle(FILE *subor, char pole[][ARR_SIZE])
{
    // inicializuj buffer
    char slovo[ARR_SIZE];
    memset(slovo, '\0', sizeof(ARR_SIZE));

    // nacitaj subor do struktury
    int i = 0;
    while(!feof(subor))
    {
        fgets(slovo, sizeof(slovo), subor);
        strcpy(pole[i], slovo);
        i++;
    }
}

void nacitajSuborDoStrukturyDobre(FILE *subor, char pole[][ARR_SIZE])
{
    // inicializuj buffer
    char slovo[ARR_SIZE];
    memset(slovo, '\0', sizeof(ARR_SIZE));

    // nacitaj subor do struktury
    int i = 0;
    while(fgets(slovo, sizeof(slovo), subor))
    {
        strcpy(pole[i], slovo);
        i++;
    }
}

int main(int argc, char** argv)
{
    puts("************************************");
    puts("Zly sposob nacitavania zo suboru\n");
    char pole_1[ARR_SIZE][ARR_SIZE];
    char pole_2[ARR_SIZE][ARR_SIZE];

    // inicializuj polia
    initPole(pole_1);
    initPole(pole_2);

    // otvor subor
    FILE *subor_1 = fopen("zadanie_bez_noveho_riadku_za_poslednym_slovom.txt", "r");
    nacitajSuborDoStrukturyZle(subor_1, pole_1);
    fclose(subor_1);

    FILE *subor_2 = fopen("zadanie_s_novym_riadkom_za_poslednym_slovom.txt", "r");
    nacitajSuborDoStrukturyZle(subor_2, pole_2);
    fclose(subor_2);

    // kontrolny vypis pola
    vypisPole(pole_1);

    putc('\n', stdout);
    putc('\n', stdout);

    vypisPole(pole_2);


    // a znova, ale inak
    puts("\n************************************");
    puts("Spravny sposob nacitavania zo suboru\n");
    // inicializuj polia
    initPole(pole_1);
    initPole(pole_2);

    // otvor subor
    subor_1 = fopen("zadanie_bez_noveho_riadku_za_poslednym_slovom.txt", "r");
    nacitajSuborDoStrukturyDobre(subor_1, pole_1);
    fclose(subor_1);

    subor_2 = fopen("zadanie_s_novym_riadkom_za_poslednym_slovom.txt", "r");
    nacitajSuborDoStrukturyDobre(subor_2, pole_2);
    fclose(subor_2);

    vypisPole(pole_1);

    putc('\n', stdout);
    putc('\n', stdout);

    vypisPole(pole_2);

    getchar();

    return 0;
}
