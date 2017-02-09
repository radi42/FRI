#include <cstdio>
#include "Vystup.h"

void vypis(const char *text)
{
	if (text && *text)
	{
		printf("%s", text);
	}
}