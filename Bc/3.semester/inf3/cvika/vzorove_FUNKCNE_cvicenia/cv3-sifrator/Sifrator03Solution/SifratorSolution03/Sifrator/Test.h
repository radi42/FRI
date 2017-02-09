#pragma once
#include "Koder.h"
#include <iostream>

using namespace std;

class Test
{
public:
	Test()
	{
	}

	bool run()
	{
		Koder k;
		unsigned char *zkodText = k.koduj("abc", (unsigned char *)"Viliam");

		cout << zkodText << endl;

		unsigned char *dekkodText = k.dekoduj("abc", zkodText);
		cout << dekkodText << endl;


		delete[] zkodText;
		delete[] dekkodText;

		return true;
	}
};

