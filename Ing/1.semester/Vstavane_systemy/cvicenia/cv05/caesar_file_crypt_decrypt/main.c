#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int caesar(const char *from, const char *to, const char *paShift)
{
    char ch;
    FILE *source, *target;

    source = fopen(from, "r");

    if( source == NULL )
    {
        printf("Press any key to exit...\n");
        exit(EXIT_FAILURE);
    }

    target = fopen(to, "w");

    if( target == NULL )
    {
        fclose(source);
        printf("Press any key to exit...\n");
        exit(EXIT_FAILURE);
    }

    // podla toho, aky bude treti argument, sa vstupny subor zasifruje alebo desifruje do vystupneho suboru
    int shift = atoi(paShift);
    while( ( ch = fgetc(source) ) != EOF )
    {
        if(ch != ' ' &&
            (ch >= 'a' && ch <= 'z') ||
            (ch >= 'A' && ch <= 'Z') ||
            (ch >= '0' && ch <= '9'))
        {
            if(ch >= 'a' && ch <= 'z') fputc((ch - 'a' + shift) % 26 + 'a', target);
            if(ch >= 'A' && ch <= 'Z') fputc((ch - 'A' + shift) % 26 + 'A', target);
            if(ch >= '0' && ch <= '9') fputc((ch - '0' + shift) % 10 + '0', target);
        }
        else
        {
            fputc(ch, target);
        }
    }

    printf("File copied successfully.\n");

    fclose(source);
    fclose(target);

    return 0;
}

int main(int argc, char** argv)
{
    printf("Usage:\nEncryption: <input_file> <output_file> shift\nDecryption: <input_file> <output_file> -shift (negative shift)");
    printf("src = %s\ndest = %s\nshift = %s\n", argv[1], argv[2], argv[3]);

    // zasifruj / desifruj ho
    caesar(argv[1], argv[2], argv[3]);

    return 0;
}

