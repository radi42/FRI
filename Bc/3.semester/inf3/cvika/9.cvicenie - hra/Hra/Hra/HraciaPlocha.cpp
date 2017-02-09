#include "HraciaPlocha.h"


/**
DOMACA ULOHA
vid subor Damaca_uloha.txt v adresari projektu
**/

HraciaPlocha::HraciaPlocha(int x, int y, int h, int v)
:Vykreslovac(x, y, h, v)
{
	aPredmet1 = new Predmet(65, 65, x, 0, h, v, "ball.bmp");
	aPredmet2 = new Predmet(65, 65, x+100, 0, h, v, "ball.bmp");
	aPredmet3 = new Predmet(65, 65, x+200, 0, h, v, "ball.bmp");
}


HraciaPlocha::~HraciaPlocha()
{
	delete aPredmet1;
	delete aPredmet2;
	delete aPredmet3;
}

void HraciaPlocha::VykresliSa(SDL_Surface *surface){
	int farbaHraciaPlocha = SDL_MapRGB(surface->format, 0, 127, 0);
	SDL_Rect rect;
	rect.x = GetX();
	rect.y = GetY();
	rect.w = aH;
	rect.h = aV;
	SDL_FillRect(surface, &rect, farbaHraciaPlocha);
	aPredmet1->VykresliSa(surface);
	aPredmet2->VykresliSa(surface);
	aPredmet3->VykresliSa(surface);
}

void HraciaPlocha::Posun(){
	aPredmet1->PohniSa(aX, aY, aH, aV);
	aPredmet2->PohniSa(aX, aY, aH, aV);
	aPredmet3->PohniSa(aX, aY, aH, aV);
}

bool HraciaPlocha::Zasah(int px, int py){
	if (aPredmet1 && aPredmet1->Zasah(px, py) || aPredmet2 && aPredmet2->Zasah(px, py) || aPredmet3 && aPredmet3->Zasah(px, py)){
		delete aPredmet1;
		aPredmet1 = new Predmet(65, 65, aX, 0, aH, aV, "ball.bmp");
		aPredmet2 = new Predmet(65, 65, aX + 100, 0, aH, aV, "ball.bmp");
		aPredmet3 = new Predmet(65, 65, aX + 200, 0, aH, aV, "ball.bmp");
		return true;
	}
	return false;
}