#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cctype>

#include "Heslo.h"

const int KOD_TABULKA_DLZKA = 256;

class Koder
{
private:
	unsigned char aKodTabulka[KOD_TABULKA_DLZKA];

	void clean(unsigned char *zakodovanytext)
	{
		int k = 0;
		int dlzka = strlen((char *)zakodovanytext);
		for (int i = 0; i < dlzka; i++)
		{
			if (isdigit(zakodovanytext[i]))
				zakodovanytext[k++] = zakodovanytext[i];
		}
		zakodovanytext[k] = '\0';
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c = a;
		a = b;
		b = c;
	}

	// Zakodovanie kodovacej tabulky podla hesla
	void zakodujTabulku(Heslo &heslo)
	{
		srand(heslo.dajNasadu());
		for (int i = 0; i < KOD_TABULKA_DLZKA; i++)
		{
			int idx = rand() % (KOD_TABULKA_DLZKA - i);
			vymen(aKodTabulka[idx], aKodTabulka[KOD_TABULKA_DLZKA - i - 1]);
		}
	}

	// Inicializacia kodovacej tabulky
	void napln()
	{
		for (int i = 0; i < KOD_TABULKA_DLZKA; i++)
			aKodTabulka[i] = i;
	}

	void zamen(unsigned char *text, int i, unsigned char val)
	{
		if (i>0)
			zamen(text, i - 1, text[i - 1]);
		text[val] = i;
	}

	void dekodujTabulku()
	{
		zamen(aKodTabulka, KOD_TABULKA_DLZKA - 1, aKodTabulka[KOD_TABULKA_DLZKA - 1]);
	}

	//void dekodujTabulku()
	//{
	//	unsigned char *pomtabulka = new unsigned char[KOD_TABULKA_DLZKA];
	//	for (int i = 0; i < KOD_TABULKA_DLZKA; i++)
	//	{
	//		pomtabulka[aKodTabulka[i]] = i;
	//	}
	//	for (int i = 0; i < KOD_TABULKA_DLZKA; i++)
	//	{
	//		aKodTabulka[i] = pomtabulka[i];
	//	}
	//	delete[] pomtabulka;
	//}
public:
	Koder()
	{
	}
	// Zakodovanie textu
	unsigned char *koduj(Heslo &heslo, const unsigned char *text)
	{
		unsigned char *zakodovanyText{ NULL };
		napln(); // Inicializacia kodovacej tabulky
		zakodujTabulku(heslo); // Zakodovanie kodovacej tabulky podla hesla
		int dlzkaTextu = strlen((char *)text);

		unsigned char *kodText = new unsigned char[dlzkaTextu];

		// Zakodovanie textu podla kodovacej tabulky
		for (int i = 0; i < dlzkaTextu; i++)
			kodText[i] = aKodTabulka[text[i]];

		zakodovanyText = new unsigned char[3 * dlzkaTextu + 1];

		// Konverzia ASCII kodov zakodovaneho textu na cislice
		int k = 0;
		for (int i = 0; i < dlzkaTextu; i++)
		{
			char ciskod[4];
			int pocet = sprintf(ciskod, "%03u", kodText[i]);
			memmove(&zakodovanyText[k], ciskod, pocet);
			k += pocet;
		}
		zakodovanyText[k] = '\0';

		delete[] kodText; // Zmazanie pomocnej tabulky

		return zakodovanyText;  // Vratim zakodovany text
	}

	unsigned char *dekoduj(Heslo &heslo, unsigned char *text)
	{
		napln();
		zakodujTabulku(heslo);
		dekodujTabulku();

		clean(text);
		int dlzkaTextu = strlen((char *)text);
		unsigned char *zakodovanyText{ NULL };
		zakodovanyText = new unsigned char[dlzkaTextu / 3 + 1];
		unsigned char *kodText = new unsigned char[dlzkaTextu / 3 + 1];

		char ciskod[4] {};
		int k = 0, i = 0;
		while (i < dlzkaTextu)
		{
			memmove(ciskod, &text[i], 3);
			kodText[k++] = (unsigned char)atoi(ciskod);
			i += 3;
		}
		kodText[k] = '\0';

		for (int i = 0; i < k; i++)
		{
			zakodovanyText[i] = aKodTabulka[kodText[i]];
		}
		zakodovanyText[k] = '\0';
		delete[] kodText;

		return zakodovanyText;
	}
};

