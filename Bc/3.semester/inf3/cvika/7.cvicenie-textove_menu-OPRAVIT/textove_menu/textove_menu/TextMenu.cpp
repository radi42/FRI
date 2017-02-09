#include "TextMenu.h"


TextMenu::TextMenu(unsigned int pocet, IVstup &vstup, IVystup &vystup)
	: aPocet(pocet), aVstup(vstup), aVystup(vystup)
	//aPrikazy(pocet > 0 ? new ICommand *[aPocet] : NULL)
{
	if (aPocet > 0){
		aPrikazy = new ICommand *[aPocet];
		for (int i = 0; i < aPocet; i++)
		{
			aPrikazy[i] = NULL;
		}
	}
}


TextMenu::~TextMenu()
{
	for (int i = 0; i < aPocet; i++)
	{
		if (!aPrikazy[i])
			delete aPrikazy[i];

		else
			break;
	}
	delete[] aPrikazy; //dvojstupnove vymazavanie objektov - najprv prvky vnitri pola a potom pole samotne
}

int TextMenu::najdiPrveVolne(){
	for (int i = 0; i < aPocet; i++){
		if (!aPrikazy)
			return i;
	}
	return -1;
}