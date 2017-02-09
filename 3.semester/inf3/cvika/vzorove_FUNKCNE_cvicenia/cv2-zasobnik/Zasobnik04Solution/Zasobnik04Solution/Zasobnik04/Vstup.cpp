#include "Vstup.h"
#include <cstdio>
#include <iostream>

namespace cvstup
{
	unsigned int vstup()
	{
		int cislo;
		scanf("%u", &cislo);
		return cislo;
	}
}

namespace cppvstup
{
	unsigned int vstup()
	{
		int cislo;
		std::cin >> cislo;
		return cislo;
	}
}

