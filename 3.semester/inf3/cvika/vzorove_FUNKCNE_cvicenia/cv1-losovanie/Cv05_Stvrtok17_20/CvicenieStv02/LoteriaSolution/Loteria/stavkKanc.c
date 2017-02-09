#include "stavkKanc.h"
#include "vstup.h"
#include "vystup.h"
#include "losovanie.h"

void losovanie(int pocet)
{
	pripravZreby();
	zrebuj(pocet);
	vypis(pocet);
}