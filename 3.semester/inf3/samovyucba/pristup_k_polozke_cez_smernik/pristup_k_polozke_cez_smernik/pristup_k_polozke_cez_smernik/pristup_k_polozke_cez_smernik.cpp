#pragma once

#include <iostream>

using namespace std;

struct Student
{
	char meno[20];
	int vyska;
	int znamky[10];
};

Student  jano, kruzok[20], *ptr;   // ptr je smerník na objekt
ptr = &jano;


int main(){
	(*ptr).znamky[3] = 2;
	cout << (*ptr).znamky[3] << endl;
	cout << ptr->znamky[3] << endl;
	return 0;
}