#pragma once
#include "Koder.h"

class Test
{
public:
	bool runTest()
	{
		Koder k;
		k.koduj("qwe", (unsigned char *) "Stvrtok");
		return true;
	}

};

