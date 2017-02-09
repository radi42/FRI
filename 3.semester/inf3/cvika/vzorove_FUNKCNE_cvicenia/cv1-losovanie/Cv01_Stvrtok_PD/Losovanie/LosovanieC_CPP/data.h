#pragma once

#define POCET_ZREBOV 10

struct zreb
{
	int cislo;
	char majitel[21];
};

extern zreb vyherneZreby[POCET_ZREBOV];
