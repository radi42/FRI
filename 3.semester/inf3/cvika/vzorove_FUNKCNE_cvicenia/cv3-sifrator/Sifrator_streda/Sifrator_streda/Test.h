#pragma once
#include "Koder.h"

class Test
{
public:

	bool RunTest()
	{
		Koder k;
		unsigned char *sifrText = k.Koduj("aaa", (unsigned char *)"Streda");
		unsigned char *desifrovanyText = k.Dekoduj("aaa", sifrText);
		delete[] desifrovanyText;
		delete[] sifrText;
		return true;
	}
};

