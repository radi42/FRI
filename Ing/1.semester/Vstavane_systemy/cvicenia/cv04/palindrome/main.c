#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isPalindrome(char *paSrc)
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
//    printf("Pokial: %d", j);
    for(i = 0; i < j; i++)
    {
//        printf("\n%c == %c\n", paSrc[i], paSrc[j]);
        if(paSrc[i] != paSrc[j]) return 1;
        j--;
    }
    return 0;
}

int main(int argc, char** argv)
{
    printf("Retazec\tPalindrom?\n");
    char *palindrome1 = malloc(101);
    strcpy(palindrome1, "racecar");
    printf("%s\t", palindrome1);
    isPalindrome(palindrome1) == 0 ? printf("Ano\n") : printf("Nie\n");

    char *palindrome2 = malloc(101);
    strcpy(palindrome2, "abba");
    printf("%s\t", palindrome2);
    isPalindrome(palindrome2) == 0 ? printf("Ano\n") : printf("Nie\n");

    char *palindrome3 = malloc(101);
    strcpy(palindrome3, "motorka");
    printf("%s\t", palindrome3);
    isPalindrome(palindrome3) == 0 ? printf("Ano\n") : printf("Nie\n");

    free(palindrome1);
    free(palindrome2);
    free(palindrome3);
    return 0;
}
