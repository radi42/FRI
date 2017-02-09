#include "vstup.h"
#include <cstdio>	 //cstdio je pre c++ 2011, stdio je pre c++ 1999
#include <iostream>  //cin/cout funkcie

namespace cVstup
{
	int vstup()
	{
		int cislo;
		scanf("%d", &cislo);		//scanf = nacitanie z klavesnice; %d berieme cislo, &cislo = berieme hodnotu cisla
		return cislo;
	}
}

namespace cppVstup
{
	int vstup()
	{
		int cislo;
		std::cin >> cislo;
		return cislo;
	}
}