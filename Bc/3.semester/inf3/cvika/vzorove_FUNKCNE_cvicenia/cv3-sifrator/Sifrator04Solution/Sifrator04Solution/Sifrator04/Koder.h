#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cctype>
#include "Heslo.h"

const int DLZKA_TABULKY = 256;
//#define DLZKA_TABULKY 256

class Koder
{
private:
	unsigned char aKodTabulka[DLZKA_TABULKY];

	unsigned int dajNasadu(const char *heslo)
	{
		Heslo h(heslo);
		unsigned int nasada = h.dajNasadu();
		return nasada;
	}

	void naplnTabulku()
	{
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = i;
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c(a);
		a = b;
		b = c;
	}

	void zakodujTabulku(const char *heslo)
	{
		unsigned int nasada = dajNasadu(heslo);
		srand(nasada);
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			int index = rand() % (DLZKA_TABULKY - i);
			vymen(aKodTabulka[index], aKodTabulka[DLZKA_TABULKY - 1 - i]);
		}
	}
	void pripravTabulku(const char *heslo)
	{
		naplnTabulku();
		zakodujTabulku(heslo);
	}

	void dekodujTabulku()
	{
		//		unsigned char *pomTabulka = new unsigned char[DLZKA_TABULKY];
		unsigned char pomTabulka[DLZKA_TABULKY];
		for (int i = 0; i < DLZKA_TABULKY; i++)
			pomTabulka[aKodTabulka[i]] = i;
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = pomTabulka[i];
		//		delete[] pomTabulka;
	}

	unsigned char *cleanText(const unsigned char *ptext)
	{
		int dlzka = strlen((char *)ptext);
		unsigned char *text = new unsigned char[dlzka + 1];
		int k = 0;
		for (int i = 0; i < dlzka; i++)
		{
			if (isdigit(ptext[i]))
				text[k++] = ptext[i];
		}
		text[k] = '\0';
		return text;
	}


public:
	unsigned char *koduj(const char *heslo, const unsigned char *text)
	{
		pripravTabulku(heslo);
		int dlzka = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzka];
		for (int i = 0; i < dlzka; i++)
			kodText[i] = aKodTabulka[text[i]];

		unsigned char *sifrovanyText = new unsigned char[dlzka * 3 + 1];

		int k(0);
		for (int i = 0; i < dlzka; i++)
		{
			char kodcislo[4];
			int pocet = sprintf(kodcislo, "%03u", kodText[i]);
			memmove(&sifrovanyText[k], kodcislo, pocet);
			k += pocet;
		}
		sifrovanyText[k] = '\0';

		delete[] kodText;

		return sifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *ptext)
	{
		pripravTabulku(heslo);
		dekodujTabulku();
		unsigned char *text = cleanText(ptext);

		int dlzka = strlen((char *)text);
		unsigned char *dekodText = new unsigned char[dlzka / 3];
		int k = 0, i(0);
		char ciskod[4]; // = { '\0', '\0', '\0', '\0' };
		ciskod[3] = '\0';
		while (i < dlzka)
		{
			memmove(ciskod, &text[i], 3);
			dekodText[k++] = atoi(ciskod);
			i += 3;
		}
		unsigned char *desifrovanyText = new unsigned char[dlzka / 3 + 1];
		for (int i = 0; i < k; i++)
			desifrovanyText[i] = aKodTabulka[dekodText[i]];
		desifrovanyText[k] = '\0';

		delete[] text;
		delete[] dekodText;
		return desifrovanyText;
	}


	Koder()
	{
	}

	~Koder()
	{
	}
};

