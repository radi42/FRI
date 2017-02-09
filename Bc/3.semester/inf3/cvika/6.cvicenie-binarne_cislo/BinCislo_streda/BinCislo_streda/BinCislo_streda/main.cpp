#include <iostream>
#include "Test.h"

int main()
{
	bool ok{ true };
	Test t;
	ok = t.run();

	if (ok)
		;
	else
		std::cout << "niekde je chyba" << std::endl;
	
	return 0;
}