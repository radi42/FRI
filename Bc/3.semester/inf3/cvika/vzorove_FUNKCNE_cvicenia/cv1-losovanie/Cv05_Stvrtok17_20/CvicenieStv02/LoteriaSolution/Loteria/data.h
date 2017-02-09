#pragma once 

//#ifndef DATA_H
//	#define DATA_H

#define POCET_ZREBOV 10
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

extern struct zreb zreby[POCET_ZREBOV];

//#endif