#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <stdint.h>

#include "infinite_pong_server.h"

#define BUFFER_SIZE 512

typedef struct player
{
    int x, y;
    int width, height;
    int score;
} Player;

typedef struct ball
{
    int x, y;
    int width, height;
    int dx, dy;
    int direction;
} Ball;

typedef struct game
{
    int window_width, window_height;
} Game;

// Spravy posielane po sieti
// Init - inicializacna sprava - sluzi na inicializaciu parametrov hry u klienta
typedef struct init
{
    int window_width, window_height, player_width, player_height, ball_width, ball_height;
} Init;

// Message - vseobecna sprava - sluzi na informovanie klienta o priebehu hry
typedef struct message
{
    int player1x, player1y, player2x, player2y, ballx, bally;   // suradnice prvkov
    int gameStatus;     // stav hry - hra moze bezat (0), alebo byt ukoncena ktorymkolvek z hracov (1)
    char clientKeyPressed;      // klavesa, ktoru klient stlacil
    int player1_score, player2_score;
} Message;

// Vypis retazca smernikovou aritmetikou na terminal
void printToTerminal(char *pa_retazec, int size)
{
    char *zac = NULL;
    char *kon = pa_retazec + size;
    for(zac = pa_retazec; zac < kon; zac++)
    {
        if(*zac == '\0') break;
        putc(*zac, stdout);
    }
}

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

// Nastavuje x-ovu a y-ovu rychlost (smernicu) pre lopticku
void set_ball_speed(Ball *pa_ball)
{
    // Pre jednoduchost budu smernice dx a dy rovne 1, aby sa program zbytocne nekomplikoval
    pa_ball->dx = 1;
    pa_ball->dy = 1;
}

int processEvents(SDL_Window *window, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball, Game *pa_pong, char pa_client_key_pressed)
{
    SDL_Event *event = malloc(sizeof(SDL_Event));
    int done = 0;     // program uz skoncil? 0 = nie, 1 = ano

    // Sledovanie ukoncenia hry
    while(SDL_PollEvent(event))
    {
        switch(event->type)
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
            switch(event->key.keysym.sym)
            {
            case SDLK_ESCAPE:
                done = 1;
                break;
            }
        }
        break;
        case SDL_QUIT:
            done = 1;
            break;
        }
    }

    // Upraceme
    free(event);
    event = NULL;

    // OVLADANIE HRY
    // Inicializuj vstup z klavesnice pre SDL
    const uint8_t *state = SDL_GetKeyboardState(NULL);
    int difference = 5;  // pocet pixelov, o ktore sa plosina hraca pohne na jedno stlacenie klavesy

    // Ovladanie pre prveho hraca
    if(state[SDL_SCANCODE_W])
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_1->y > difference)
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

    // Ovladanie pre druheho hraca (klienta)
    if(pa_client_key_pressed == 'W')
    {
        // Skontroluj, ci hrac nepresahuje hranice okna
        if(pa_player_2->y > difference)
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
    }

    // LOGIKA ODRAZANIA LOPTICKY OD STIEN A OD HRACOV
    // Odraz lopticku od plosiny hraca 1
    if( pa_ball->x <= pa_player_1->x + pa_player_1->width + pa_ball->dx - 1
        && pa_ball->y >= pa_player_1->y
        && pa_ball->y <= pa_player_1->y + pa_player_1->height)
    {
        pa_ball->direction = rand() % 3 + 4;
        set_ball_speed(pa_ball);
    }

    // Odraz lopticku od plosiny hraca 2
    if( pa_ball->x == pa_player_2->x - pa_ball->width
        && pa_ball->y >= pa_player_2->y
        && pa_ball->y <= pa_player_2->y + pa_player_2->height)
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
    switch (pa_ball->direction)
    {
    case 0:
        break;
    case 1:
        if(pa_ball->x - pa_ball->dx > 0)
            pa_ball->x -= pa_ball->dx;
        else                                // narazili sme na lavu stenu
            pa_ball->x = 0;
        break;
    case 2:
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
        if(pa_ball->x + pa_ball->dx  + pa_ball->width < pa_pong->window_width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;
        break;
    case 5:
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
        if(pa_ball->x + pa_ball->dx < pa_pong->window_width - pa_ball->width)
            pa_ball->x += pa_ball->dx;
        else                                // narazili sme na pravu stenu
            pa_ball->x = pa_pong->window_width - pa_ball->width;

        if(pa_ball->y + pa_ball->dy < pa_pong->window_height - pa_ball->height)
            pa_ball->y += pa_ball->dy;
        else                                // narazili sme na dolnu stenu
            pa_ball->y = pa_pong->window_height - pa_ball->height;
        break;
    }

    // Kontrolny vypis umiestnenia prvkov na hracej ploche
//    printf("P1: %d;%d\tB: %d;%d\tP2: %d;%d\t%d;%d\n", pa_player_1->x+pa_player_1->width, pa_player_1->y, pa_ball->x, pa_ball->y, pa_player_2->x-pa_ball->width, pa_player_2->y, pa_pong->window_width - pa_ball->width, pa_pong->window_height - pa_ball->height);

    return done;
}

void doRender(  SDL_Renderer *renderer, Player *pa_player_1, Player *pa_player_2, Ball *pa_ball,
                TTF_Font *pa_scoreboard_font, char *pa_scoreboard_text)
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
    SDL_Color scoreboard_color = {255, 255, 255};   // Nastavime vykreslovaciu farbu na bielu
    SDL_Surface* scoreboard_message = TTF_RenderText_Solid(pa_scoreboard_font, pa_scoreboard_text, scoreboard_color);   // Ulozime text do SDL_Surface
    SDL_Texture* scoreboard = SDL_CreateTextureFromSurface(renderer, scoreboard_message);   // Skonvertujeme Surface na texturu, ktoru neskor skopirujeme do renderera

    // Ziskaj rozmery zobrazovaneho textu a okna, aby sme mohli skore zarovnat na stred vrchnej casti obrazovky
    int32_t scoreboard_w, scoreboard_h;
    int32_t renderer_w, renderer_h;
    SDL_QueryTexture(scoreboard, 0, 0, &scoreboard_w, &scoreboard_h);
    SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
    SDL_GetRendererOutputSize(renderer, &renderer_w, &renderer_h);

    // Kontrola spravneho vystupu metody SDL_GetRendererOutputSize
//    printf("%d\n", renderer_w );

    // Vypiseme skore do stredu hornej casti hracej plochy
    SDL_Rect scoreboard_rect = { (renderer_w / 2) - (scoreboard_w / 2), 5, scoreboard_w, scoreboard_h };

    // Zavolame SDL_RenderCopy, aby sme skopirovali text (textovu texturu) do renderera
    SDL_RenderCopy(renderer, scoreboard, NULL, &scoreboard_rect);

    // Dokoncili sme vykreslovanie, teraz to prezentujeme (ukazeme) na obrazovke
    SDL_RenderPresent(renderer);

    // Upraceme naalokovane graficke objekty
    SDL_DestroyTexture(scoreboard);
    SDL_FreeSurface(scoreboard_message);
}

int main(int argc, char *argv[])
{
    // Inicializuj struktury hry
    Game *pong = malloc(sizeof(struct game));     // Deklaruj hru / okno

    // Deklaruj hracov
    Player *player_1 = malloc(sizeof(struct player));
    Player *player_2 = malloc(sizeof(struct player));

    Ball *ball = malloc(sizeof(struct ball));     // Deklaruj lopticku

    // Inicializuj hru / okno
    pong->window_width = 350;
    pong->window_height = 350;

    // Inicializuj hraca 1
    player_1->width = 10;
    player_1->height = 50;
    player_1->x = 5;
    player_1->y = (pong->window_height / 2) - (player_1->height / 2);
    player_1->score = 0;

    // Inicializuj hraca 2
    player_2->width = 10;
    player_2->height = 50;
    player_2->x = pong->window_width - player_2->width - 5;
    player_2->y = (pong->window_height / 2) - (player_1->height / 2);
    player_2->score = 0;

    // Inicializuj lopticku
    ball->width = ball->height = 4;
    ball->x = (pong->window_width / 2) - (ball->width / 2);
    ball->y = (pong->window_height / 2) - (ball->height / 2);
    ball->direction = direction_to_int("STOP");
    set_ball_speed(ball);

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

    listen(sockfd, 1);  // Moze byt najviac jedno nespracovane spojenie
    cli_len = sizeof(cli_addr);

    newsockfd = accept(sockfd, (struct sockaddr*)&cli_addr, &cli_len);
    if (newsockfd < 0)
    {
        perror("ERROR on accept");
        return 3;
    }

    // Zatvor serverovy socket, aby sa nemohlo pripojit viac hracov ako jeden
    close(sockfd);

    char *buffer = malloc(BUFFER_SIZE);
    memset(buffer, '\0', BUFFER_SIZE);
    n = read(newsockfd, buffer, 6); // 6, lebo sprava "start" ma 5 znakov + nullterminator
	if (n < 0)
	{
		perror("Error reading from socket");
		return 4;
	}

	// porovnaj buffer s inicializacnou spravou od klienta
    if(strncmp(buffer, "start", 6) == 0)
    {
        memset(buffer, '\0', BUFFER_SIZE);
        strncpy(buffer, "The game shall begin!\n", 23);
        printToTerminal(buffer, BUFFER_SIZE);
    }
    else
    {
        return 404;
    }

    // Posli klientovi inicializacne parametre hry
    memset(buffer, '\0', BUFFER_SIZE);
    strncpy(buffer, "Setting up the game ...\n", 24);
    printToTerminal(buffer, BUFFER_SIZE);

    Init *init = malloc(sizeof(struct init));
    init->window_width = pong->window_width;
    init->window_height = pong->window_height;
    init->player_width = player_1->width;
    init->player_height = player_1->height;
    init->ball_width = ball->width;
    init->ball_height = ball->height;

    // Kontrolny vypis spravy Init
//    printf("%d;%d;%d;%d;%d;%d;%d\n", init->window_width, init->window_height, init->player_width, init->player_height, init->ball_width, init->ball_height, (int) sizeof(Init));

    n = write(newsockfd, init, sizeof(Init));
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
                              pong->window_width,               // sirka okna v pixeloch
                              pong->window_height,              // vyska okna v pixeloch
                              0                                 // flagy - ziadne
                             );

    // Vytvorime renderer
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED || SDL_HINT_RENDER_VSYNC);

    // Inicializuj TTF pre SDL - musi byt PO inicializacii SDL
    n = TTF_Init();
    if(n < 0)
    {
        memset(buffer, '\0', BUFFER_SIZE);
        strncpy(buffer, "TTF sa pokazilo\n", 16);
        printToTerminal(buffer, BUFFER_SIZE);
        return 403;
    }

    // Nacitaj pismo
    // http://www.dafont.com/digital-7.font
    TTF_Font *scoreboard_font = TTF_OpenFont("digital-7 (mono).ttf", 50);
    if (scoreboard_font == NULL) {
        memset(buffer, '\0', BUFFER_SIZE);
        strncpy(buffer, "Nepodarilo sa nacitat pismo\n", 28);
        printToTerminal(buffer, BUFFER_SIZE);

        printf("%s\n", TTF_GetError());
        return 400;
    }

    char *scoreboard_text = malloc(10);     // 4 cifry na 1 stranu, dvojbodka, 4 na druhu stranu, nullterminator
    char *player2_score = malloc(5);        // 4 cifry + nullterminator

    int done = 0;              // Premenna urcujuca, kedy je hra dokoncena. Inicializuje sa sice tu, ale nastavuje navratovou hodnotou funkcie 'processEvents' pomocou SDL_PollEvent

    // Struktura na vymenu informacii o stave hry
    Message *msg = calloc(1, sizeof(Message));      // alokovane cez calloc, lebo valgrind krical pri mallocu "Syscall param write(buf) points to uninitialised byte(s)" a "Address 0x10d4a0ac is 28 bytes inside a block of size 40 alloc'd"
    msg->gameStatus = done;

    // Inicializacia pomocnych rozhodovacich premennych
    char clienKeyPressed = ' ';     // klavesa, ktoru stlacil klient; ziskava sa zo spravy (Message)
    int klientUkoncil = 0;     // urcuje, ci sa ma poslat sprava na ukoncenie hry klientovi: 1 = klient ukoncil hru, takze mu netreba spatne znovu posielat spravu o ukonceni hry; 0 = server ukoncil hru, preto odosle klientovi spravu o ukonceni hry

    // Okno je teraz otvorene -> vstupujeme do programoveho cyklu
    // Programova slucka
    while(!done)
    {
        // Odosli poziciu lopticky a lavej plosiny klientovi (prava plosina patri serveru; klient ma pravu plosinu)
        msg->player1x = player_1->x;
        msg->player1y = player_1->y;
        msg->player2x = player_2->x;
        msg->player2y = player_2->y;
        msg->ballx = ball->x;
        msg->bally = ball->y;
        msg->player1_score = player_1->score;
        msg->player2_score = player_2->score;

        // Odosli klientovi suradnice prvkov
        n = write(newsockfd, msg, sizeof(Message));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        // Prijmi akciu od klienta
        n = read(newsockfd, msg, sizeof(Message));
        if (n < 0)
        {
            perror("Error reading from socket");
            return 4;
        }

        clienKeyPressed = msg->clientKeyPressed;
//        printf("%d;%d;%d;%d;%d;%d || sizeof(Message) = %lu || msg = %d\n", msg->player1x, msg->player1y, msg->player2x, msg->player2y, msg->ballx, msg->bally, sizeof(Message), msg->gameStatus);
//        printf("Stlacena klavesa od klienta: %c\n", clienKeyPressed);

        // Spracuj udalosti
        done = processEvents(window, player_1, player_2, ball, pong, clienKeyPressed);

//        printf("%d:%d\n", player_1->score, player_2->score);

        // Klient ukoncil hru
        if(msg->gameStatus == 1)
        {
            memset(buffer, '\0', BUFFER_SIZE);
            strncpy(buffer, "Koniec hry - klient\n", 20);
            printToTerminal(buffer, BUFFER_SIZE);

            klientUkoncil = 1;
            break;
        }

        // Posli aktualne skore do renderera
        snprintf(scoreboard_text, 4, "%d", player_1->score);
        strncat(scoreboard_text, ":", 1);
        snprintf(player2_score, 4, "%d", player_2->score);
        strncat(scoreboard_text, player2_score, 5);

        //Render display
        doRender(renderer, player_1, player_2, ball, scoreboard_font, scoreboard_text);

        // Pockame 5 ms, aby hra isla trochu pomalsie, ale stale rozumne rychlo
        SDL_Delay(5);
    }

    // musime kontrolovat, ci bolo spojenie ukoncene klientom, aby sme predisli zapisu na uz zatvoreny socket (Error writing to socket: Bad file descriptor)
    // kod sa vykona, ak spojenie ukoncil server
    if(klientUkoncil == 0)
    {
        // poslat ukoncovaciu spravu
        msg->gameStatus = done;
        n = write(newsockfd, msg, sizeof(Message));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        memset(buffer, '\0', BUFFER_SIZE);
        strncpy(buffer, "Koniec hry\n", 11);
        printToTerminal("Koniec hry\n", BUFFER_SIZE);

    }

    // Vypiseme, kto vyhral: na terminal aj do skore
    printf("%d:%d\n", player_1->score, player_2->score);
    memset(buffer, '\0', BUFFER_SIZE);
    if(player_1->score > player_2->score)
    {
        strncpy(buffer, "Vyhral si! :D", 14);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }
    else if(player_1->score == player_2->score)
    {
        strncpy(buffer, "Remiza", 7);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }
    else
    {
        strncpy(buffer, "Prehral si :(", 14);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }

    printToTerminal(buffer, BUFFER_SIZE);

    putc('\n', stdout);

    // Pozastavime hru, aby sme si mohli precitat spravu, ci sme vyhrali alebo nie
    sleep(2);

    // Upraceme po sebe
    free(buffer);
    buffer = NULL;

    free(ball);
    ball = NULL;

    free(player_1);
    player_1 = NULL;

    free(player_2);
    player_2 = NULL;

    free(pong);
    pong = NULL;

    free(player2_score);
    player2_score = NULL;

    free(scoreboard_text);
    scoreboard_text = NULL;

    free(msg);
    msg = NULL;

    // Zatvor socket s klientom
    close(newsockfd);

    TTF_CloseFont(scoreboard_font);  // Treba zatvorit pismo pri ukonceni hry
    TTF_Quit();                 // Znic TTF pre SDL - musi byt PRED znicenim SDL

    // Zatvor a znic okno
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_QuitSubSystem(SDL_INIT_VIDEO);
    SDL_Quit();
    return 0;
}

