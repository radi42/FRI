#pragma once

const int NO_ID = -1;
const int USER_ID = 1;
const int KONIEC_ID = 0;


class ICommand
{
public:

	virtual bool execute() = 0;
	virtual int id() = 0;
	virtual void zobraz() = 0;
	virtual bool jeHotKey(char key) = 0;

	virtual ICommand *kopiruj() = 0;
};

