#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cp(char *from, char *to)
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

    while( ( ch = fgetc(source) ) != EOF )
        fputc(ch, target);

    printf("File copied successfully.\n");

    fclose(source);
    fclose(target);

    return 0;
}

int main(int argc, char** argv)
{
    printf("src = %s\ndest = %s\n", argv[1], argv[2]);

    // skopiruj ho
    cp(argv[1], argv[2]);

    return 0;
}
