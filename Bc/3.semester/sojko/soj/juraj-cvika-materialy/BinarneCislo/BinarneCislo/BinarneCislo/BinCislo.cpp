#include "BinCislo.h"
#include <cstring>
#include <cmath>
#include <cstdio>

BinCislo::~BinCislo()
{
}


// konverzia "01" na long long dekadicky tvar
long long BinCislo::Bin2LL(const char * bcislo)
{
	long long cislo{ 0 };
	if (bcislo && *bcislo)
	{
		int dlzka = strlen(bcislo);
		char *pomcislo = new char[dlzka + 1]; //+1 koncovy znak
		strcpy(pomcislo, bcislo);
		strrev(pomcislo);

		for (int i = 0; i < dlzka; i++)
		{
			if (pomcislo[i] == '1')
				//cislo += pow(2, 1);
				cislo += (1 << i); //

			/* 1 0 1 1
			   8 4 2 1
			 */
		}
		if (bcislo[0] == '-')
			cislo = -cislo;

		delete[] pomcislo;

		return cislo;

	}

	return 0;
}


// konverza cisla na retqaz "01"
const char * BinCislo::LL2Bin(long long cislo, char * pomCislo)
{
	long long pcislo = llabs(cislo);
	int i = 0;
	do {
		pomCislo[i++] = (pcislo % 2) + '0'; //priradzujeme znaky // hex nula 0x30
		//pcislo /= 2; //pomale, rychlejsie cez bit shifit
		pcislo >>= 1; //prirad bit posun doprava o 1 miesto

	} while (pcislo > 0);

	if (cislo < 0)
	{
		pomCislo[i++] = '-';
	}

	pomCislo[i] = '\0';
	strrev(pomCislo);

	return pomCislo;
}


void BinCislo::vypis()
{
	char bcislo[100]; //netreba deletovat lebo nie je na halde ale na zasobniku ako lokal prem
	LL2Bin(aCislo, bcislo);
	printf("%s\n", bcislo);
}