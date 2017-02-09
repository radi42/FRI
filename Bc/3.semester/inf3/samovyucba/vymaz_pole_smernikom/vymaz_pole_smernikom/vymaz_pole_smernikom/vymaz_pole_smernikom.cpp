#include <iostream>

using namespace std;

int main(){
	int pole[10];
	int *p;

	for (int i = 0; i < 10; i++)
	{
		pole[i] = i;
		cout << pole[i] << endl;
	}

	for (p = pole; p - pole < 10; p++)
	{
		*p = 0;
	}

	cout << endl;

	for (int i = 0; i < 10; i++)
	{
		cout << pole[i] << endl;
	}

	return 0;
}