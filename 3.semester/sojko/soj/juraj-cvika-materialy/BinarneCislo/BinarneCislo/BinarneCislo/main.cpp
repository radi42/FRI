#include "Test.h"
#include <cstdio>

int main()
{
	bool ok{ true };
	Test t;
	ok = t.run();

	if (ok)
		;
	else
		printf("kdesi je chyba");

	return 0;
}