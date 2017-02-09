#include <iostream>
#include "Sifrator.h"
#include "Heslo.h"
#include "koder.h"
#include "Vstup.h"
#include "Vystup.h"
#include "pomocnik.h"

using namespace std;

Sifrator::Sifrator(char cinnost, const char *heslo,
	const char *vstupnysubor,
	const char *vystupnysubor)
{
	aCinnost = cinnost;
	aHeslo = copyString(heslo);
	aVstupnySubor = copyString(vstupnysubor);
	aVystupnySubor = copyString(vystupnysubor);
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

void Sifrator::start()
{
	if (aCinnost == 'h' || aCinnost == 'H')
	{
		cout << "sifrator, cinnost: s = sifruj, d = desifruj\n"
			"h = help\n" << endl;
		return;
	}

	Vstup vstup(aVstupnySubor);
	unsigned char *text = vstup.nacitaj();

	cout << "begin" << endl;

	if (text && *text)
	{
		koder k;
		unsigned char *sifrtext;
		if (aCinnost == 's' || aCinnost == 'S')
			sifrtext = k.koduj(aHeslo, text);
		if (aCinnost == 'd' || aCinnost == 'D')
			sifrtext = k.dekoduj(aHeslo, text);

		if (sifrtext && *sifrtext)
		{
			Vystup vypis(aVystupnySubor);
			vypis.zapis(sifrtext);
			delete[] sifrtext;
		}
		delete[] text;
	}
}