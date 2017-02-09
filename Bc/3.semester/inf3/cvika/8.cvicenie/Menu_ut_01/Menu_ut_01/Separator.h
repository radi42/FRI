#pragma once
#include "TextCommand.h"

class VSeparator : public TextCommand
{
public:

	VSeparator(IVystup &vystup) 
		: TextCommand("------------------", vystup )
	{
	}

	virtual ICommand *kopiruj(){
		return new VSeparator(*this);		//urob kopiu sameho seba
	}
};

class HSeparator : public TextCommand
{
public:

	HSeparator(IVystup &vystup)
		: TextCommand(" | ", vystup)
	{
	}

	virtual ICommand *kopiruj(){
		return new HSeparator(*this);		//urob kopiu sameho seba
	}
};
