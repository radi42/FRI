#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mv(const char *from, const char *to)
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

    printf("Source file copied successfully.\n");

    fclose(source);
    fclose(target);

    int ret = remove(from);
    if(ret == 0)
    {
        printf("Source file deleted successfully");
    }
    else
    {
        printf("Error: unable to delete the source file");
    }

    return 0;
}

int main(int argc, char** argv)
{
    printf("src = %s\ndest = %s\n", argv[1], argv[2]);

    // presun ho
    mv(argv[1], argv[2]);

    return 0;
}

