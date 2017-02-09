#pragma once
#include "koder.h"
#include <iostream>

using namespace std;
class test
{
public:
	bool run()
	{
		koder k;

		unsigned char zdrojtext[]{"fakulta"};
		cout << "zdrojovy text " << zdrojtext << endl;

		unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);
		cout << "sifrovany text " << sifrovanytext << endl;

		unsigned char *desifrovanytext = k.dekoduj(NULL, sifrovanytext);
		delete[] sifrovanytext;
		delete[] desifrovanytext;
		return true;
	}





	test()
	{
	}

	~test()
	{
	}
};

