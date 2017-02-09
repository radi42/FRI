#include "Sifrator.h"
#include "Heslo.h"
#include "koder.h"
#include "Vstup.h"
#include "Vystup.h"
#include "pomocnik.h"
#include <iostream>

using namespace std;

Sifrator::Sifrator(char cinnost, const char *heslo, const char *vstupnySubor, const char *vystupnySubor)
{
	aCinnost = cinnost;
	aHeslo = copyString(heslo);
	aVstupnySubor = copyString(vstupnySubor);
	aVystupnySubor = copyString(vystupnySubor);
}


Sifrator::~Sifrator()
{
	if (aHeslo)
		delete[] aHeslo;
	if (aVstupnySubor)
		delete[] aVstupnySubor;
	if (aVystupnySubor)
		delete[] aVystupnySubor;
}

void Sifrator::start(){
	if (aCinnost == 'h' || aCinnost == 'H'){
		cout << "sifrator, cinnost: s = sifruj, d = desifruj, h = pomoc \n" << endl;
		return;
	}

	Vstup vstup(aVstupnySubor);
	unsigned char *text = vstup.nacitaj();

	cout << "begin" << endl;	//dava na znamost ze zacal sifrovat

	if (text && *text){
		koder k;
		unsigned char *sifrtext;

		if (aCinnost == 's' || aCinnost == 'S'){
			sifrtext = k.koduj(aHeslo, text);
		}

		if (aCinnost == 's' || aCinnost == 'S'){
			sifrtext = k.dekoduj(aHeslo, text);
		}

		if (sifrtext && *sifrtext){
			Vystup vypis(aVystupnySubor);
			vypis.zapis(sifrtext);
			delete[] sifrtext;
		}
		delete[] text;
	}
}
