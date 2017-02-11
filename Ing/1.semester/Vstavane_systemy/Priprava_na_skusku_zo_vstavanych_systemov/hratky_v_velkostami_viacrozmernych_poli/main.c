#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
    int pole3d[2][3][4];

    printf("sizeof(pole3d) =\t%lu\n", sizeof(pole3d));
    printf("sizeof(pole3d[0])=\t%lu\n", sizeof(pole3d[0]));
    printf("sizeof(*pole3d)=\t%lu\n", sizeof(*pole3d));
    printf("sizeof(pole3d[0][0])=\t%lu\n", sizeof(pole3d[0][0]));
    return 0;
}
