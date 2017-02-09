#pragma once

#include <string>

using namespace std;

class Student
{
private:
	string aMeno;
	string aPriezvisko;
	string aSkola;

public:

	Student(const char *meno, const char *priezvisko, const char *skola)
		:aMeno(meno), aPriezvisko(priezvisko), aSkola(skola)
	{
	}

	string meno(){ return aMeno; }
	string priezvisko(){ return aPriezvisko; }
	string skola(){ return aSkola; }

	~Student()
	{
	}
};

