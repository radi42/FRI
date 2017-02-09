#pragma once
#include <iostream>
#include "Koder.h"

using namespace std;

class Test
{
public:
	bool run()
	{
		Koder k;
		char *zakodovanyText = k.koduj("abc", (unsigned char *)"Viliam");
		cout << zakodovanyText << endl;

		unsigned char *dekodovanyText = k.dekoduj("abc", zakodovanyText);
		cout << dekodovanyText << endl;

		delete[] dekodovanyText;
		delete[] zakodovanyText;
		return true;
	}
};

