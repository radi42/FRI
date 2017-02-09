#include <stdlib.h>
#include <time.h>

#include "tipos.h"
#include "loteria.h"
#include "vstup.h"
#include "vystup.h"

void losovanie()
{
	pripravZreby();
	srand((unsigned)time(NULL));
	zrebuj(3);
	vypis(10);
}