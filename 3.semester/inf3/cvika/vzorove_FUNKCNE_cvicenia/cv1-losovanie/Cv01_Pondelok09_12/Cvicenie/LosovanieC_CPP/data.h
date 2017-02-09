#pragma once

const int POCET_ZREBOV = 10;
const int DLZKA_MENA = 11;

struct zreb
{
	int  cislo;
	char majitel[DLZKA_MENA];
};

extern zreb vyherneZreby[POCET_ZREBOV];

