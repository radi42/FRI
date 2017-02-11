#ifndef LINZOZ_H    // ak este nebola definovana tato symbolicka konstanta, tak ju zadefinuje, ale ak uz zadefinovana, nic sa neurobi -> PREVENCIA PROTI VIACNASOBNEMU INCLUDOVANIU HLAVICKOVEHO SUBORU
#define LINZOZ_H    // konstanta sa moze volat hociako

// Takto struktura nie je zapuzdrena - prvky mozeme menit lubovolne
//typedef struct prvok
//{
//    double data;
//    struct prvok *nas;
//} Prvok;
//
//typedef struct linZoz
//{
//    double *pole;
//    Prvok *zac;
//    Prvok *kon;
//    int pocet;
//} LinZoz;

// Takto struktura je zapuzdrena - prvky mozeme IBA cez funkcie, ktore struktura ponuka (nemozeme menit atributy)
// nemozeme ku atributom pristupovat cez bodku napr. "zoz.kon" nemozeme
// dopredne deklaracie
typedef struct prvok Prvok;
typedef struct linZoz LinZoz;

// vyhnut sa deklaraciam funkcii ako static, lebo pri viace
void init(LinZoz *zoz);
void dispose(LinZoz *zoz);
void add(LinZoz *zoz, double data);
void print(const LinZoz *zoz);


#endif
