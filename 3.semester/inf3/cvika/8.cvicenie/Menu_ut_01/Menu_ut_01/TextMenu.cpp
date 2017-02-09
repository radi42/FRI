#include "TextMenu.h"
#include "TextCommand.h"
#include "KoniecCommand.h"
#include "Separator.h"
#include "IVstup.h"



TextMenu::TextMenu(unsigned pocet, IVstup &vstup, IVystup &vystup)
: aPocet(pocet), aVstup(vstup), aVystup(vystup),
aPrikazy(pocet > 0 ? new ICommand *[pocet] : NULL)
{
	for (int i = 0; i < aPocet; i++)
		aPrikazy[i] = NULL;
}

void TextMenu::copy(const TextMenu &zdroj){
	for (int i = 0; i < aPocet; i++)
	{
		if (zdroj.aPrikazy[i])
			aPrikazy[i] = zdroj.aPrikazy[i]->kopiruj();
		else
			aPrikazy[i] = NULL;
	}
}

//kopirovaci konstruktor
TextMenu::TextMenu(const TextMenu &zdroj)
:aPocet(zdroj.aPocet), aVstup(zdroj.aVstup), aVystup(zdroj.aVystup),
aPrikazy(aPocet > 0 ? new ICommand *[aPocet] : NULL){
	copy(zdroj);
}

TextMenu &TextMenu::operator = (const TextMenu &zdroj){	//operator priradenia jedneho menu do noveho
	if (&zdroj != this){
		TextMenu::~TextMenu();
		aPocet = zdroj.aPocet;
		aVstup = zdroj.aVstup;
		aVystup = zdroj.aVystup;
		aPrikazy = aPocet > 0 ? new ICommand *[aPocet] : NULL;
		copy(zdroj);
	}
	return *this;
}

TextMenu::~TextMenu()
{
	for (int i = 0; i < aPocet && aPrikazy[i]; i++)
	{
		delete aPrikazy[i];
	}
	delete[] aPrikazy;
}

void TextMenu::start(){
	do
	{
		zobraz();
	} while (spracujPrikaz());
}

bool TextMenu::pridajPrikaz(ICommand *prikaz){
	for (int i = 0; i < aPocet; i++)
	{
		if (!aPrikazy[i]){	//ak je prikaz nulovy - if(aPrikazy == NULL)
			aPrikazy[i] = prikaz;
			return true;
		}
	}
	return false;
}

bool TextMenu::pridajPrikaz(const char *text, int id, IReceiver *reciever, char hotkey){
	return pridajPrikaz(new TextCommand(text, aVystup, id, hotkey));
}

bool TextMenu::pridajKoniecCommand(IReceiver *receiver){
	return pridajPrikaz(new KoniecCommand(aVystup, receiver));
}

bool TextMenu::pridajHSeparator(){
	return pridajPrikaz(new HSeparator(aVystup));
}

bool TextMenu::pridajVSeparator(){
	return pridajPrikaz(new VSeparator(aVystup));
}

void TextMenu::zobraz(){
	int i = 0;
	while (aPrikazy[i] && i < aPocet){
		aPrikazy[i]->zobraz();
		i++;
	}
}

bool TextMenu::spracujPrikaz(){
	char vstup = aVstup.dajVstup();

	for (int i = 0; i < aPocet && aPrikazy[i]; i++)
	{
		if (aPrikazy[i]->jeHotKey(vstup))
			return aPrikazy[i]->execute();
	}
	return true;
}