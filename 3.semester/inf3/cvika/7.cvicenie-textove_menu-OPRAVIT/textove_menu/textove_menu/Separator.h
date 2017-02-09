#pragma once

#include "TextCommand.h"

class VSeparator : public TextCommand{

public:
	VSeparator(IVystup &vystup)
		: TextCommand("______________________", vystup)
	{

	}
};

class HSeparator : public TextCommand{

public:
	HSeparator(IVystup &vystup)
		: TextCommand("|", vystup)
	{

	}
};

