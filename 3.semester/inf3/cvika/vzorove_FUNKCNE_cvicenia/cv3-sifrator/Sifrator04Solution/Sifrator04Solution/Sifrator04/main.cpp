#define TESTY

#ifdef TESTY
#include "Test.h"
#endif

int main()
{
	bool ok{ true };

#ifdef TESTY
	Test test;
	ok = test.run();
#endif

	if (ok)
	{
		;// startuj sifrator
	}
	return 0;
}