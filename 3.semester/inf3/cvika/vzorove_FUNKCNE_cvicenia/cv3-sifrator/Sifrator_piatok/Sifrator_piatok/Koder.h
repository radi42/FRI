#pragma once

#include <cstdlib>
#include <cstring>
#include <cstdio>

const int DLZKA_TABULKY = 256;

class Koder
{
private:
	unsigned char aKodTabulka[DLZKA_TABULKY];

	void naplnKodTabulku()
	{
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			aKodTabulka[i] = i;
		}
	}

	unsigned int dajNasadu(const char *heslo)
	{
		return 0;
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char pom = a;
		a = b;
		b = pom;
	}

	void zakodujKodTabulku(const char *heslo)
	{
		unsigned int nasada;
		nasada = dajNasadu(heslo);
		srand(nasada);
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			int index = rand() % (DLZKA_TABULKY - i);
			vymen(aKodTabulka[index], aKodTabulka[DLZKA_TABULKY - i - 1]);
		}
	}

	void dekodujKodTabulku()
	{
		unsigned char *pom = new unsigned char[DLZKA_TABULKY];
		for (int i = 0; i < DLZKA_TABULKY; i++)
		{
			pom[aKodTabulka[i]] = i;
		}
		for (int i = 0; i < DLZKA_TABULKY; i++)
			aKodTabulka[i] = pom[i];
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
		naplnKodTabulku();
		zakodujKodTabulku(heslo);

		//koduj text
		int dlzkaTextu = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu];
		for (int i = 0; i < dlzkaTextu; i++)
		{
			kodText[i] = aKodTabulka[text[i]];
		}

		//sifruj text
		char cisKod[4];
		unsigned char *sifrovanyText = new unsigned char[dlzkaTextu * 3 + 1];
		int k = 0;
		for (int i = 0; i < dlzkaTextu; i++)
		{
			int pocet = sprintf(cisKod, "%03u", kodText[i]);
			memmove(&sifrovanyText[k], cisKod, pocet*sizeof(char));
			k += 3;
		}
		sifrovanyText[k] = '\0';
		//nutne!
		delete[] kodText;

		return sifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTabulku();
		zakodujKodTabulku(heslo);
		dekodujKodTabulku();
		// desifruj text, prevod trojmiestnych cisel na znaky
		int dlzkaTextu = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu/3];
		int i = 0, k = 0;
		char cisKod[4];
		while (i < dlzkaTextu)
		{
			memmove(cisKod, &text[i], 3);
			kodText[k++] = (unsigned char)atoi(cisKod);
			i += 3;
		}

		// dekoduj text
		unsigned char *desifrovanyText = new unsigned char[dlzkaTextu / 3 + 1];
		for (int i = 0; i < k; i++)
		{
			desifrovanyText[i] = aKodTabulka[kodText[i]];
		}
		desifrovanyText[k] = '\0';
		delete[] kodText;
		return desifrovanyText;
	}
};

