#pragma once
#include <SDL.h>
#include "HraciaPlocha.h"

class Hra
{
private:
	HraciaPlocha *aPlocha;
	SDL_Surface *aScreen;
	int aBody;
	void Run();
	void ZobrazBody();

public:
	Hra();
	~Hra();

	void Start();
};

