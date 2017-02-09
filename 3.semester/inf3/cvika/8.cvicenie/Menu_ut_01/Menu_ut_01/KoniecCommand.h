#pragma once
#include "TextCommand.h"


class KoniecCommand :	public TextCommand
{
public:

	KoniecCommand(IVystup &vystup, IReceiver *receiver = NULL) 
		: TextCommand("[K]oniec", vystup, KONIEC_ID, 'k', receiver)
	{
	} 

	virtual bool execute()
	{
		return !TextCommand::execute();
	}

	virtual ICommand *kopiruj(){
		return new KoniecCommand(*this);		//urob kopiu sameho seba
	}
};

