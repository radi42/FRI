#pragma once
#include "Vykreslovac.h"
#include "Predmet.h"

class HraciaPlocha :
	public Vykreslovac
{
private:
	Predmet *aPredmet1;
	Predmet *aPredmet2;
	Predmet *aPredmet3;

public:
	HraciaPlocha(int x, int y, int h, int v);
	~HraciaPlocha();

	virtual void VykresliSa(SDL_Surface *surface);
	void Posun();

	bool Zasah(int px, int py);
};
