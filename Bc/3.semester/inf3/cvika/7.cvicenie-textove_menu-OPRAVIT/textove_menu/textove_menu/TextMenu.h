#pragma once

#include "ICommand.h"
#include "IVstup.h"
#include "IVystup.h"

class TextMenu
{
private:
	//dve hviezdicky znamena smernik na pole smernikov, vytvorime si smernik na pole smernikov :D
	ICommand **aPrikazy;
	unsigned int aPocet;
	IVstup &aVstup;
	IVystup &aVystup;
	int najdiPrveVolne();

public:
	TextMenu(unsigned int pocet, IVstup &vstup, IVystup &vystup);
	~TextMenu();
};
