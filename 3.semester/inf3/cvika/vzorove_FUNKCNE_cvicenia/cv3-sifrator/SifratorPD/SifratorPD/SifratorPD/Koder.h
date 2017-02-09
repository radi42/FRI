#pragma once

#include <stdlib.h>
#include <string.h>
#include <cstdio>

const int DLZKA_TABULKY=256;

class Koder
{
private:
	unsigned char aKodovaciaTab[DLZKA_TABULKY];

	void naplnKodTabulku()
	{
		for (int i=0; i<DLZKA_TABULKY; i++)
		{
			aKodovaciaTab[i]=i;
		}
	}

	unsigned int dajNasadu(const char *heslo)
	{
		return 0;
	}

	void vymen(unsigned char &a, unsigned char &b)
	{
		unsigned char pom = a;
		a=b;
		b=pom;
	}

	void zakodujTabulku(const char *heslo)
	{
		unsigned int nasada = dajNasadu(heslo);
		srand(nasada);
		for (int i=0;i<DLZKA_TABULKY;i++)
		{
			int index = rand() % (DLZKA_TABULKY - i);
			vymen(aKodovaciaTab[index], aKodovaciaTab[DLZKA_TABULKY-i - 1]);
		}
	}

public:

	Koder(void)
	{
	}

	~Koder(void)
	{
	}

	unsigned char *koduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTabulku();
		zakodujTabulku(heslo);
		//koduj text
		int dlzkaTextu = strlen((char *)text);
		unsigned char *kodText = new unsigned char[dlzkaTextu];
		for (int i=0; i<dlzkaTextu; i++)
		{
			kodText[i] = aKodovaciaTab[text[i]];
		}
		//zasifruj text
		unsigned char *sifrovanyText = new unsigned char[dlzkaTextu*3+1];
		int k=0;
		for (int i=0; i<dlzkaTextu; i++)
		{
			char cisKod[4];
			sprintf(cisKod, "%03u", kodText[i]);
			memmove(&sifrovanyText[k],cisKod,3);
			k+=3;
		}
		sifrovanyText[k] = '\0';
		//  nutne
		delete[] kodText;
		return sifrovanyText;
	}

	unsigned char *dekoduj(const char *heslo, const unsigned char *text)
	{
		naplnKodTabulku();
		zakodujTabulku(heslo);
		//desifruj text
		int dlzkaTextu = strlen((char *)text);
		unsigned char *kodText=new unsigned char[dlzkaTextu/3];
		char cisKod[4];
		int i=0, k=0;
		while (i<dlzkaTextu)
		{
			memmove(cisKod, &text[k], 3*sizeof(char));
			kodText[i++] = (unsigned char)atoi(cisKod);
			k+=3;
		}
		//dekoduj text

	}
};

