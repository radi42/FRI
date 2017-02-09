#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cctype>
#include "Heslo.h"

const int DLZKA_TABULKY = 256;

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
		unsigned char c{ a };
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
			vymen(aKodTabulka[index], aKodTabulka[DLZKA_TABULKY - i - 1]);
		}
	}
	void pripravTabulku(const char *heslo)
	{
		naplnTabulku();
		zakodujTabulku(heslo);
	}

	void dekodujTabulku()
	{
		unsigned char pom[DLZKA_TABULKY];
		for (int i = 0; i < DLZKA_TABULKY; i++)
			pom[aKodTabulka[i]] = i;
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = pom[i];
	}

	char *vycistiText(const char *text)
	{
		int dlzkatextu = strlen(text);
		char *cistytext = new char[dlzkatextu + 1];
		int k = 0;
		for (int i = 0; i < dlzkatextu; i++)
		{
			if (isdigit(text[i]))
				cistytext[k++] = text[i];
		}
		cistytext[k] = '\0';
		return cistytext;
	}

public:
	char *koduj(const char *heslo, const unsigned char *text)
	{
		pripravTabulku(heslo);

		int dlzkatextu = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzkatextu];
		for (int i = 0; i < dlzkatextu; i++)
			kodText[i] = aKodTabulka[text[i]];

		char *sifrovanyText = new char[dlzkatextu * 3 + 1];
		int k = 0;
		for (int i = 0; i < dlzkatextu; i++)
		{
			char ciskod[4];
			sprintf(ciskod, "%03u", kodText[i]);
			memmove(&sifrovanyText[k], ciskod, 3);
			k += 3;
		}
		sifrovanyText[k] = '\0';

		delete[] kodText;
		return sifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const char *ptext)
	{
		pripravTabulku(heslo);
		dekodujTabulku();
		const char *text = vycistiText(ptext);

		int dlzkatextu = strlen((char *)text);

		unsigned char *kodText = new unsigned char[dlzkatextu / 3];
		char ciskod[4] {};
		int k(0), i(0);
		while (i < dlzkatextu)
		{
			memmove(ciskod, &text[i], 3);
			kodText[k++] = (unsigned char)atoi(ciskod);
			i += 3;
		}

		unsigned char *desifrovanyText = new unsigned char[dlzkatextu / 3 + 1];
		for (int i = 0; i < k; i++)
			desifrovanyText[i] = aKodTabulka[kodText[i]];
		desifrovanyText[k] = '\0';

		delete[] text;
		delete[] kodText;
		return desifrovanyText;
	}

	Koder()
	{
	}

	~Koder()
	{
	}
};

