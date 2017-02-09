#pragma once
#include <iostream>
#include "koder.h"
#include "Vstup.h"
#include "Vystup.h"
#include "Heslo.h"

using namespace std;

class test
{
public:
	bool run()
	{
		/*koder k;

		unsigned char zdrojtext[] {"fakulta"};
		cout << "zdrojovy text" << zdrojtext << endl;
		unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);
		cout << "sifrovany text" << sifrovanytext << endl;
		unsigned char *desifrovanytext = k.dekoduj(NULL, sifrovanytext);
		cout << "sifrovany text" << desifrovanytext << endl;

		delete[] sifrovanytext;
		delete[] desifrovanytext;

		return true;*/

		koder k;

		Vstup in("pomocnik.cpp");

		const unsigned char *zdrojtext = in.nacitaj();
		const unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);
		
		Vystup out("output.txt");
		out.zapis(sifrovanytext);

		const unsigned char *desifrovanytext = k.dekoduj("abc", sifrovanytext);
		Vystup deout("deout.txt");
		deout.zapis(desifrovanytext);

		delete[] sifrovanytext;
		delete[] desifrovanytext;
		delete[] zdrojtext;

		return true;
	}




	test()
	{
	}

	~test()
	{
	}
};

