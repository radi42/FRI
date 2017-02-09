#pragma once

#include "TextCommand.h"
#include "IVystup.h"

class KoniecCommand :
	public TextCommand{

public:
	KoniecCommand(IVystup &vystup, IReceiver *receiver = NULL);
	virtual bool execute();
};