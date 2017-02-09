#pragma once

#include <string>

using namespace std;

class IVystup{
public:
	virtual void zobraz(string &text) = 0;	//pristupujeme k textu nepriamo
};

