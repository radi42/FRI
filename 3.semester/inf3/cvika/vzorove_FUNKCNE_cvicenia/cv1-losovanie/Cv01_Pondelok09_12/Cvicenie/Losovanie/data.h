#pragma once

#define POCET_ZREBOV 10
#define DLZKA_MENA	 11

////#ifndef DATA_H
////#define DATA_H
//#define UNIX
//
//#ifdef UNIX
//	typedef short int MINT;
//#else
//	typedef int MINT;
//#endif
	
struct zreb
{
	int  cislo;
	char majitel[DLZKA_MENA];
};

extern struct zreb vyherneZreby[POCET_ZREBOV];

//#endif

// Alternativa
//typedef struct 
//{
//	int cislo;
//	char majitel[11];
//} zreb;
//
//zreb vyherneZreby[10];