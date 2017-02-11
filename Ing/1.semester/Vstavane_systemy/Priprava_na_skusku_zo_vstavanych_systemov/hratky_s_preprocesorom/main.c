#include <stdio.h>

// Definovanie konstant
#define SIZE 1000 /* velkost pola */
#define TWO_PI (2 * 3.1415927)

// Makro ako jednoducha funkcia (funkcia definovana v preprocesore)
// keby sme potrebovali rozdelit makro do viacerych riadkov, pouzijeme spatne lomitko '\'
#define MAX(a, b) (((a)>(b))?\
(a):(b))   // dolezite, aby boli jednotlive premenne aj vyrazy v zatvorkach

#define SQR(x) ((x) * (x))

#define FILE_NAME "file.c"

int main()
{

// Riadenie prekladu programu
#define DEBUG
#ifdef DEBUG
    printf("debug message\n");
#endif // DEBUG

    printf("Velkost:\t%d\n", SIZE);
    printf("2 * pi:\t\t%f\n", TWO_PI);
    printf("Maximum:\t%d\n", MAX(1, 8));
    printf("2^2:\t\t%d\n", SQR(2));

#line 100 FILE_NAME
    printf("Nachadzam sa na riadku %d v subore '%s'.\n", __LINE__, __FILE__);

    return 0;
}
