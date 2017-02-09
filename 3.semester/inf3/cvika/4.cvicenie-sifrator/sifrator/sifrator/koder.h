#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>

const int dlzkaTab = 256;

class koder
{
private:
	unsigned char aKodTab[dlzkaTab];
	void naplnKodTab(){
		for (int i = 0; i < dlzkaTab; i++)
		{
			aKodTab[i] = i;
		}
	}

	unsigned int dajNasadu(const char *heslo)
	{
		return 0;
	}

	void vymen(unsigned char &a, unsigned char &b) //pozrieme sa na adresy znakov (&), potrebujeme vediet adresy na dokoncenie vymeny prvkov pola, ak by sme to zadavali bez znaku &, znaky by sa sice vymenili vo funkcii vymen(), ale prvky by neboli umiestnene naspat do pola, lebo by nemali adresu, kde sa maju vratit
	{
		unsigned char c = a;
		a = b;
		b = c;
	}

	//poprehadzuje cisla v tabulke
	void zakodujKodTab(const char *heslo)
	{
		unsigned int nasada = dajNasadu(heslo);

		for (int i = 0; i < dlzkaTab; i++)
		{
			int index = rand() % dlzkaTab - i; //to co sme uz prehodili/ vymenilli, nebude znova poprehadzovane
			vymen(aKodTab[index], aKodTab[dlzkaTab - i - 1]);	//255, 256-255-1=0
		}
	}

public:
	unsigned char *koduj(const char *heslo, const unsigned char *text)	//parametre: heslo,		text ktory chceme zakodovat
	{
		naplnKodTab();
		zakodujKodTab(heslo);		//heslo bude pouzite neskor do randomu

		int dlzkaText = strlen((char*) text);

		unsigned char *kodText = new unsigned char[dlzkaText];	//
		for (int i = 0; i < dlzkaText; i++)
		{
			kodText[i] = aKodTab[text[i]];
		}

		unsigned char *sifraText = new unsigned char[dlzkaText * 3 + 1];	//+1 pre koncovy znak
		int k = 0;	//index pola jednotlivych cisloc
		for (int i = 0; i < dlzkaText; i++)
		{
			char cisloKod[4];	//3 znakove cislo + ukoncovaci znak
			int pocet = sprintf(cisloKod, "%03u", kodText[i]);
			memmove(&sifraText[k], cisloKod, pocet);
			k += pocet;
		}
		sifraText[k] = '\0';

		//mozme z pamati zmazat cele pole kodText
		delete[] kodText;

		return sifraText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *text)	//parametre: heslo,		text ktory chceme zakodovat
	{
		naplnKodTab();
		zakodujKodTab(heslo);
		dekodujTab();

		int dlzkaText = strlen((char*)text);
		unsigned char *kodText = new unsigned char[dlzkaText / 3];
		char cisloKod[4];
		int i = 0, k = 0;

		while (i < dlzkaText)
		{
			memmove(cisloKod, &text[i], 3);
			kodText[k] = (unsigned char)atoi(cisloKod);
			k++;
			i += 3;
		}

		unsigned char *desifraText = new unsigned char[dlzkaText / 3 +1];
		for (size_t i = 0; i < k; i++)
		{
			desifraText[i] = aKodTab[kodText[i]];
		}
		desifraText[k] = '\0';
		delete[] kodText;
		return desifraText;
	}
	
	void zamen(unsigned char *text, int i, unsigned char val) //i = 255 => zamen(aKodTab, 255, aKotTab[255])
	{
		if (i > 0)
			zamen(text, i - 1, text[i - 1]);

		text[val];
	}

	//dekodujeme celu tabulku cez rekurziu
	void dekodujTab()
	{
		zamen(aKodTab, dlzkaTab -1, aKodTab[dlzkaTab -1]);
	}

	//dekodujeme celu tabulku
	void dekodujTab1()
	{
		unsigned char *pom = new unsigned char[dlzkaTab];

			for (int i = 0; i < dlzkaTab; i++)
			{
				pom[aKodTab[i]] = i;
			}

			for (int i = 0; i < dlzkaTab; i++)
			{
				aKodTab[i] = pom[i];
			}
	}


	koder()
	{
	}

	~koder()
	{
	}
};

