#pragma once

const int NO_ID = -1;	//identifikator prikazu, ktory nic nevykona
const int KONIEC_ID = 0;

class ICommand{
public:
	virtual bool execute() = 0;
	virtual int id() = 0;
	virtual void zobraz() = 0;
	virtual bool jeHotKey(char key) = 0;
};