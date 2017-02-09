#pragma once
#include <cstring>

const int DLZKA_HESLA = 8;

class Heslo
{
private:
	union
	{
		char aHeslo[DLZKA_HESLA];
		unsigned int aSeed1;
		unsigned int aSeed2;
	};
	
public:
	Heslo(const char *heslo)
	{
		memset(aHeslo, 0, sizeof(aHeslo));
		if (heslo != NULL)
		{
			int dlzka = strlen(heslo);
			dlzka = dlzka > DLZKA_HESLA ? DLZKA_HESLA : dlzka;
			memmove(aHeslo, heslo, dlzka);
		}
	}

	~Heslo()
	{
	}

	unsigned int dajNasadu()
	{
		unsigned int nasada = aSeed1 + aSeed2; 
		return nasada;
	}
};

