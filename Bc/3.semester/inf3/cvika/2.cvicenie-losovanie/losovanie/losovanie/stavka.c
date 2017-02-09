#include "data.h"
#include "vstup.h"
#include "loteria.h"
#include "vystup.h"
#include <time.h>


void losovanie(int paPocet)
{
	pripravZreby();
	srand((unsigned)time(NULL) ); //zistit nieco o funkcii srand(); unsigned
	zrebuj(paPocet);
	vystup(paPocet);
}