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
		unsigned char *zakodovanyText = k.koduj("heslo", (unsigned char *)"Viliam");

		cout << zakodovanyText << endl;

		unsigned char *dekodovanyText = k.dekoduj("heslo", zakodovanyText);

		cout << dekodovanyText << endl;

		delete[] dekodovanyText;
		delete[] zakodovanyText;
		return true;
	}
};

