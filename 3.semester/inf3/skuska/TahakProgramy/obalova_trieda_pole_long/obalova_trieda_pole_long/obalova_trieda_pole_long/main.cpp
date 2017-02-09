#include <iostream>

using namespace std;

class Obal {
private:
	long *aPole;

public:
	Obal(int paVelkost) {
		cout << "alokujem pole v dynamickej pamati" << endl;
		aPole = new long[paVelkost];
	}

	~Obal() {
		cout << "dealokujem pole z dynamickej pamate" << endl;
		delete [] aPole;
	}

	operator long *() {
		return aPole;
	}
};

int main() {
	Obal aPole(20);
	aPole[1] = 98765;
	cout << aPole[1] << endl;
	int prem(5);
	return 0;
}