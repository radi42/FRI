#pragma once
#include <SDL.h>

class Vykreslovac
{
protected:
	int aX, aY, aH, aV;
public:
	Vykreslovac(int aX,int aY,int aH,int aV);
	~Vykreslovac();

	int GetX() const { return aX; }
	int GetY() const { return aY; }
	int GetH() const { return aH; }
	int GetV() const { return aV; }

	virtual void VykresliSa(SDL_Surface *surface) = 0;
};

