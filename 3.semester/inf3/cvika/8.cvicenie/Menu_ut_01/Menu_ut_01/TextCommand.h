#pragma once
#include <string>

#include "ICommand.h"
#include "IReceiver.h"
#include "IVystup.h"

using namespace std;

class TextCommand :	public ICommand
{
private:
	string aText;
	int aId;
	char aHotKey;
	IReceiver *aReceiver;
	IVystup &aVystup;

public:
	TextCommand(string text, IVystup &vystup,
		int id = NO_ID, char hotKey = '\0', 
		IReceiver *receiver = NULL);

	virtual bool execute();
	virtual int id();
	virtual void zobraz();
	virtual bool jeHotKey(char key);
	virtual ICommand *kopiruj(){
		return new TextCommand(*this);		//urob kopiu sameho seba
	}
};

