#include "vypis.h"
#include <cstdio>

void vypis(const char *text)
{
	if (text && *text)		//ak text existuje a je nenulovy
	{
		printf("%s", text);
	}
}