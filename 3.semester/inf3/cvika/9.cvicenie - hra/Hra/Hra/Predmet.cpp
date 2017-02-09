#include "time.h"
#include "Predmet.h"


//Predmet::Predmet(int x, int y, int h, int v, const char *cestaObrazok)
//:Vykreslovac(x, y, h, v)
//{
//	aObrazok = SDL_LoadBMP(cestaObrazok);
//	srand(time(NULL));
//	aDx = (rand() % 5) + 1;
//	aDy = (rand() % 5) + 1;
//}

Predmet::Predmet(int h, int v, int xPlocha, int yPlocha, int hPlocha, int vPlocha, const char *cestaObrazok)
:Vykreslovac(0, 0, h, v){
	aObrazok = SDL_LoadBMP(cestaObrazok);
	srand(time(NULL));
	aX = (rand() % (hPlocha - aH - xPlocha)) + xPlocha;	//(random od 0 do 700-65-10 =625) + 10 tj od 10 po 635
	aY = (rand() % (vPlocha - aV - yPlocha)) + yPlocha;
	aDx = (rand() % 3) - (rand() % 3);
	aDy = (rand() % 3) - (rand() % 3);
}


Predmet::~Predmet()
{
}

void Predmet::VykresliSa(SDL_Surface *surface){
	SDL_Rect rectObrazok = { 0, 0, aH, aV };
	SDL_Rect rectCiel = { aX, aY, 0, 0 };
	SDL_BlitSurface(aObrazok, &rectObrazok, surface, &rectCiel);
}

void Predmet::PohniSa(int paX, int paY, int paSirka, int paVyska){
	if (aX <= paX || aX + aV >= paX + paSirka){
		aDx = -aDx;
	}
	else if (aY <= paY || aY + aH >= paY + paVyska){
		aDy = -aDy;
	}

	//aX += aDx;
	aY += aDy;
}

bool Predmet::Zasah(int px, int py){

	return aX < px && px <= aX + aH && aY <= py && py <= aY + aV;
}