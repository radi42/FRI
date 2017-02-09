#pragma once
#include "koder.h"
#include "Vstup.h"
#include "Vystup.h"
#include "Heslo.h"
#include <iostream>

using namespace std;
class test
{
public:
	bool run()
	{
		//komentovanie viacerych oznacenych riadkov: CTRL+K+C, odkomentovat: CTRL+K+U

		//koder k;

		//unsigned char zdrojtext[]{"fakulta"};
		//cout << "zdrojovy text " << zdrojtext << endl;

		//unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);
		//cout << "sifrovany text " << sifrovanytext << endl;

		//unsigned char *desifrovanytext = k.dekoduj(NULL, sifrovanytext);
		//delete[] sifrovanytext;
		//delete[] desifrovanytext;
		//return true;

		koder k;

		Vstup in("pomocnik.cpp");

		const unsigned char *zdrojtext = in.nacitaj();
		const unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);

		Vystup out("output.txt");
		out.zapis(sifrovanytext);

		unsigned char *desifrovanytext = k.dekoduj("abc", sifrovanytext);
		Vystup deout("deout.txt"); //DEsifroany OUTput
		deout.zapis(desifrovanytext);








		cout << "zdrojovy text " << zdrojtext << endl;

		//unsigned char *sifrovanytext = k.koduj("abc", zdrojtext);
		

		cout << "sifrovany text " << sifrovanytext << endl;

		delete[] desifrovanytext;
		delete[] sifrovanytext;
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

