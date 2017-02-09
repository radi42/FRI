//#include "test.h"
#include "Sifrator.h"
#include <iostream>

using namespace std;

int main(int argc, char *argv[])
{
	/*test t;
	t.run();*/

	cout << "Zadaj cinnost: " << endl;
	char cinnost;
	cin >> cinnost;
	if (cinnost != 'h' && cinnost != 's' && cinnost != 'd')
		cinnost = 'h';		//zrejme ouzivatel zadal nespravny znak, tak mu vyhodi pomocnika

	char *heslo{};
	char *vstup{};
	char *vystup{};

	heslo = argv[1];
	vstup = argv[2];
	vystup = argv[3];

	Sifrator sifra(cinnost, heslo, vstup, vystup);
	sifra.start();


	//pridat vypis na konzolu
	return 0;
}