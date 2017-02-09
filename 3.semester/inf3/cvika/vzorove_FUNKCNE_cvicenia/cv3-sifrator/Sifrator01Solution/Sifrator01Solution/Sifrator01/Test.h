#pragma once
#include <iostream>
#include "Koder.h"
#include "Heslo.h"
#include "Vstup.h"

using namespace std;

class Test
{
public:
	bool run()
	{
		Koder koder;
		Heslo heslo("Tav");
		Heslo dekheslo(NULL);
		Vstup v("main.cpp");

		unsigned char *testtext = v.citaj();

		cout << "Zdroj: " << testtext << endl;
		unsigned char *kodovanytext = koder.koduj(heslo, testtext);
		cout << "Kodovany: " << kodovanytext << endl;

		unsigned char *dekodovanytext = koder.dekoduj(dekheslo, (unsigned char *)kodovanytext);
		cout << "Dekodovany: " << dekodovanytext << endl;

		delete[] kodovanytext;
		delete[] dekodovanytext;
		return true;
	}
};

