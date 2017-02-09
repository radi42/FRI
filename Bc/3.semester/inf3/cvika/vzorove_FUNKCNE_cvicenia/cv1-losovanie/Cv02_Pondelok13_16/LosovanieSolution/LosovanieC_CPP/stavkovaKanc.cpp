#include "stavkovaKanc.h"
#include "vstup.h"
#include "losovanie.h"
#include "vystup.h"

void losuj(int pocet)
{
	pripravZreby();
	zrebuj(pocet);
	vypis(pocet);
}