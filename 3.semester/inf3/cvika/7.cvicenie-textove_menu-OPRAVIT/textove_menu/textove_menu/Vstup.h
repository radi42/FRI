#pragma once

#include <conio.h>

#include "IVstup.h"
class Vstup :
	public IVstup
{
public:
	virtual char Vstup::dajVstup(){
		return getch();
	}
};

