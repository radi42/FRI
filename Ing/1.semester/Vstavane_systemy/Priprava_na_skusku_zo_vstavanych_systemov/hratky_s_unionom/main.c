#include <stdlib.h>
#include <stdio.h>

union slova
{
    struct
    {
        unsigned char bajt_1;
        unsigned char bajt_2;
        unsigned char bajt_3;
        unsigned char bajt_4;
    } bajty;
    unsigned int dword;
} prem;

int main()
{
    prem.dword = 0x12345678;
    printf("%x\n", prem.bajty.bajt_1);
    return 0;
}
