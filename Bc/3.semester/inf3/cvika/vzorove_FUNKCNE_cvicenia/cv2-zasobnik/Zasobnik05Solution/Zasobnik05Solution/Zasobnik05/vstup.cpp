#include <cstdio>
#include <iostream>

#include "Vstup.h"

namespace cvstup
{
	unsigned int vstup()
	{
		unsigned int cislo;
		scanf("%u", &cislo);
		return cislo;
	}
}


namespace cppvstup
{
	unsigned int vstup()
	{
		unsigned int cislo;
		std::cin >> cislo;
		return cislo;
	}
}