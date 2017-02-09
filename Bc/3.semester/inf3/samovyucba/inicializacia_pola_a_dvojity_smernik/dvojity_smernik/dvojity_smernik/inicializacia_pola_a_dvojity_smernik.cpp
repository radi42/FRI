#pragma once

#include <iostream>

using namespace std;

char *Den[] = {
	"Neznamy den",
	"Pondelok",
	"Utorok",
	"Streda",
	"Stvrtok",
	"Piatok",
	"Sobota",
	"Nedela"
};

int main(){
	putchar(Den[1][3]);		//vypise 'd'
	cout << endl;
	putchar(Den[7][2]);		//vypise 'd'
	cout << endl;

	char **DvojDen = Den;
	putchar(DvojDen[2][3]);	//vypise 'r'
	cout << endl;

	return 0;
}
