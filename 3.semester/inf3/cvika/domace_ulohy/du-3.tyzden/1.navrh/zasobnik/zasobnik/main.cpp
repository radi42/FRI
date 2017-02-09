#include "zasobnik.h"
#include <iostream>
#include <limits>

int main()
{
	//Naplnanie zasobnika
	zasobnik.push_back(1);
	zasobnik.push_back(2);
	zasobnik.push_back(3);
	zasobnik.push_back(4);
	zasobnik.push_back(5);

	//vytvor pole s veeeelkou kapacitou
	int pole[500] {};

	//Vypis zasobnika
	cout << "Prvky zasobnika\n";
	for (int i = 0; i < zasobnik.size(); i++)
	{
		cout << (i + 1);
		cout << ". prvok: ";
		cout << zasobnik.at(i);		//vypise prvky zasobnika
		cout << "\n";
		pole[i] = zasobnik.at(i);	//kazdy prvok zasobnika pridaj do pola v poradi, v akom sme ich do zasobnika zadavali
	}

	//Vypis pola
	cout << "\n";
	cout << "\n";
	cout << "Prvky pola\n";
	for (int i = 0; i < zasobnik.size(); i++)
	{
		cout << (i + 1);
		cout << ". prvok: ";
		cout << pole[i];		//vypise prvky zasobnika
		cout << "\n";
	}

	return 0;
}