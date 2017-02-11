#include "SDL.h"
#include "SDL_ttf.h"
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

// Spravy posielane po sieti
// Init - inicializacna sprava - sluzi na inicializaciu parametrov hry u klienta
typedef struct
{
    int window_width, window_height, player_width, player_height, ball_width, ball_height;
} Init;

// Message - vseobecna sprava - sluzi na informovanie klienta o priebehu hry
typedef struct
{
    int player1x, player1y, player2x, player2y, ballx, bally;   // suradnice prvkov
    int gameStatus;
    char clientKeyPressed;
    int player1_score, player2_score;
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
void set_ball_speed(Ball *pa_ball)
{
// TODO - urobit pohyb lopticky na nahodnu smernicu
//  pa_ball->dx = rand() % 3 + 1;
//  pa_ball->dy = rand() % 3 + 1;

    // pre jednoduchost budu smernice dx a dy rovne 1, aby som sa vyhol dalsim podmienkam
    pa_ball->dx = 1;
    pa_ball->dy = 1;
}

int processEvents(SDL_Window *window, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball, Game *pa_pong, char pa_client_key_pressed)
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
    // Inicializuj vstup z klavesnice pre SDL
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
    if(pa_client_key_pressed == 'W')
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_2->y - difference > 0)
            pa_player_2->y -= difference;
        else
            pa_player_2->y = 0;
    }
    if(pa_client_key_pressed == 'S')
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
        pa_ball->direction = rand() % 6 + 1;
//        pa_ball->direction = direction_to_int("VPRAVO HORE");
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
        set_ball_speed(pa_ball);
    }

    // Odraz lopticku od plosiny hraca 2
    if(pa_ball->x == pa_player_2->x - pa_ball->width &&
            pa_ball->y >= pa_player_2->y && pa_ball->y <= pa_player_2->y + pa_player_2->height)
    {
        pa_ball->direction = rand() % 3 + 1;
        set_ball_speed(pa_ball);
    }

    // Odrazanie - Horny okraj
    // Ak lopticka narazila na horny okraj a isla vpravo hore,
    // potom sa odrazi vpravo dole, inak pojde vlavo dole
    if(pa_ball->y == 0)
    {
        set_ball_speed(pa_ball);

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
        set_ball_speed(pa_ball);

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
        set_ball_speed(pa_ball);

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
        set_ball_speed(pa_ball);

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
//    char *direction_name;   // pomocna premenna na vypisovanie smeru lopticky - nedolezita, sluzi iba na vypis

    switch (pa_ball->direction)
    {
    case 0:
//        direction_name = "STOP";
        break;
    case 1:
//        direction_name = "VLAVO";
        if(pa_ball->x - pa_ball->dx > 0)
            pa_ball->x -= pa_ball->dx;
        else                                // narazili sme na lavu stenu
            pa_ball->x = 0;
        break;
    case 2:
//        direction_name = "VLAVO HORE";
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
//        direction_name = "VLAVO DOLE";
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
//        direction_name = "VPRAVO";

        if(pa_ball->x + pa_ball->dx  + pa_ball->width < pa_pong->window_width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;
        break;
    case 5:
//        direction_name = "VPRAVO HORE";
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
//        direction_name = "VPRAVO DOLE";
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
//        direction_name = "STOP - ina hodnota";
        break;
    }

    return done;
}

void doRender(SDL_Renderer *renderer, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball, TTF_Font *pa_scoreboard_font)
{
    // Nastav cierne pozadie
    // Nastav vykreslovaciu farbu na ciernu
    SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);

    // Vycisti obrazovku predtym nastavenou farbou (ciernou)
    SDL_RenderClear(renderer);

    // Nastav biele plosiny a bielu lopticku
    // Nastav vykreslovaciu farbu na bielu
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);

    // Vykresli hraca 1
    // Vytvor obdlznik s danymi suradnicami
    SDL_Rect bumper_1 = { pa_player_1->x, pa_player_1->y, pa_player_1->width, pa_player_1->height };
    // Vykresli obdlznik (plosinu) hraca 1
    SDL_RenderFillRect(renderer, &bumper_1);

    // Vykresli hraca 2
    SDL_Rect bumper_2 = { pa_player_2->x, pa_player_2->y, pa_player_2->width, pa_player_1->height };
    SDL_RenderFillRect(renderer, &bumper_2);

    // Vykresli lopticku
    SDL_Rect ball = { pa_ball->x, pa_ball->y, pa_ball->width, pa_ball->height };
    SDL_RenderFillRect(renderer, &ball);

    // Vykresli skore
    SDL_Color White = {255, 255, 255};  // this is the color in rgb format, maxing out all would give you the color white, and it will be your text's color
    SDL_Surface* surfaceMessage = TTF_RenderText_Blended(pa_scoreboard_font, "AA", White); // as TTF_RenderText_Solid could only be used on SDL_Surface then you have to create the surface first
    SDL_Texture* scoreboard = SDL_CreateTextureFromSurface(renderer, surfaceMessage); //now you can convert it into a texture

    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_Rect message_rect; //create a rect
    message_rect.x = 50;  //controls the rect's x coordinate
    message_rect.y = 50; // controls the rect's y coordinte
    message_rect.w = 100; // controls the width of the rect
    message_rect.h = 100; // controls the height of the rect

    //Mind you that (0,0) is on the top left of the window/screen, think a rect as the text's box, that way it would be very simple to understance

    //Now since it's a texture, you have to put RenderCopy in your game loop area, the area where the whole code executes

    SDL_RenderCopy(renderer, scoreboard, NULL, &message_rect); //you put the renderer's name first, the Message, the crop size(you can ignore this if you don't want to dabble with cropping), and the rect which is the size and coordinate of your texture

    // Dokoncili sme vykreslovanie, teraz to prezentujeme (ukazeme) na obrazovke
    SDL_RenderPresent(renderer);

    // Uprac
    SDL_DestroyTexture(scoreboard);
    SDL_FreeSurface(surfaceMessage);
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
    set_ball_speed(&ball);

    // Otvor TCP socket
    int sockfd, newsockfd;  // sockfd = socket servera, newsockfd = socket klienta
    socklen_t cli_len;
    struct sockaddr_in serv_addr, cli_addr;
    int n;      // premenna na ukladanie navratovych hodnot funkcii, aby sme mohli porovnavat jej hodnotu v pripade chyby

    if (argc < 2)
    {
        fprintf(stderr,"Pouzitie: %s port\n", argv[0]);
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

    char *buffer = malloc(256);
    bzero(buffer,256);
    n = read(newsockfd, buffer, 255);
	if (n < 0)
	{
		perror("Error reading from socket");
		return 4;
	}

	// porovnaj buffer s inicializacnou spravou od klienta
    if(strcmp(buffer, "start") == 0)
    {
        printf("The game shall begin!\n");
    }
    else
    {
        return 404;
    }

    free(buffer);
    buffer = NULL;

    // Posli klientovi inicializacne parametre hry
    printf("Setting up the game ...\n");

    Init *init = malloc(sizeof(*init));
    init->window_width = pong.window_width;
    init->window_height = pong.window_height;
    init->player_width = player_1.width;
    init->player_height = player_1.height;
    init->ball_width = ball.width;
    init->ball_height = ball.height;

    // Kontrolny vypis spravy Init
//    printf("%d;%d;%d;%d;%d;%d;%d\n", init->window_width, init->window_height, init->player_width, init->player_height, init->ball_width, init->ball_height, (int) sizeof(*init));

    n = write(newsockfd, init, sizeof(*init));
    if (n < 0)
    {
        perror("Error writing to socket");
        return 5;
    }

    free(init);
    init = NULL;

    // Inicializuj SDL kniznicu
    SDL_Window *window;                    // Deklarujeme okno
    SDL_Renderer *renderer;                // Deklarujeme renderer

    SDL_Init(SDL_INIT_VIDEO);              // Initializujeme SDL2

    // Vytvorime aplikacne okno s nasledujucimi nastaveniami
    window = SDL_CreateWindow("Infinite PONG - Server",         // nazov okna
                              SDL_WINDOWPOS_UNDEFINED,          // zaciatocna x pozicia
                              SDL_WINDOWPOS_UNDEFINED,          // zaciatocna y pozicia
                              pong.window_width,                // sirka okna v pixeloch
                              pong.window_height,               // vyska okna v pixeloch
                              0                                 // flagy - ziadne
                             );

    // Vytvorime renderer
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED || SDL_HINT_RENDER_VSYNC);

    // Inicializuj TTF pre SDL - musi byt PO inicializacii SDL
    n = TTF_Init();
    if(n < 0)
    {
        printf("TTF sa pokazilo\n");
        return 403;
    }
    printf("TTF_Init() = %d", n);
//    SDL_Color white = { 255, 255, 255 };
//    TTF_Font *pixel_font = TTF_OpenFont("arcadeclassic.ttf", 15);
//    SDL_Surface *tmp = TTF_RenderText_Blended(pixel_font, "SCORE", white);
//    SDL_Texture *label = SDL_CreateTextureFromSurface(renderer, tmp);
//    SDL_Rect textRect = { 20, 20, tmp->w, tmp->h };
//    SDL_RenderCopy(renderer, label, NULL, &textRect);

    // NEZABUDNUT NICIT SURFACE Z PAMATI!!! HLAVNE KED HO DAS DO CYKLU!!!
//    SDL_FreeSurface(tmp);


//    TTF_Font* Sans = TTF_OpenFont("/home/andrej/Downloads/arcadeclassic_pixel_font/ARCADECLASSIC.TTF", 24); //this opens a font style and sets a size
    TTF_Font *Sans = TTF_OpenFont("/home/andrej/Desktop/pong_server/arcadeclassic.ttf", 20);
    if (Sans == NULL) {
        printf("Unable to load font: %s \n", TTF_GetError());
        return 403;
    }





    int done = 0;           // Premenna urcujuca, kedy je hra dokoncena. Inicializuje sa sice tu, ale nastavuje navratovou hodnotou funkcie 'processEvents' pomocou SDL_PollEvent

    // Struktura na vymenu informacii o stave hry
    Message *msg = malloc(sizeof(*msg));
    msg->gameStatus = done;

    char clienKeyPressed = ' ';
    int klientUkoncil = 0;

    // Okno je teraz otvorene -> vstupujeme do programoveho cyklu
    // Programova slucka
    while(!done)
    {
        // Odosli poziciu lopticky a lavej plosiny klientovi (prava plosina patri serveru; klient ma pravu plosinu)
        msg->player1x = player_1.x;
        msg->player1y = player_1.y;
        msg->player2x = player_2.x;
        msg->player2y = player_2.y;
        msg->ballx = ball.x;
        msg->bally = ball.y;
        msg->player1_score = player_1.score;
        msg->player2_score = player_2.score;

        // Odosli klientovi suradnice prvkov
        n = write(newsockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        // Prijmi akciu od klienta
        n = read(newsockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error reading from socket");
            return 4;
        }

        clienKeyPressed = msg->clientKeyPressed;
//        printf("%d;%d;%d;%d;%d;%d || sizeof(msg) = %lu || msg = %d\n", msg->player1x, msg->player1y, msg->player2x, msg->player2y, msg->ballx, msg->bally, sizeof(msg), msg->gameStatus);
//        printf("Stlacena klavesa od klienta: %c\n", clienKeyPressed);

        // Spracuj udalosti
        done = processEvents(window, &player_1, &player_2, &ball, &pong, clienKeyPressed);

        printf("%d:%d\n", player_1.score, player_2.score);

        // Klient ukoncil hru
        if(msg->gameStatus == 1)
        {
            printf("Koniec hry - klient\n");
            klientUkoncil = 1;
            break;
        }

        //Render display
        doRender(renderer, &player_1, &player_2, &ball, Sans);

        //don't burn up the CPU => spomal hru
        SDL_Delay(5);
    }

    // musime kontrolovat, ci bolo spojenie ukoncene klientom, aby sme predisli zapisu na uz zatvoreny socket (Error writing to socket: Bad file descriptor)
    // kod sa vykona, ak spojenie ukoncil server
    if(klientUkoncil == 0)
    {
        // poslat ukoncovaciu spravu
        msg->gameStatus = done;
        n = write(newsockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }
        printf("Koniec hry\n");
    }

    // Zatvor a znic okno
    SDL_DestroyWindow(window);
    SDL_DestroyRenderer(renderer);

    // Upraceme po sebe
    free(msg);
    msg = NULL;

    close(newsockfd);
    close(sockfd);


    TTF_CloseFont(Sans);  // Treba zatvorit pismo pri ukonceni hry
//    SDL_DestroyTexture(label);  // Znic texturu z pamati
//    TTF_CloseFont(pixel_font);  // Treba zatvorit pismo pri ukonceni hry
    TTF_Quit();                 // Znic TTF pre SDL - musi byt PRED znicenim SDL
    SDL_Quit();

    printf("Upratane!");
    return 0;
}

// klient je jeden hrac, server je druhy hrac
// z metody accept zistit id klienta
// write odoslat spravu klientovy

