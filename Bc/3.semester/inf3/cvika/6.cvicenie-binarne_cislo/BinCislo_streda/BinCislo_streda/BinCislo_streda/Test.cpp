#include "Test.h"
#include "BinCislo.h"


Test::Test()
{
}


Test::~Test()
{
}

//testovanie
bool Test::run()
{
	BinCislo a("101"), b("1011"), c, d, e, f("-1101");
	c = a + b;
	d = 3 + b;
	e = a + 4;
	a.vypis();
	c.vypis();
	d.vypis();
	e.vypis();
	bool por = a > b;
	return por;
}