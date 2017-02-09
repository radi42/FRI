#include <iostream>

using namespace std;

void vymena1(int a, int b){
	int pom = a; a = b; b = pom;
}

void vymena2(int *a, int *b){
	int pom = *a; *a = *b; *b = pom;
}

void vymena3(int &a, int &b){
	int pom = a; a = b; b = pom;
}

int main(){
	int a = 1, b = 2;
	vymena1(a, b);
	cout << "Hodnota a = " << a << "	Hodnota b = " << b << endl;

	vymena2(&a, &b);
	cout << "Hodnota a = " << a << "	Hodnota b = " << b << endl;

	vymena3(a, b);
	cout << "Hodnota a = " << a << "	Hodnota b = " << b << endl;

}