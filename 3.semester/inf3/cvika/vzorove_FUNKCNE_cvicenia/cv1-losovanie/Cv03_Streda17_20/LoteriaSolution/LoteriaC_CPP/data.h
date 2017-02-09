#pragma once

const int POCET_ZREBOV = 10;

struct zreb {
	int cislo;
	char majitel[11];
};

extern zreb zreby[POCET_ZREBOV];
