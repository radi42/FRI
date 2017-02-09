#pragma once 

const int POCET_ZREBOV = 10;

#define UNIX

#ifdef UNIX
#define MOJINT short int
#else
#define MOJINT int
#endif


struct zreb
{
	MOJINT cislo;
	char majitel[11];
};

extern zreb zreby[POCET_ZREBOV];

