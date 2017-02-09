#pragma once

//#ifndef DATA_H
//	#define DATA_H
#define POCET_ZREBOV 10

struct zreb {
	int cislo;
	char majitel[11];
};

extern struct zreb zreby[POCET_ZREBOV];

//#endif