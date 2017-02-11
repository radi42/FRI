#include <stdio.h>
#include <stdlib.h>

#define MYFILE "junk1.txt"

// CHYBNY KOD
//*********************************************************//
//*********************************************************//
int main(void)
{
    FILE *fp;
    char buf[BUFSIZ] = "Garbage";
    int i;

    if ((fp = fopen(MYFILE, "r")) == NULL)
    {
        perror (MYFILE);
        return (EXIT_FAILURE);
    }

    i = 0;

    // VZDY TREBA NECHAT ZAKOMENTOVANY JEDEN Z TYCHTO DVOCH CYKLOV

    // TOTO JE ZLY CLYKLUS, KTORY ZOPAKUJE POSLEDNY PRVOK (PRED KONCOM SUBORU SA ESTE RAZ OTOCI)
    while (!feof(fp))
    {
        fgets(buf, sizeof(buf), fp);
        printf ("Line %4d: %s", i, buf);
        i++;
    }

    // TOTO JE DOBRY CYKLUS, KTORY SA NEVYKONA, AK SME NA KONCI SUBORU
    // trik je v tom, ze sledujeme navratovu hodnotu funkcie 'fgets' a nie 'feof'
    // ZAKOMENTUJ PREDCHADZAJUCI A ODKOMENTUJ TENTO CYKLUS
//    while (fgets(buf, sizeof(buf), fp) != NULL)
//    {
//        printf ("Line %4d: %s", i, buf);
//        i++;
//    }


    fclose(fp);

    return(0);
}
