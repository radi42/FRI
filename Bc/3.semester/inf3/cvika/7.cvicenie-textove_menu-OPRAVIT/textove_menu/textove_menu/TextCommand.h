#pragma once

#include <string>

#include "ICommand.h"
#include "IReceiver.h"
#include "IVystup.h"

using namespace std;

class TextCommand :
	public ICommand{

private:
	int aId = 0;
	string aText;
	char aHotKey;
	IReceiver *aReceiver;
	IVystup &aVystup;

public:
	TextCommand(string text, IVystup &vystup, int id = NO_ID, char hotkey = '\0', IReceiver *receiver = NULL);
	
	virtual bool execute();
	virtual int id();
	virtual void zobraz();
	virtual bool jeHotKey(char key);
};

