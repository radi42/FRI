#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>

const int DLZKA_TABULKY = 256;

class Koder
{
private:
	unsigned char aKodovaciaTab[DLZKA_TABULKY];
	
	void naplnKodTabulku()
	{
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			aKodovaciaTab[i] = i;
		}
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c = a;
		a = b;
		b = c;
	}

	void zakodujKodTabulku(const char *heslo)
	{
		unsigned int nasada = dajNasadu(heslo);
		srand(nasada);
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			int index = rand() % (DLZKA_TABULKY - i);
			vymen(aKodovaciaTab[index], aKodovaciaTab[DLZKA_TABULKY - i - 1]);
		}
	}

	unsigned int dajNasadu(const char *heslo)
	{
		return 0;
	}

	void zamen(unsigned char *text, int i, unsigned char val)
	{
		if (i > 0)
			zamen(text, i - 1, text[i - 1]);
		text[val] = i;
	}

	void dekodujTabulku()
	{
		zamen(aKodovaciaTab, DLZKA_TABULKY - 1, aKodovaciaTab[DLZKA_TABULKY - 1]);
	}
	
	void dekodujTabulku1()
	{
		unsigned char *pom = new unsigned char[DLZKA_TABULKY];
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			pom[aKodovaciaTab[i]] = i;
		}
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			aKodovaciaTab[i] = pom[i];
		}
		delete[] pom;
	}

public:
	unsigned char *koduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTabulku();
		zakodujKodTabulku(heslo);

		int dlzkaTextu = strlen((char*)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu];
		//zakoduj text
		for (int i = 0; i < dlzkaTextu; i++)
		{
			kodText[i] = aKodovaciaTab[text[i]];
		}

		//sifrovanie textu
		unsigned char *sifrovanyText = new unsigned char[dlzkaTextu*3+1];
		int k = 0;
		for (int i = 0; i < dlzkaTextu; i++)
		{
			char ciskod[4];
			int pocet = sprintf(ciskod,"%03u", kodText[i]);
			memmove(&sifrovanyText[k], ciskod, pocet);
			k += pocet;
		}
		sifrovanyText[k] = '\0';
		// nutne!!
		delete[] kodText;
		return sifrovanyText;
	}
	
	unsigned char *dekoduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTabulku();
		zakodujKodTabulku(heslo);
		dekodujTabulku();

		int dlzkaTextu = strlen((char*)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu/3];
		//prevod trojmiestnych cisel na znaky
		char cisKod[4];
		int i = 0, k = 0;
		while (i < dlzkaTextu)
		{
			memmove(cisKod, &text[i], 3);
			kodText[k++] = (unsigned char)atoi(cisKod);
			i += 3;
		}
	}
};

