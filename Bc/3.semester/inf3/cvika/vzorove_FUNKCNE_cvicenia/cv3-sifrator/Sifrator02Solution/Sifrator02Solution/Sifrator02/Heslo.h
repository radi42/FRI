#pragma once
#include <cstdlib>
#include <cstring>
#include <iostream>

using namespace std;

const int DLZKA_HESLA = 8;

class Heslo
{
private:
	union {
		char aHeslo[DLZKA_HESLA];
		unsigned int aNasada1;
		unsigned int aNasada2;
	};

	void dajHeslo()
	{
		char pheslo[200];
		cout << "Zadaj heslo (max. 8 znakov): ";
		cin >> pheslo;
		if (*pheslo)
		{
			int dlzka = strlen(pheslo);
			dlzka = (dlzka > DLZKA_HESLA) ? DLZKA_HESLA : dlzka;
			memmove(aHeslo, pheslo, dlzka);
		}
	}

public:
	Heslo(const char *heslo)
	{
		memset(aHeslo, 0, DLZKA_HESLA*sizeof(char));
		if (heslo != NULL)
		{
			int dlzka = strlen(heslo);
			dlzka = (dlzka > DLZKA_HESLA) ? DLZKA_HESLA : dlzka;
			memmove(aHeslo, heslo, dlzka);
		}
	}

	unsigned int dajNasadu()
	{
		unsigned int nasada;
		if (!*aHeslo)
			dajHeslo();

		nasada = aNasada1 + aNasada2;
		return nasada;
	}
};

