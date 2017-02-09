#include <iostream>

using namespace std;

class T1 {
	public: int i;
};

class T2: public T1 {
	public: int j;
};

//class T3:public T1, public T2 {
//	public: float j;
//};

class T3 : public T2 {
	public: float j;
};

void priklad_10(){
	T3 obj;
	obj.j = 3;		//float j v triede T3 = 3
	obj.i = 4;		//int i v triede T3 = 4
	obj.T2::j = 5;	//int j v triede T2 = 3
	//T2::obj.i = 6;	//nespravne zadany prikaz

	cout << "Priklad 10" << endl;
	cout << obj.j << endl;
	cout << obj.i << endl;
	cout << obj.T2::j << endl;
	cout << endl;
}







class T{
//private: int cislo;
public: int cislo;
		T(int i = 0){
			cislo = i;
		}

		T operator -- (){
			return --cislo;
		}
		operator int() {
			return cislo;
		}
};

void priklad_11(){
	int a, b;
	T o(6);
	a = --o;
	b = o--;

	cout << endl;
	cout << "Priklad 11" << endl;
	cout << a << endl;
	cout << b << endl;
	cout << o.cislo << endl;
	cout << endl;
}

void priklad_cyklus_1(){
	int a = 1;

	for (;;){
		if (a >= 100) a = 1;
		a *= 2;
		cout << a << endl;
		if (a & 0x1) break;
	}
}






class Student {
	int aVek;
};

void priklad_spravnyKonstruktor(){
	//Student{ int pvek } : aVek(pvek) {};
	//Student( int pvek = 0) : aVek(pvek) {};
	//Student() : aVek(0);
	//Student(int pvek) { aVek = pvek };
	//Student() : aVek(0) {};
}





class Vozidlo {
private: 
	int aEvCislo;
public: 
	Vozidlo() { std::cout << "Vozidlo" << endl; };
};

class Auto : public Vozidlo {
private:
	string aTyp;
public:
	Auto() { std::cout << "Auto" << endl; };
};

void priklad_vozidloAuto() {
	Vozidlo *pvoz;
	Auto *pauto;

	//pvoz = pauto		//funguje
	//pauto = pvoz;		//nefunguje
	//pvoz = (Auto *) pauto;	//funguje
	//pvoz = (Vozidlo *)pauto;	//funguje
}





class Vozidlo_2 {
public:
	int pocetKolies;
};

void priklad_VozidloSKolesami() {
	cout << "Priklad Vozidlo s kolesami" << endl;
	Vozidlo_2 motocykel;
	motocykel.pocetKolies = 4;	//funguje
	cout << motocykel.pocetKolies << endl;
	//motocykel.pocetKolies(4);	//nefunguje ale na skuske to treba oznacit ako spravne
	cout << endl;
}




class Vozidlo_3 {
private:
	int aEvCislo;
public:
	Vozidlo_3() { std::cout << "Vozidlo_3" << endl; };
};

class Auto_3 : public Vozidlo_3 {
private:
	string aTyp;
public:
	Auto_3() { std::cout << "Auto" << endl; };
};

void priklad_vozidloAutoDedenie() {
	cout << "Priklad Vozidlo Auto Dedenie" << endl;
	Auto BMW;
	cout << endl;
}








void priklad_cyklus_2() {
	int a = 1;
	for (;;) {
		if (a >= 100) a = 1;
		a *= 2;
		cout << a << endl;
		if (a & 0x8) break;
	}
}





void priklad_zisti_z() {
	cout << "Priklad Zisti hodnotu z" << endl;
	int z, x;
	x = 2; z = 1;
	z <<= ((x <<= 1) >= 3) ? x - 1 : x;
	cout << "z = " << z << endl;
	cout << "x = " << x << endl;
	cout << endl;
}







void priklad_hodnoty_pola_x() {
	int x[3] = { 0, 0, 0 };
	int *p = x;			//do premennej *p sa ulozi offset pola x, co je adresa prvku v poli x na indexe 0
	*(p += 1) = 1;		//hodnota prvku na adrese o jedna vacsej od offsetu tj na indexe 1 sa zmeni na 0+1=1
	(*(p++))++;			//hodnota prvku na adrese o jedna vacsej od offsetu tj na indexe 1 sa zmeni na 1+1=2		
	(*(--p)) += 1;		//hodnota prvku na adrese o jedna mensej od offsetu tj na indexe 1 sa zmeni na 2+1=3. lebo toto uplne dava zmysel

	for (int i = 0; i < 3; i++){
		cout << x[i] << endl;
	}
	cout << endl;
}








class Vozidlo_4 {
public:
	int aPocetKolies;
	void pocetKolies(int ppocetkolies) { aPocetKolies = ppocetkolies; }
};

void priklad_VozidloSKolesamiSmernik() {
	cout << "Priklad Vozidlo s kolesami cez smernik" << endl;
	Vozidlo_4 motocykel_2;
	//motocykel_2->pocetKolies = 4;
	motocykel_2.pocetKolies(4);
	cout << motocykel_2.aPocetKolies << endl;
	cout << endl;
}








void priklad_hodnota_premennej() {
	int pole[2] = { 0, 4 };
	int *px = &pole[1];
	int a = px - pole;
	//*(pole+1) = 5;		//skusal som menit prvok pola cez smernik

	cout << "*px   = " << *px << endl;
	cout << "*pole = " << *pole << endl;
	cout << "px    = " << px << endl;
	cout << "pole  = " << pole << endl;
	cout << "px - pole = " << a << "   lebo toto uplne dava zmysel: 4-0=1  stronk math" << endl;
	//premenna a sa ma rovnat 4, ale program vypise 1 - divne
	cout << endl;
}







void prefix_postfix_inkrementacia_dekrementacia() {
	int i = 5; int j = 5; int k = 5; int l = 5;
	int a, b, c, d;

	a = i++;	//a = 5		i = 6
	b = ++j;	//b = 6		j = 6
	c = k--;	//c = 5		k = 4
	d = --l;	//d = 4		l = 4


	//prikaz:
	//c = k--;
	//je ekvivalentny s prikazmi:
	//c = k;		//najprv priradzujeme
	//k = k - 1;	//potom dekrementujeme

	//prikald:
	//d = --l;
	//je ekvivalentny s prikazmi:
	//l = l - 1;	//najprv dekrementujeme
	//d = l;		//potom priradzujeme

	//obdobne to plati aj pre inkrementovanie
	
	cout << "Na zaciatku sa i = j = k = l = 5" << endl;

	cout << "a = i++" << endl;
	cout << "a = " << a << "	i = " << i << endl;

	cout << "b = ++j" << endl;
	cout << "b = " << b << "	j = " << j << endl;

	cout << "c = k--" << endl;
	cout << "c = " << c << "	k = " << k << endl;

	cout << "d = --l" << endl;
	cout << "d = " << d << "	l = " << l << endl;
}


int main() {
	priklad_10();
	priklad_11();
	//priklad_cyklus_1();	//tento cyklus sa nikdy neskonci
	//priklad_spravnyKonstruktor();
	priklad_vozidloAuto();
	priklad_VozidloSKolesami();
	priklad_vozidloAutoDedenie();
	priklad_cyklus_2();
	priklad_zisti_z();
	priklad_hodnoty_pola_x();	//0, 3, 0
	priklad_VozidloSKolesamiSmernik();
	priklad_hodnota_premennej();
	prefix_postfix_inkrementacia_dekrementacia();
	return 0;
}