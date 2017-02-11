#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

// da sa includnut, ale vsetky funkcie musia mat ine nazvy
//#include "/home/andrej/Desktop/LinZoz/linzoz.h"

#define INIT_SIZE 2

typedef struct dynZoz
{
    double *pole;   // dynamicky alokovane pole
    int pocet;      // kolko prvkov mame aktualne v poli
    int kapacita;   // kolko prvkov mozeme mat maximalne v poli
} DynZoz;

static void init(DynZoz *zoz)
{
    zoz->pocet = 0;
    zoz->kapacita = INIT_SIZE;
    zoz->pole = calloc(zoz->kapacita, sizeof(double));  // v C sa static void smernik z calloc nemusi pretypovavat, v C++ sa ale musi
}

static void dispose(DynZoz *zoz)
{
    free(zoz->pole);
    zoz->pole = NULL;
    zoz->pocet = 0;
    zoz->kapacita = 0;
}

//static void print(DynZoz * const zoz)  // to iste ako nasledujuce: citat odzadu: zoz je konstantny smernik na DynZoz
static void print(const DynZoz *zoz)  // citat odzadu: zoz je smernik na DynZoz
{
    // smernikovou aritmetikou
    for(double *i = zoz->pole; i < zoz->pole + zoz->pocet; i++)
    {
        printf("%f", *i);
    }

//    for(int i = 0; i < zoz->pocet; i++)
//    {
//        printf("%f", zoz->pole[i]);
//    }
    printf("/n");   // keby som to tu nedal, nic by sa nevypisalo a program by stale padal
}

// static - lebo ine subory nepotrebuju tuto metodu
static void ensureCapacity(DynZoz *zoz)
{
    if(zoz->pocet >= zoz->kapacita)
    {
        zoz->kapacita = zoz->kapacita == 0 ? INIT_SIZE : 2 * zoz->kapacita;
        zoz->pole = realloc(zoz->pole, zoz->kapacita * sizeof(double));
        memset(zoz->pole + zoz->pocet, 0, zoz->kapacita - zoz->pocet);       // vynulujeme novu naalokovanu pamat
    }
}

static void add(DynZoz *zoz, double data)
{
    ensureCapacity(zoz);
    zoz->pole[zoz->pocet++] = data;
}

_Bool tryInsert(DynZoz *zoz, double data, int pos)
{
    // nemozeme vkladat hocikam, iba tam, kde su ostatne prvky => POLE MUSI BYT SUVISLE
    if(pos < 0 || pos >= zoz->pocet) return false;

    ensureCapacity(zoz);
    memmove(zoz->pole + pos + 1, zoz + pos, zoz->pocet - pos);    // presunieme prvky od pozicie "pos" po koniec pola o jedna, aby sme urobili vkladanemu prvku miesto
    zoz->pole[pos] = data;
    zoz->pocet++;
    return true;
}

_Bool trySet(DynZoz *zoz, double data, int pos)
{
    // nemozeme menit hociaky prvok, iba ten, ktory je uz nastaveny (priradeny) => POLE MUSI BYT SUVISLE
    if(pos < 0 || pos >= zoz->pocet) return false;

    zoz->pole[pos] = data;
//    memcpy(zoz->pole + pos, &data, 1);
    return true;
}

_Bool tryGet(DynZoz *zoz, int pos, double *data)
{
    if(pos < 0 || pos >= zoz->pocet) return false;

    *data = zoz->pole[pos];
    return true;
}

//_Bool tryRemove()         // opak tryInsert

_Bool tryCopy(const DynZoz *zoz, DynZoz *dest)           // skopiruj toto pole do ineho
{
    if (zoz == dest) return true;

    dest->kapacita = zoz->kapacita;
    dest->pocet = zoz->pocet;
    dest->pole = realloc(dest->pole, dest->kapacita);
    memcpy(dest, zoz, zoz->pocet);
    return true;
}

//static void readFromTxt()
//static void writeToTxt()

int main()
{
    return 0;
}
