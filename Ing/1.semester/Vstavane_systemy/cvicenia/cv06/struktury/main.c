#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define STRING_SIZE 30
#define ZOZNAM_SIZE 20

// nemozme prehodit poradie struktur
// pokial tam to "typedef" struct "<nazovStruktury>" nedam, nemozem struct pouzit ako typ

typedef struct datum {
    unsigned char den;
    unsigned char mesiac;
    unsigned short rok;
} Datum;

typedef struct autor {
    char meno[STRING_SIZE];
    char priezvisko[STRING_SIZE];
    Datum datNar;
} Autor;

typedef struct kniha {
    Autor *autor;   // davame smernik na autora v poli "zoznamAutorov"
    char nazov[50];
    unsigned short rokVydania;
} Kniha;

typedef struct evidencia {
    Kniha zoznamKnih[ZOZNAM_SIZE];
    int pocetKnih;
    Autor zoznamAutorov[ZOZNAM_SIZE];
    int pocetAutorov;
} Evidencia;

_Bool suDatumyRovnake(Datum dat1, Datum dat2)
{
    return dat1.den == dat2.den && dat1.mesiac == dat2.mesiac && dat1.rok == dat2.rok;
}

// strncmp - rovnaka ako strcmp, len necaka na null terminator ale porovnava urceny pocet znakov
// const Autor* const autor1 by znamenalo autor 1 je konstantny smernik na konstantneho autora tj. nemozem spravit autor1 = &autor2
_Bool suAutoriRovnaki(const Autor* autor1, const Autor* autor2)
{
    return strncmp((*autor1).meno, (*autor2).meno, STRING_SIZE) == 0 &&
        strncmp(autor1->priezvisko, autor2->priezvisko, STRING_SIZE) == 0 &&
        suDatumyRovnake(autor1->datNar, autor2->datNar);  // datumy narodenia autorov sa rovnaju
}

//pridajAutora(Autor)
// metoda musi vzdy vratit adresu autora
_Bool pridajAutora(Evidencia* evid, const Autor* autor, Autor **novaAdrAutora)
{
    if(evid->pocetAutorov >= ZOZNAM_SIZE) return false;

    int i;
    for(i = 0; i < evid->pocetAutorov; i++)
    {
        if(suAutoriRovnaki(&(evid->zoznamAutorov[i]), autor))
        {
            *novaAdrAutora = &(evid->zoznamAutorov[i]);
            return true;    // ak sa mi ho tam nepodarilo pridat LEBO UZ TAM JE, tak vratim true, LEBO UZ TAM JE :)
        }
    }

    evid->zoznamAutorov[evid->pocetAutorov++] = *autor;     // nerobim "= autor" ale "= *autor", lebo priradzujem cely objekt, nie len jeho adresu
    *novaAdrAutora = &(evid->zoznamAutorov[evid->pocetAutorov - 1]);  // ak mame viacero knih s rovnakym autorom, budeme ukazovat na TOHO autora v poli zoznamAutorov, namiesto toho, aby mala kazda kniha svojho autora aj ked su rovnaki
    return true;
}

_Bool suKnihyRovnake(const Kniha* kniha1, const Kniha* kniha2)
{
    return suAutoriRovnaki(kniha1->autor, kniha2->autor) &&   // metode suAutoriRovnaki davame adresy (&) objektov, lebo ako parametre ma smerniky na objekty
            strncmp((*kniha1).nazov, (*kniha2).nazov, STRING_SIZE) &&
            kniha1->rokVydania == kniha2->rokVydania;
//    strncmp((*kniha1).meno, (*kniha2).meno, STRING_SIZE) == 0 &&
//        strncmp(kniha1->priezvisko, kniha2->priezvisko, STRING_SIZE) == 0 &&
//        suDatumyRovnake(kniha1->datNar, kniha2->datNar);  // datumy narodenia autorov sa rovnaju
}

_Bool pridajKnihu(Evidencia *evid, Kniha *kniha)
{
    if(evid->pocetKnih >= ZOZNAM_SIZE) return false;

    int i;
    for(i = 0; i < evid->pocetKnih; i++)
    {
        if(suKnihyRovnake(&(evid->zoznamKnih[i]), kniha))
        {
            return false;
        }
    }

    Autor *novaAdrAutora;
    if(pridajAutora(evid, kniha->autor, &novaAdrAutora) == true)    // autor je struktura, nie smernik na strukturu
    {
        evid->zoznamKnih[evid->pocetKnih++] = *kniha;
        evid->zoznamKnih[evid->pocetKnih - 1].autor = novaAdrAutora;
        return true;
    }
    return false;
}

void vypisKnihy(const Evidencia *evid)
{
    int i;
    for(i = 0; i < evid->pocetKnih - 1; i++)
    {
        const Kniha* kniha = &(evid->zoznamKnih[i]); // vyhnem sa kopirovaniu struktur v pamati pouzitim smernikov
        // vytvorit metody na vypis autora a knihy
        printf("%s\t%s\t%s\t%d\n", kniha->nazov, kniha->autor->priezvisko, kniha->autor->meno, kniha->rokVydania);
    }
}

void importFromTxt(Evidencia *evid, FILE *f)
{
    char buf[300];
    //rozparsovat a ulozit do evidencie
    while(!feof(f))
    {
        Autor autor;
        Kniha kniha;
        fgets(buf, 299, f); //nacitame jeden riadok zo suboru do buffera

        char* pos = strchr(buf, ';');   // metoda najde v retazci adresu hladaneho znaku - vzdy najde tu prvu

        if(pos == NULL) break;  // ak sme na konci suboru, ukoncim cyklus, lebo keby som pokracoval v praci s NULL charom. Davat pozor, ci v subore mame na konci jeden novy prazdny riadok, lebo feof zblbne. Keby tam ten prazdny riadok nebol, feof funguje normalne

        strncpy(kniha.nazov, buf, pos-buf); //mam adresu najdeneho znaku a mam adresu buffera; metoda strncpy neprida null terminator na koniec retazca
        kniha.nazov[pos-buf] = '\0';  // dame pre istotu null terminator
        kniha.rokVydania = atoi(pos + 1);   // atoi skonci na prvom znaku, ktory nie je cislica

        char* pos2 = strchr(pos + 1, ';');  //preto + 1, aby to zobralo az znak PO bodkociarke
        pos = strchr(pos2 + 1, ';');
        strncpy(autor.priezvisko, pos2 + 1, pos - pos2 - 1);
        autor.priezvisko[pos - pos2 - 1] = '\0';

        pos2 = strchr(pos + 1, ';');
        strncpy(autor.meno, pos + 1, pos2 - pos - 1);
        autor.meno[pos2 - pos - 1] = '\0';

        sscanf(pos2 + 1, "%d/%d/%d", &(autor.datNar.rok), &(autor.datNar.mesiac), &(autor.datNar.den));    // nacitavanie z retazca

//        printf("tu\n");
//        fflush(stdout);

        kniha.autor = &autor;
        pridajKnihu(evid, &kniha);
//        printf("tu\n");
    }
}

void init(Evidencia *evid)
{
    evid->pocetAutorov = 0;
    evid->pocetKnih = 0;
}

void saveToBinary(Evidencia *evid, FILE *data)
{
    fwrite(&(evid->pocetAutorov), sizeof(evid->pocetAutorov), 1, data);
    fwrite(evid->zoznamAutorov, sizeof(evid->zoznamAutorov), 1, data);
    fwrite(&(evid->pocetKnih), sizeof(evid->pocetKnih), 1, data);

    // toto treba urobit, aby sa aj autori nacitali z bin suboru po vynulovani evidencie
    int i;
    for(i = 0; i < evid->pocetKnih; i++)
    {
        Kniha *kn = &(evid->zoznamKnih[i]);
        fwrite(kn, sizeof(*kn), 1, data);
        fwrite(kn->autor, sizeof(*(kn->autor)), 1, data);
    }
}

void loadFromBinary(Evidencia *evid, FILE *data)
{
    fread(&(evid->pocetAutorov), sizeof(evid->pocetAutorov), 1, data);
    fread(evid->zoznamAutorov, sizeof(evid->zoznamAutorov), 1, data);

    int pom;
    fread(&pom, sizeof(evid->pocetKnih), 1, data);
//    fread(evid->zoznamKnih, sizeof(evid->zoznamKnih), 1, data);

    int i;
    for(i = 0; i < pom; i++)
    {
        Kniha kn;
        fread(&kn, sizeof(kn), 1, data);
        Autor at;
        fread(&at, sizeof(at), 1, data);
        kn.autor = &at;
        pridajKnihu(evid, &kn);
    }
}

int main(int argc, char** argv)
{
    Evidencia evid;
    init(&evid);    // pri komplexnejsich strukturach je vhodne urobit si nejaku inicializacnu strukturu

    FILE *f = fopen("knihy.txt", "r");
    if(f == NULL)
    {
//        fprintf(sdterr, "Subor sa nepodarilo otvorit.");    // vypis na standardny chybovy vystup; f pred nazvom znamena pracu so suborom
        perror("Subor sa nepodarilo otvorit.");     // vypise chybu na standardny chybovy vystup a nastavuje aj chybovy flag errno
        return 1;
    }
    importFromTxt(&evid, f);
    fclose(f);

//    vypisKnihy(&evid);

    // uloz knihy do binarneho suboru
    FILE *data;
    data = fopen("data.bin", "wb");
    saveToBinary(&evid, data);
    fclose(data);   // tam, kde som otvoril subor, by som ho mal aj zavriet

    memset(&evid, 0, sizeof(evid));

    Evidencia evid2;
    data = fopen("data.bin", "rb");
    loadFromBinary(&evid2, data);
    fclose(data);

    vypisKnihy(&evid2);

    return 0;
}
