#include <string>
#include <iostream>

using namespace std;

class Zapisovac {
public:
	void vypis(int paVstup);
	void vypis(long paVstup);
	void vypis(string paVstup);
};

void Zapisovac::vypis(int paVstup) {
	cout << paVstup << endl;
}

void Zapisovac::vypis(long paVstup) {
	cout << paVstup << endl;
}

void Zapisovac::vypis(string paVstup){
	cout << paVstup << endl;
}

int main() {
	Zapisovac zapis;
	zapis.vypis(123);
	zapis.vypis(900000);
	zapis.vypis("abcdefg");
}