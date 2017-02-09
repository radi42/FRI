#pragma once

//#ifndef DATA_H
//	#define DATA_H
#define POCET_ZREBOV 10
#define DLZKA_MENA 11

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

extern struct zreb zreby[POCET_ZREBOV];

//#endif