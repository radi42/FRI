#include "Aplikacia.h"
#include "Vstup.h"
#include "HorizontalnyVystup.h"
#include "VetikalnyVystup.h"

Aplikacia::Aplikacia()
:aVstup(new Vstup()), aVystup(new HorizontalnyVystup()), aStudent(new Student("Andrej", "Šišila", "ŽU")), aMenu(new TextMenu(7, *aVstup, *aVystup))
{
	aMenu->pridajPrikaz("[M]eno", USER_ID, this, 'm');		//preto this, lebo sa to tyka IReceivra nie Aplikacie
	aMenu->pridajHSeparator();
	aMenu->pridajPrikaz("[P]riezvisko", USER_ID +1, this, 'p');
	aMenu->pridajHSeparator();
	aMenu->pridajPrikaz("[S]kola", USER_ID + 2, this, 's');
	aMenu->pridajHSeparator();
	aMenu->pridajKoniecCommand();
}


Aplikacia::~Aplikacia()
{
	delete aMenu;
	delete aVstup;
	delete aVystup;
	delete aStudent;
}

void Aplikacia::action(int id){
	string nl = "\n";		//nl aka new line
	aVystup->zobraz(nl);
	switch (id)
	{
	case USER_ID:
		aVystup->zobraz(aStudent->meno());
		break;

	case USER_ID +1:
		aVystup->zobraz(aStudent->priezvisko());
		break;

	case USER_ID + 2:
		aVystup->zobraz(aStudent->skola());
		break;
	}
	aVystup->zobraz(nl);
}