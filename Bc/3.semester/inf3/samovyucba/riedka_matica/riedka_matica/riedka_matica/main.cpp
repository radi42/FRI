#include <iostream>

int main(){
	int x[5];
	int *b[4];
	int cislo;

	b[3] = x;
	b[3][2] = 5;

	cislo = b[3][2];
	std::cout << "Hodnota v na pozicii [3, 2] je " << cislo << std::endl;

	return 0;
}