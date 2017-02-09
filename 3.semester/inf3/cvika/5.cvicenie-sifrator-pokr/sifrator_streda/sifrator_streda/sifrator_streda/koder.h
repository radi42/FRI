#pragma once
#include <cstdlib>
#include <cstring>
#include <cstdio>

#include "Heslo.h"

const int dlzkaTab = 256;

class koder
{
private:
	unsigned char aKodTab[dlzkaTab];
	void naplnKodTab()
	{
		for (int i = 0; i < dlzkaTab; i++)
		{
			aKodTab[i] = i;
		}
	}

	unsigned int dajNasadu(const char *heslo)
	{
		Heslo h(heslo);
		return h.dajNasadu();
	}


	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char c = a;
		a = b;
		b = c;
	}

	void zakodujKodTab(const char *heslo)
	{
		unsigned int nasada = dajNasadu(heslo);
		srand(nasada);
		for (int i = 0; i < dlzkaTab; i++)
		{
			int index = rand() % (dlzkaTab - i);
			vymen(aKodTab[index], aKodTab[dlzkaTab - i - 1]);
		}
	}

	void zamen(unsigned char *text, int i, unsigned char val)
	{
		if (i > 0)
			zamen(text, i - 1, text[i - 1]);

		text[val] = i;
	}

	void dekodujKodTab()
	{
		zamen(aKodTab, dlzkaTab - 1, aKodTab[dlzkaTab - 1]);
	}
	
	
	
	void dekodujKodTab1()
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

public:
	unsigned char *koduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTab();
		zakodujKodTab(heslo);

		int dlzkaText = strlen((char*)text);
		unsigned char *kodText = new unsigned char[dlzkaText];

		for (int i = 0; i < dlzkaText; i++)
		{
			kodText[i] = aKodTab[text[i]];
		}

		unsigned char *sifraText = new unsigned char[dlzkaText * 3 + 1];
		int k = 0;
		for (int i = 0; i < dlzkaText; i++)
		{
			char cisloKod[4];
			int pocet = sprintf(cisloKod, "%03u", kodText[i]);
			memmove(&sifraText[k], cisloKod, pocet);
			k += pocet;
		}
		sifraText[k] = '\0';
		delete[] kodText;
		return sifraText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTab();
		zakodujKodTab(heslo);
		dekodujKodTab();

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

		unsigned char *desifraText = new unsigned char[dlzkaText / 3 + 1];
		for (int i = 0; i < k; i++)
		{
			desifraText[i] = aKodTab[kodText[i]];
		}
		desifraText[k] = '\0';
		delete[] kodText;
		return desifraText;
	}
	koder()
	{
	}

	~koder()
	{
	}

};

