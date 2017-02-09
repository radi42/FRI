#include "stavkKanc.h"
#include "vstup.h"
#include "losovanie.h"
#include "vystup.h"

void losovanie(int pocet)
{
	pripravZreby();
	zrebuj(pocet);
	vypis(pocet);
}