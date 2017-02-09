#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <cctype>

const unsigned int DLZKA_TABULKY = 256;

class Koder
{
private:
	unsigned char aKodTabulka[DLZKA_TABULKY];

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c(a);
		a = b;
		b = c;
	}


	unsigned int dajNasadu(const char *heslo)
	{
		unsigned int ret = 0;
		return ret;
	}

	void naplnKodTabulka()
	{
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = i;
	}

	void zakodujKodTabulku(const char *heslo)
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
		naplnKodTabulka();
		zakodujKodTabulku(heslo);
	}

	//void zamenIndex(unsigned char *tabulka, int index, unsigned char val)
	//{
	//	if (index > 0)
	//		zamenIndex(tabulka, index - 1, tabulka[index - 1]);
	//	tabulka[val] = index;
	//}

	//void dekodujTabulku()
	//{
	//	zamenIndex(aKodTabulka, DLZKA_TABULKY - 1, aKodTabulka[DLZKA_TABULKY - 1]);
	//}

	void dekodujTabulku()
	{
		//unsigned char *pom = new unsigned char[DLZKA_TABULKY];
		unsigned char pom[DLZKA_TABULKY];

		for (int i = 0; i < DLZKA_TABULKY; i++)
			pom[aKodTabulka[i]] = i;
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = pom[i];
		//delete[] pom;
	}

	unsigned char *cleanText(const unsigned char *text)
	{
		int dlzka = strlen((char *)text);
		unsigned char *cistytext = new unsigned char[dlzka + 1];
		int i = 0, k = 0;
		for (i = 0; i < dlzka; i++)
		{
			if (isdigit(text[i]))
				cistytext[k++] = text[i];
		}
		cistytext[k] = '\0';
		return cistytext;
	}


public:

	Koder()
	{
	}

	~Koder()
	{
	}

	unsigned char *koduj(const char *heslo, const unsigned char *text)
	{
		pripravTabulku(heslo);

		int dlzka = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzka];
		for (int i = 0; i < dlzka; i++)
			kodText[i] = aKodTabulka[text[i]];

		unsigned char *zasifrovanyText = new unsigned char[dlzka * 3 + 1];

		int k = 0;
		char ciskod[4] {};

		for (int i = 0; i < dlzka; i++)
		{
			int pocet = sprintf(ciskod, "%03u", kodText[i]);
			memmove(&zasifrovanyText[k], ciskod, pocet);
			k += pocet;
		}
		zasifrovanyText[k] = '\0';

		delete[] kodText;
		return zasifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *ptext)
	{
		pripravTabulku(heslo);
		dekodujTabulku();

		unsigned char *text = cleanText(ptext);

		int dlzka = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzka / 3];

		char ciskod[4] {};

		int k = 0, i = 0;
		while (i < dlzka)
		{
			memmove(ciskod, &text[i], 3);
			kodText[k++] = (unsigned char)atoi(ciskod);
			i += 3;
		}

		unsigned char *desifrovanyText = new unsigned char[dlzka / 3 + 1];
		for (int i = 0; i < k; i++)
			desifrovanyText[i] = aKodTabulka[kodText[i]];
		desifrovanyText[k] = '\0';

		delete[] text;
		delete[] kodText;
		return desifrovanyText;
	}
};

