#include <iostream>
#include <string>
#include <stdio.h>

using namespace std;

//informacie o cloveku
typedef struct{
	string meno;
	string priezvisko;
	int vek;
} TVizitka;

int main(){
	TVizitka clovek;
	clovek.meno = "Karol";
	clovek.priezvisko = "Polak";
	clovek.vek = 60;
	
	cout << clovek.meno << " "
		<< clovek.priezvisko<< " "
		<< clovek.vek << endl;

	int pole[3];
	for (int i = 0; i < 3; i++)
	{
		pole[i] = i + 1;
		cout << pole[i] << endl;
	}

	TVizitka ludia[3];

	clovek.meno = "Andrej";
	clovek.priezvisko = "Sisila";
	clovek.vek = 20;
	ludia[0] = clovek;
	//printf("%10s %10s %4s", ludia[0].meno, ludia[0].priezvisko, ludia[0].vek);
	//printf("%-10s \n", ludia[0].meno);
	
	clovek.meno = "Jan";
	clovek.priezvisko = "Hudec";
	clovek.vek = 22;
	ludia[1] = clovek;

	clovek.meno = "Dobroslav";
	clovek.priezvisko = "Grygar";
	clovek.vek = 21;
	ludia[2] = clovek;

	string meno, priezvisko, vek_s;
	int vek;
	for (int i = 0; i < 3; i++)
	{
		meno = ludia[i].meno;
		priezvisko = ludia[i].priezvisko;
		vek = ludia[i].vek;
		vek_s = to_string(ludia[i].vek);	//konvertovanie int na string metodou to_string(parameter je int hodnota)

		//printf - rovnako ako v Jave funguje ako formatovany vypis; pri formatovanom vypisani stringovych premennych treba pouzit metodu c_str()
		printf("%-10s %-10s %-4s %-4d\n", ludia[i].meno.c_str(), ludia[i].priezvisko.c_str(), vek_s.c_str(), ludia[i].vek);
	}
		
	return 0;
}