#include "SDL.h"
#include "SDL_ttf.h"

#ifndef INFINITE_PONG_SERVER_H_INCLUDED
#define INFINITE_PONG_SERVER_H_INCLUDED

typedef struct player Player;
typedef struct ball Ball;
typedef struct game Game;
typedef struct init Init;
typedef struct message Message;

void doRender(  SDL_Renderer *renderer, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball,
                TTF_Font *pa_scoreboard_font, char *pa_scoreboard_text);
void printToTerminal(char *pa_retazec, int size);
int processEvents( SDL_Window *window, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball, Game *pa_pong,
                        char pa_client_key_pressed);

#endif // INFINITE_PONG_SERVER_H_INCLUDED
