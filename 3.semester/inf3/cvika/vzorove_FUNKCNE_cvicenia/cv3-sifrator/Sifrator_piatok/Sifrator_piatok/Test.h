#pragma once
#include "Koder.h"

class Test
{
public:

	bool runTest()
	{
		Koder k;
		unsigned char *sifrText = 
			k.koduj("q", (unsigned char *)"Piatok");
		unsigned char *desifrovanyText =
			k.dekoduj("q", sifrText);
		return true;
	}
};

