#pragma once

const int POCET_ZREBOV = 10;
const int DLZKA_MAJITEL = 11;

struct zreb
{
	int cislo;
	char majitel[DLZKA_MAJITEL];
};

extern zreb zreby[POCET_ZREBOV];
