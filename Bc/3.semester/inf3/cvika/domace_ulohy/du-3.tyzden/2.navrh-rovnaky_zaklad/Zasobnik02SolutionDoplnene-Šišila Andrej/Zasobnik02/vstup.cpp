#include <iostream>
#include <cstdio>

#include "vstup.h"


namespace cvstup
{
	int vstup()
	{
		int cislo;
		scanf("%d", &cislo);
		return cislo;
	}
}


namespace cppvstup
{
	int vstup()
	{
		int cislo;
		std::cin >> cislo;
		return cislo;
	}
}

