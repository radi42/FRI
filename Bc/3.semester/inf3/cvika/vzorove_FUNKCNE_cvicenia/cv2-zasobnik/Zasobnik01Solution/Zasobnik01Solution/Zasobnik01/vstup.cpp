#include <iostream>
#include <cstdio> // C++2011;  stdio.h pre C++99

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
	//using namespace std;
	int vstup()
	{
		int cislo;
		std::cin >> cislo;
		return cislo;
	}
}