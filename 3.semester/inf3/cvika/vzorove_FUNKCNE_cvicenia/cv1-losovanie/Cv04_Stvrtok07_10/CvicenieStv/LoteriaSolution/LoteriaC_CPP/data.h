#pragma once

const int POCET_ZREBOV = 10;
const int DLZKA_MENA = 11;

#ifdef WIN32
typedef int MOJINT;
#else
typedef short int MOJINT;
#endif

struct zreb
{
	MOJINT cislo;
	char majitel[DLZKA_MENA];
};

extern zreb zreby[POCET_ZREBOV];

