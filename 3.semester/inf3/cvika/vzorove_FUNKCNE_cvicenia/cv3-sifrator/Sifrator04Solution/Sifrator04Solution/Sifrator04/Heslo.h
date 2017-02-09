#pragma once
#include <cstring>

const int DLZKA_HESLA = 8;

class Heslo
{
private:
	union {
		char aHeslo[DLZKA_HESLA];
		unsigned int aNasada1;
		unsigned int aNasada2;
	};
public:
	Heslo(const char *heslo)
	{
		if (heslo != NULL && *heslo/*heslo[0]!='\0'*/)
		{
			memset(aHeslo, 0, DLZKA_HESLA);
			int dlzka = strlen(heslo);
			dlzka = dlzka > DLZKA_HESLA ? DLZKA_HESLA : dlzka;
			memmove(aHeslo, heslo, dlzka);
		}
	}

	unsigned int dajNasadu()
	{
		return aNasada1 + aNasada2;
	}
};

