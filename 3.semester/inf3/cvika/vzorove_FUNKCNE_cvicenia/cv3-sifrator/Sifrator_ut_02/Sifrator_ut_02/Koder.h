#pragma once

#include <cstdlib>
#include <cstring>
#include <cstdio>

const int DLZKA_TABULKY = 256;
class Koder
{
private:
	unsigned char aKodovaciaTab[DLZKA_TABULKY];

	void nastavKodTabulku()
	{
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodovaciaTab[i] = i;
	}

	unsigned int dajNasada(const char *heslo)
	{
		return 0;
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c = a;
		a = b;
		b = c;
	}

	void zakodujKodTabulku(const char *heslo)
	{
		unsigned int nasada = dajNasada(heslo);
		srand(nasada);
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			int index = rand() % (DLZKA_TABULKY - i);
			vymen(aKodovaciaTab[index], aKodovaciaTab[DLZKA_TABULKY - i - 1]);
		}
	}

	void zamen(unsigned char * text, int i, unsigned char val)
	{
		if (i > 0)
		{
			zamen(text, i - 1, text[i - 1]);
		}
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
			pom[aKodovaciaTab[i]] = i;
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodovaciaTab[i] = pom[i];
		delete[] pom;
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
		nastavKodTabulku();
		zakodujKodTabulku(heslo);
		//zakoduj text
		int dlzkaTextu = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu];
		for (int i = 0; i < dlzkaTextu; i++)
			kodText[i] = aKodovaciaTab[text[i]];
		//zasifruj text
		unsigned char *sifrovanyText = new unsigned char[dlzkaTextu*3+1];
		int k = 0;
		for (int i = 0; i < dlzkaTextu; i++)
		{
			char ciskod[4];
			int pocet = sprintf(ciskod, "%03u", kodText[i]);
			memmove(&sifrovanyText[k], ciskod, pocet*sizeof(char));
			k += pocet;
		}
		sifrovanyText[k] = '\0';
		//pozor!!
		delete[] kodText;

		return sifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *text)
	{
		nastavKodTabulku();
		zakodujKodTabulku(heslo);
		dekodujTabulku();
		
		int dlzkaTextu = strlen((char *)text);
		//prevod trojmiestnych cisel na znaky
		unsigned char *kodText = new unsigned char[dlzkaTextu/3];
		int i = 0, k = 0;
		char ciskod[4];
		while (i < dlzkaTextu)
		{
			memmove(ciskod, &text[k], 3);
			kodText[k++] = (unsigned char)atoi(ciskod);
			i += 3;
		}
		// dekodovanie textu
		unsigned char *desifrovanyText = new unsigned char[dlzkaTextu / 3 + 1];
		for (int i = 0; i < k; i++)
		{
			desifrovanyText[i] = aKodovaciaTab[kodText[i]];
		}
		desifrovanyText[k] = '\0';
		delete[] kodText;
		return desifrovanyText;
	}
};

