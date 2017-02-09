#pragma once

//#ifndef DATA_H
//#define DATA_H

#define POCET_ZREBOV 10
#define DLZKA_MAJITEL 11

//#define UNIX
//
//#ifdef UNIX
//	typedef short int MINT;
//#else
//	typedef int MINT;
//#endif

struct zreb
{
	int cislo;
	char majitel[DLZKA_MAJITEL];
};

extern struct zreb zreby[POCET_ZREBOV];

//#endif

//typedef struct 
//{
//	int cislo;
//	char majitel[11];
//} zreb;
//
//zreb zreby[10];