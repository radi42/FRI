#define TESTY

#ifdef TESTY
#include "Test.h"
#endif

int main()
{
	bool ok{ true };
#ifdef TESTY
	Test t;
	ok = t.run();
#endif
	if (ok)
	{
		; // aktivacia sifratora
	}
	return 0;
}