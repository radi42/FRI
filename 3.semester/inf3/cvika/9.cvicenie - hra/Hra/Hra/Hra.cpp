#include "Hra.h"
#include <sstream>

const int INTERVAL = 1080;

//Hra::Hra()
//:aPlocha(new HraciaPlocha(10, 10, 700, 500))
//{
//}
Hra::Hra() : aPlocha(new HraciaPlocha(10, 10, 700, 500)) {}


Hra::~Hra()
{
	delete aPlocha;
}

void Hra::Run(){
	aBody = 0;
	int pozadie = SDL_MapRGB(aScreen->format, 0, 0, 127);
	SDL_Event event;
	int t1 = SDL_GetTicks();
	while (true){
		while (SDL_PollEvent(&event)){
			switch (event.type){
			case SDL_MOUSEBUTTONDOWN:
				if (event.button.button == SDL_BUTTON_LEFT){
					int x = event.button.x;
					int y = event.button.y;
					if (aPlocha->Zasah(x, y)){
						aBody++;
					}
					else{
						aBody--;
					}
				}
				break;
			case SDL_KEYDOWN:
				if (event.key.keysym.sym == SDLK_ESCAPE)
					return;
			case SDL_QUIT:
				return;
			}
		}
		int t2 = SDL_GetTicks();
		if (t2 - t1 > INTERVAL){
			aPlocha->Posun();
			t1 = t2;
		}
		this->ZobrazBody();
		SDL_FillRect(aScreen, 0, pozadie);
		aPlocha->VykresliSa(aScreen);
		SDL_UpdateRect(aScreen, 0, 0, 0, 0);
		aPlocha->Posun();
	}
}

void Hra::Start(){
	SDL_Init(SDL_INIT_EVERYTHING);
	aScreen = SDL_SetVideoMode(800, 600, 32, SDL_SWSURFACE);
	if (aScreen == NULL){
		fprintf(stderr, "Problem: %s\n", SDL_GetError());
		//uvolnit SDL kniznicu
		return;
	}
	this->Run();

	//upratanie
	SDL_FreeSurface(aScreen);
	SDL_Quit;
}

void Hra::ZobrazBody(){
	std::ostringstream buffer;
	buffer << "Pocet bodov: " << aBody;
	SDL_WM_SetCaption(buffer.str().c_str(), NULL);
}