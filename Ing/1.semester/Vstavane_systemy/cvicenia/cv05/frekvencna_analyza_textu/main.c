#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int frekvencnaAnalyza(char *paFileName)
{
    char ch;
    FILE *source;

    source = fopen(paFileName, "r");

    if( source == NULL )
    {
        printf("Nepodarilo sa otvorit subor\nPress any key to exit...\n");
        exit(EXIT_FAILURE);
    }

    // Zisti, kolko roznych znakov sa v subore nachadza, aby sme vedeli naalokovat pole uz prejdenych znakov
    while( ( ch = fgetc(source) ) != EOF )
    {
        // zober znak zo suboru

        // pozri sa, ci sa nachadza v zozname prejdenych znakov
            // ak ano, posun sa na dalsi znak v subore (neurobime nic -> continue)
            // inak inkrementuj pocitadlo odlisnych znakov
    }

    // vytvor pole uz prejdenych znakov

    // zresetuj kurzor na zaciatok suboru

    // Zisti, ake znaky sa v subore nachadzaju
    while( ( ch = fgetc(source) ) != EOF )
    {
        // zober znak zo suboru

        // pozri sa, ci sa nachadza v zozname prejdenych znakov
            // ak ano, posun sa na dalsi znak v subore (neurobime nic -> continue)
            // inak pridaj znak do pola prejdenych znakov
    }

    // Zisti pocetnosti znakov, ktore sa v subore nachadzaju
    int kolkokrat;
    while( ( ch = fgetc(source) ) != EOF )
    {
        // posun sa na zaciatok suboru
        // zresetuj pocitadlo

        // zober znak zo suboru

        // pozri sa, ci sa aktualny znak zhoduje so znakom v poli znakov suboru
            // ak ano, inkrementuj pocitadlo
            // inak chod odznova (continue)
    }


    printf("File copied successfully.\n");

    fclose(source);

    return 0;
}

int main(int argc, char** argv)
{
    printf("src = %s\ndest = %s\n", argv[1], argv[2]);

    // skopiruj ho
    frekvencnaAnalyza(argv[1]);

    return 0;
}
