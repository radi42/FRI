#include <cstdio>
#include "helper.h"

int dlzkaSuboru(const char *menoSuboru)
{
	FILE *f = fopen(menoSuboru,"rb");
	if (f != NULL)
	{
		fseek(f, 0, SEEK_END);
		int velkost = ftell(f);
		fclose(f);
		return velkost;
	}
	return 0;
}
