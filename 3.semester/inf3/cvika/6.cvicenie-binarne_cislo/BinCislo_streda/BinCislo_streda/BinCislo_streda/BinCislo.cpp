#include <cstring>
#include <cmath>
#include <iostream>
#include "BinCislo.h"


BinCislo::~BinCislo()
{
}

//konverzia "01" na long long
long long BinCislo::Bin2LL(const char * bcislo)
{
	long long cislo{ 0 };
	if (bcislo && *bcislo)
	{
		int dlzka = strlen(bcislo);
		char *pomcislo = new char[dlzka + 1];
		strcpy(pomcislo, bcislo);
		strrev(pomcislo);

		for (int i = 0; i < dlzka; i++)
		{
			if (pomcislo[i] == '1')
				//cislo = cislo + pow(2, i);
				cislo += pow(2, i);
				//cislo += (1 << i);
		}
		if (bcislo[0] == '-')
			cislo = -cislo;

		delete[] pomcislo;
		return cislo;
	}
	return 0;
}

//konverzia long long na "01"
const char * BinCislo::LL2Bin(long long cislo, char * pomcislo)
{
	long long pcislo = llabs(cislo);
	int i = 0;
	do{
		pomcislo[i++] = (pcislo % 2) + '0'; //'0' = 0x30
		pcislo /= 2; //pcislo = pcislo / 2
		//pcislo >>= 1;
	} while (pcislo > 0);

	if (cislo < 0)
	{
		pomcislo[i] = '-';
		i++;
	}
	pomcislo[i] = '\0';
	strrev(pomcislo);
	
	return pomcislo;
}

void BinCislo::vypis()
{
	char bcislo[100];
	LL2Bin(aCislo, bcislo);
	//std::cout << bcislo << std::endl;
	printf("%s\n", bcislo);
	//delete[] bcislo;
}
