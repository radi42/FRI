#include "Test.h"
#include "BinCislo.h"

Test::Test()
{
}


Test::~Test()
{
}


bool Test::run()
{
	BinCislo a("1111"), b("101"), c, d, e, f("-1010");
	c = a + b;
	c.vypis();
	d = a + 3;
	d.vypis();
	e = 4 + a;
	e.vypis();
	f.vypis();
	a.vypis();
	bool por = a > b;
	return por;
}