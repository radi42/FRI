#pragma once
#include <string.h>

const int DLZKA_HESLA = 8;	//konvencia: nazvy konstant sa pisu vzdy velkymi pismenami

class Heslo
{
private:
	union{
		char aHeslo[DLZKA_HESLA];
		unsigned int aSeed1;	//seed - miesto, od ktoreho sa odrazame; seedmi si z retazca urobime integer
		unsigned int aSeed2;
	};

public:
	Heslo(const char *heslo)	//char je konstantny - ked ho mame v konstruktore
	{
		memset(aHeslo, 0, sizeof(aHeslo));//nastavime povodne heslo na nulu

		if (heslo != NULL){
			int dlzka = strlen(heslo);
			dlzka = dlzka > DLZKA_HESLA ? DLZKA_HESLA : dlzka;	//zabezpecili sme, ze heslo bude mat max. 8 znakov
			memmove(aHeslo, heslo, dlzka);
		}
	}

	~Heslo()
	{
	}

	unsigned int dajNasadu(){
		unsigned int nasada = aSeed1 + aSeed2;
		return nasada;
	}
};

