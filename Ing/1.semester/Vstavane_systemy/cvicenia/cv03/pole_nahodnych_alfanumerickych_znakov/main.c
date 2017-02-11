#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void randomArrayFill(char* pPole, int paSize)
{
    // aby to bol retazec, musi mat null terminator
    pPole[paSize - 1] = '\0';

    // inicializuj RNG
    srand(time(NULL));

    int i;
    int akyDruhZnaku;
    for(i=0; i < paSize - 1; i++)
    {
        akyDruhZnaku = rand() % 3;
        switch(akyDruhZnaku)
        {
        case 0:
            pPole[i] = rand() % 10 + 48; // od ASCII 48 po 57 (48 + 0..9)
            break;
        case 1:
            pPole[i] = rand() % 26 + 97; // od ASCII 97 po 122
            break;
        case 2:
            pPole[i] = rand() % 26 + 65; // od ASCII 65 po 90
            break;
        }
    }
}

int main(int argc, char** argv)
{
    int velkostPola = 10;
    char* pole = malloc(velkostPola * sizeof(char));
    randomArrayFill(pole, velkostPola);
    printf("Nahodny alfanumericky retazec: %s\n", pole);
    return 0;
}
