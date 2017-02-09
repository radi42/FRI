#pragma once
#include "IReceiver.h"
#include "IVstup.h"
#include "IVystup.h"
#include "TextMenu.h"
#include "Student.h"

class Aplikacia :
	public IReceiver
{
private:
	IVstup *aVstup;
	IVystup *aVystup;
	Student *aStudent;
	TextMenu *aMenu;

	virtual void action(int id);

public:
	void start(){
		if (aMenu)
			aMenu->start();
	}

	Aplikacia();
	~Aplikacia();
};

