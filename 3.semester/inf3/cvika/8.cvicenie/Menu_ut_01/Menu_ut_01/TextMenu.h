#pragma once
#include "ICommand.h"
#include "IVystup.h"
#include "IVstup.h"
#include "IReceiver.h"


class TextMenu
{
private:
	ICommand **aPrikazy;
	unsigned int aPocet;
	IVstup &aVstup;
	IVystup &aVystup;

	bool pridajPrikaz(ICommand *prikaz);
	void zobraz();
	bool spracujPrikaz();

	void copy(const TextMenu &zdroj);				//kopiruj jedno menu do noveho menu

public:
	TextMenu(unsigned pocet, IVstup &vstup, IVystup &vystup);
	TextMenu(const TextMenu &zdroj);				//kopirovaci konstruktor
	TextMenu &operator = (const TextMenu &zdroj);	//operator priradenia
	~TextMenu();
	
	void start();
	bool pridajPrikaz(const char *text, int id, IReceiver *reciever, char hotkey);	//text - vypise sa na obrazovku
	bool pridajKoniecCommand(IReceiver *receiver = NULL);
	bool pridajHSeparator();
	bool pridajVSeparator();
};
