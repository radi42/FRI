#pragma once
#include "Vykreslovac.h"
class Predmet :
	public Vykreslovac
{
private:
	int aDx, aDy;
	SDL_Surface *aObrazok;
public:
	//Predmet(int x, int y, int h, int v, const char *cestaObrazok);
	Predmet(int h, int v, int xPlocha, int yPlocha, int hPlocha, int vPlocha, const char *cestaObrazok);
	~Predmet();

	virtual void VykresliSa(SDL_Surface *surface);
	void PohniSa(int aX, int aY, int aH, int aV);

	bool Zasah(int px, int py);
};

