#include "SDL.h"
#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

typedef struct
{
    int x, y;
    int width, height;
    int score;
} Player;

typedef struct
{
    int x, y;
    int width, height;
    int dx, dy;
    int direction;
} Ball;

typedef struct
{
    int window_width, window_height;
} Game;

typedef struct
{
    int player1x, player1y, player2x, player2y, ballx, bally;
    int message;
} Message;

// Konvertuje nazov smeru na cislo smeru
int direction_to_int(const char *pa_direction_name)
{
    if(strcmp(pa_direction_name, "STOP") == 0 )
    {
        return 0;
    }

    if(strcmp(pa_direction_name, "VLAVO") == 0 )
    {
        return 1;
    }

    if(strcmp(pa_direction_name, "VLAVO HORE") == 0 )
    {
        return 2;
    }

    if(strcmp(pa_direction_name, "VLAVO DOLE") == 0 )
    {
        return 3;
    }

    if(strcmp(pa_direction_name, "VPRAVO") == 0 )
    {
        return 4;
    }

    if(strcmp(pa_direction_name, "VPRAVO HORE") == 0 )
    {
        return 5;
    }

    if(strcmp(pa_direction_name, "VPRAVO DOLE") == 0 )
    {
        return 6;
    }

    return 0;     // Ak smer nie je rozpoznany, lopticka sa zastavi
}

// Nastavuje nahodnu x-ovu a y-ovu rychlost (smernicu) pre lopticku
void set_random_speed_to_ball(Ball *pa_ball)
{
// TODO - urobit pohyb lopticky na nahodnu smernicu
//  pa_ball->dx = rand() % 3 + 1;
//  pa_ball->dy = rand() % 3 + 1;

    // pre jednoduchost budu smernice dx a dy rovne 1, aby som sa vyhol dalsim podmienkam
    pa_ball->dx = 1;
    pa_ball->dy = 1;
}

int processEvents(SDL_Window *window, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball, Game *pa_pong)
{
    SDL_Event event;
    int done = 0;     // program uz skoncil? 0 = nie, 1 = ano

    while(SDL_PollEvent(&event))
    {
        switch(event.type)
        {
        case SDL_WINDOWEVENT_CLOSE:
        {
            if(window)
            {
                SDL_DestroyWindow(window);
                window = NULL;
                done = 1;
            }
        }
        break;
        case SDL_KEYDOWN:
        {
            switch(event.key.keysym.sym)
            {
            case SDLK_ESCAPE:
                done = 1;
                break;
            }
        }
        break;
        case SDL_QUIT:
            //quit out of the game
            done = 1;
            break;
        }
    }

    // OVLADANIE HRY

    const Uint8 *state = SDL_GetKeyboardState(NULL);
    int difference = 5;  // pocet pixelov, o ktore sa plosina hraca pohne na jedno stlacenie klavesy
    // Ovladanie pre prveho hraca
    if(state[SDL_SCANCODE_W])
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_1->y - difference > 0)
            pa_player_1->y -= difference;
        else
            pa_player_1->y = 0;
    }

    if(state[SDL_SCANCODE_S])
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_1->y < pa_pong->window_height - pa_player_1->height)
            pa_player_1->y += difference;
        else
            pa_player_1->y = pa_pong->window_height - pa_player_1->height;
    }

    // Ovladanie pre druheho hraca
    if(state[SDL_SCANCODE_UP])
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_2->y - difference > 0)
            pa_player_2->y -= difference;
        else
            pa_player_2->y = 0;
    }
    if(state[SDL_SCANCODE_DOWN])
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_2->y < pa_pong->window_height - pa_player_2->height)
            pa_player_2->y += difference;
        else
            pa_player_2->y = pa_pong->window_height - pa_player_2->height;
    }

    // POCIATOCNY STAV
    // Ak sa lopticka nehybe, pohni nou nahodnym smerom
    if(pa_ball->direction == direction_to_int("STOP"))
    {
        srand(time(NULL));
//    pa_ball->direction = rand() % 6 + 1;
        pa_ball->direction = direction_to_int("VPRAVO HORE");
    }

    // LOGIKA ODRAZANIA LOPTICKY OD STIEN A OD HRACOV
    // Odrazom lopticky od LUBOVOLNEHO OBJEKTU sa jej vzdy nastavi nahodna rychlost (smernica)

    // Odraz lopticku od plosiny hraca 1
    if((pa_ball->x == pa_player_1->x + pa_player_1->width
            || pa_ball->x - pa_ball->dx < pa_player_1->x + pa_player_1->width
       )
            && pa_ball->y >= pa_player_1->y && pa_ball->y <= pa_player_1->y + pa_player_1->height)
    {
        // bounced
//    pa_ball->x = pa_player_1->x + pa_player_1->width;
        pa_ball->direction = rand() % 3 + 4;
        set_random_speed_to_ball(pa_ball);
    }

    // Odraz lopticku od plosiny hraca 2
    if(pa_ball->x == pa_player_2->x - pa_ball->width &&
            pa_ball->y >= pa_player_2->y && pa_ball->y <= pa_player_2->y + pa_player_2->height)
    {
        pa_ball->direction = rand() % 3 + 1;
        set_random_speed_to_ball(pa_ball);
    }

    // Odrazanie - Horny okraj
    // Ak lopticka narazila na horny okraj a isla vpravo hore,
    // potom sa odrazi vpravo dole, inak pojde vlavo dole
    if(pa_ball->y == 0)
    {
        set_random_speed_to_ball(pa_ball);

        if(pa_ball->direction == direction_to_int("VPRAVO HORE"))
            pa_ball->direction = direction_to_int("VPRAVO DOLE");
        if(pa_ball->direction == direction_to_int("VLAVO HORE"))
            pa_ball->direction = direction_to_int("VLAVO DOLE");
    }

    // Odrazanie - Dolny okraj
    // Ak lopticka narazila na dolny okraj a isla vpravo dole,
    // potom sa odrazi vpravo hore, inak pojde vlavo hore
    if(pa_ball->y == pa_pong->window_height - pa_ball->height)
    {
        set_random_speed_to_ball(pa_ball);

        if(pa_ball->direction == direction_to_int("VPRAVO DOLE"))
            pa_ball->direction = direction_to_int("VPRAVO HORE");
        if(pa_ball->direction == direction_to_int("VLAVO DOLE"))
            pa_ball->direction = direction_to_int("VLAVO HORE");
    }

    // Odrazanie - Lavy okraj
    // Ak lopticka narazila na lavy okraj a isla vlavo dole, potom sa odrazi vpravo dole
    // Ak ide vlavo hore, potom sa odrazi vpravo hore
    // Ak ide vlavo, potom sa odrazi nahodne vpravo, vpravo hore alebo vpravo dole
    // Zaroven skoruje hrac 2
    if(pa_ball->x == 0)
    {
        set_random_speed_to_ball(pa_ball);

        if(pa_ball->direction == direction_to_int("VLAVO DOLE"))
            pa_ball->direction = direction_to_int("VPRAVO DOLE");
        if(pa_ball->direction == direction_to_int("VLAVO HORE"))
            pa_ball->direction = direction_to_int("VPRAVO HORE");
        if(pa_ball->direction == direction_to_int("VLAVO"))
            pa_ball->direction = rand() % 3 + 4;

        pa_player_2->score++;
    }

    // Odrazanie - Pravy okraj
    // Ak lopticka narazila na pravy okraj a isla vpravo dole, potom sa odrazi vlavo dole
    // Ak ide vlavo hore, potom sa odrazi vpravo hore
    // Ak ide vpravo, potom sa odrazi nahodne vlavo, vlavo hore alebo vlavo dole
    // Zaroven skoruje hrac 1
    if(pa_ball->x == pa_pong->window_width- pa_ball->width)
    {
        set_random_speed_to_ball(pa_ball);

        if(pa_ball->direction == direction_to_int("VPRAVO DOLE"))
            pa_ball->direction = direction_to_int("VLAVO DOLE");
        if(pa_ball->direction == direction_to_int("VPRAVO HORE"))
            pa_ball->direction = direction_to_int("VLAVO HORE");
        if(pa_ball->direction == direction_to_int("VPRAVO"))
            pa_ball->direction = rand() % 3 + 1;

        pa_player_1->score++;
    }

    // Nakoniec pohni loptickou
    // Zakazdym treba skontrolovat, ci lopticka nechce uniknut z hracej plochy
    char *direction_name;

    switch (pa_ball->direction)
    {
    case 0:
        direction_name = "STOP";
        break;
    case 1:
        direction_name = "VLAVO";
        if(pa_ball->x - pa_ball->dx > 0)
            pa_ball->x -= pa_ball->dx;
        else                                // narazili sme na lavu stenu
            pa_ball->x = 0;
        break;
    case 2:
        direction_name = "VLAVO HORE";
        if(pa_ball->x - pa_ball->dx > 0)
            pa_ball->x -= pa_ball->dx;
        else                                // narazili sme na lavu stenu
            pa_ball->x = 0;

        if(pa_ball->y - pa_ball->dy > 0)
            pa_ball->y -= pa_ball->dy;
        else                                // narazili sme na hornu stenu
            pa_ball->y = 0;

        break;
    case 3:
        direction_name = "VLAVO DOLE";
        if(pa_ball->x - pa_ball->dx > 0)
            pa_ball->x -= pa_ball->dx;
        else                                // narazili sme na lavu stenu
            pa_ball->x = 0;

        if(pa_ball->y + pa_ball->dy < pa_pong->window_height - pa_ball->height)
            pa_ball->y += pa_ball->dy;
        else                                // narazili sme na dolnu stenu
            pa_ball->y = pa_pong->window_height - pa_ball->height;

        break;
    case 4:
        direction_name = "VPRAVO";

        if(pa_ball->x + pa_ball->dx  + pa_ball->width < pa_pong->window_width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;
        break;
    case 5:
        direction_name = "VPRAVO HORE";
        if(pa_ball->x + pa_ball->dx < pa_pong->window_width - pa_ball->width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;

        if(pa_ball->y - pa_ball->dy > 0)
            pa_ball->y -= pa_ball->dy;
        else                                // narazili sme na hornu stenu
            pa_ball->y = 0;
        break;
    case 6:
        direction_name = "VPRAVO DOLE";
        if(pa_ball->x + pa_ball->dx < pa_pong->window_width - pa_ball->width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;

        if(pa_ball->y + pa_ball->dy < pa_pong->window_height - pa_ball->height)
            pa_ball->y += pa_ball->dy;
        else                                // narazili sme na dolnu stenu
            pa_ball->y = pa_pong->window_height - pa_ball->height;

        break;
    default:
        direction_name = "STOP - ina hodnota";
        break;
    }

    // Kontrolny vypis stavu hry
//    printf("ball: %d, %d :: ball speed: %d, %d -> [%d] %s :: P1: %d, %d :: P2: %d, %d :: Score: %d:%d\n",
//           pa_ball->x, pa_ball->y,
//           pa_ball->dx, pa_ball->dy,
//           pa_ball->direction, direction_name,
//           pa_player_1->x, pa_player_1->y,
//           pa_player_2->x, pa_player_2->y,
//           pa_player_1->score, pa_player_2->score);

    return done;
}

void doRender(SDL_Renderer *renderer, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball)
{
    //set the drawing color to black
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

    //Clear the screen (to black)
    SDL_RenderClear(renderer);

    //set the drawing color to white
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);

    SDL_Rect bumper_1 = { pa_player_1->x, pa_player_1->y, pa_player_1->width, pa_player_1->height };
    SDL_RenderFillRect(renderer, &bumper_1);

    SDL_Rect bumper_2 = { pa_player_2->x, pa_player_2->y, pa_player_2->width, pa_player_1->height };
    SDL_RenderFillRect(renderer, &bumper_2);

    SDL_Rect ball = { pa_ball->x, pa_ball->y, pa_ball->width, pa_ball->height };
    SDL_RenderFillRect(renderer, &ball);

    //We are done drawing, "present" or show to the screen what we've drawn
    SDL_RenderPresent(renderer);
}

int main(int argc, char *argv[])
{

    // Inicializuj struktury hry
    Game pong;                            // Deklaruj hru / okno
    Player player_1, player_2;            // Deklaruj hracov
    Ball ball;                            // Deklaruj lopticku

    // Inicializuj hru / okno
    pong.window_width = 200;
    pong.window_height = 200;

    // Inicializuj hraca 1
    player_1.width = 10;
    player_1.height = 50;
    player_1.x = 5;
    player_1.y = (pong.window_height / 2) - (player_1.height / 2);
    player_1.score = 0;

    // Inicializuj hraca 2
    player_2.width = 10;
    player_2.height = 50;
    player_2.x = pong.window_width - player_2.width - 5;
    player_2.y = (pong.window_height / 2) - (player_1.height / 2);
    player_2.score = 0;

    // Inicializuj lopticku
    ball.width = ball.height = 4;
    ball.x = (pong.window_width / 2) - (ball.width / 2);
    ball.y = (pong.window_height / 2) - (ball.height / 2);
    ball.direction = direction_to_int("STOP");
    set_random_speed_to_ball(&ball);

    // otvor tcp socket
    int sockfd, newsockfd;
    socklen_t cli_len;
    struct sockaddr_in serv_addr, cli_addr;
    int n;
    char buffer[256];

    if (argc < 2)
    {
        fprintf(stderr,"usage %s port\n", argv[0]);
        return 1;
    }

    bzero((char*)&serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = INADDR_ANY;
    serv_addr.sin_port = htons(atoi(argv[1]));

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
    {
        perror("Error creating socket");
        return 1;
    }

    if (bind(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
    {
        perror("Error binding socket address");
        return 2;
    }

    listen(sockfd, 1);  // Moze sa pripojit najviac 1 hrac
    cli_len = sizeof(cli_addr);

    newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len);
    if (newsockfd < 0)
    {
        perror("ERROR on accept");
        return 3;
    }

    bzero(buffer,256);
    n = read(newsockfd, buffer, 255);
	if (n < 0)
	{
		perror("Error reading from socket");
		return 4;
	}

	const char *start = "start";
	char *message = malloc(strlen(buffer));
	strncpy(message, buffer, strlen(buffer) - 1);   //treba orezat este enter od klienta, lebo metoda fgets ulozi do buffera aj enter
//	message[strlen(buffer) - 1] = '\0';

//	printf("%s\n", message);
//	printf("%s\n", buffer);
//	printf("%s\n", start);
//	printf("%d\n", (int)strlen(message));
//	printf("%d\n", (int)strlen(buffer));
//	printf("%d\n", (int)strlen(start));
//	printf("%d\n", strcmp(message, start));
    if(strcmp(message, start) == 0)
    {
        printf("%s\n", "The game shall begin!");
        free(message);
    }
    else
    {
        return 404;
    }


    // Inicializuj SDL kniznicu
    SDL_Window *window;                    // Declare a window
    SDL_Renderer *renderer;                // Declare a renderer

    SDL_Init(SDL_INIT_VIDEO);              // Initialize SDL2

    //Create an application window with the following settings:
    window = SDL_CreateWindow("Game Window",                     // window title
                              SDL_WINDOWPOS_UNDEFINED,           // initial x position
                              SDL_WINDOWPOS_UNDEFINED,           // initial y position
                              pong.window_width,                               // width, in pixels
                              pong.window_height,                               // height, in pixels
                              0                                  // flags
                             );
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED && SDL_HINT_RENDER_VSYNC);








    // The window is open: enter program loop (see SDL_PollEvent)
    int done = 0;

    // struktura na vymenu suradnic a sprav
    Message msg;
    msg.message = done;
    //Event loop
    while(!done)
    {
        //Check for events
        done = processEvents(window, &player_1, &player_2, &ball, &pong);

        // Odosli poziciu lopticky a lavej plosiny klientovi (prava plosina patri serveru; klient ma pravu plosinu)
        msg.player1x = player_1.x;
        msg.player1y = player_1.y;
        msg.player2x = player_2.x;
        msg.player2y = player_2.y;
        msg.ballx = ball.x;
        msg.bally = ball.y;

        printf("%d;%d;%d;%d;%d;%d || sizeof(msg) = %lu || msg = %d\n", msg.player1x, msg.player1y, msg.player2x, msg.player2y, msg.ballx, msg.bally, sizeof(msg), msg.message);

        n = write(newsockfd, &msg, sizeof(msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        //Render display
        doRender(renderer, &player_1, &player_2, &ball);

        //don't burn up the CPU => spomal hru
        SDL_Delay(5);
    }

    // poslat ukoncovaciu spravu
    msg.message = done;
    n = write(newsockfd, &msg, sizeof(msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

    printf("Koniec hry\n");

    // Close and destroy the window
    SDL_DestroyWindow(window);
    SDL_DestroyRenderer(renderer);

    // Clean up
    SDL_Quit();
    return 0;
}

// klient je jeden hrac, server je druhy hrac
// z metody accept zistit id klienta
// write odoslat spravu klientovy
