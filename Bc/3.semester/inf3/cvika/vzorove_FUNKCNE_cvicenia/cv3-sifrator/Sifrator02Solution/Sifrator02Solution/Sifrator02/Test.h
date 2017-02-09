#pragma once
#include "Koder.h"

class Test
{
public:
	bool run()
	{
		Koder k;

		unsigned char zdrojtext[] {"Viliam"};
		cout << "Zdrojovy text:" << zdrojtext << endl;
		unsigned char *sifrtext = k.koduj("abc", (unsigned char *)zdrojtext);
		cout << "Zasifrovany text:" << sifrtext << endl;
		unsigned char *desifrtext = k.dekoduj(NULL, sifrtext);
		cout << "Desifrovany text:" << desifrtext << endl;

		delete[] desifrtext;
		delete[] sifrtext;
		return true;
	}
};

