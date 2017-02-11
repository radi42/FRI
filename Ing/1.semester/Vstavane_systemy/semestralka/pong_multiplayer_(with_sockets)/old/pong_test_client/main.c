#include "SDL.h"
#include "SDL_ttf.h"
#include <stdio.h>
#include <time.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
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

int processEvents(SDL_Window *window, char *pa_client_key_pressed)
{
    SDL_Event *event = malloc(sizeof(*event));
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
    const Uint8 *state = SDL_GetKeyboardState(NULL);

    // Ovladanie hraca - klienta
    if(state[SDL_SCANCODE_W])
    {
        strncpy(pa_client_key_pressed, "W", 2);
    }
    else if(state[SDL_SCANCODE_S])
    {
        strncpy(pa_client_key_pressed, "S", 2);
    }
    else
    {
        strncpy(pa_client_key_pressed, " ", 2);     // ak klient stlacil inu klavesu, uloz ju ako prazdnu, aby server stale nedostaval naposledy stlacenu klavesu
    }

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
    int scoreboard_w, scoreboard_h;
    int renderer_w, renderer_h;
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

    // Inicializujeme struktury hry
    Game *pong = malloc(sizeof(*pong));     // Deklaruj hru / okno

    // Deklaruj hracov
    Player *player_1 = malloc(sizeof(*player_1));
    Player *player_2 = malloc(sizeof(*player_2));

    Ball *ball = malloc(sizeof(*ball));                            // Deklaruj lopticku

    // Otvor TCP socket
    int sockfd, n;      // sockfd - filedeskriptor socketu servera, n - navratova hodnota funkcii na porovnavanie s chybou
    struct sockaddr_in serv_addr;
    struct hostent* server;

    if (argc < 3)
    {
        fprintf(stderr,"Pouzitie: %s hostname port\n", argv[0]);
        return 1;
    }

    server = gethostbyname(argv[1]);
    if (server == NULL)
    {
        fprintf(stderr, "Error, no such host\n");
        return 2;
    }

    bzero((char*)&serv_addr, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    bcopy(
        (char*)server->h_addr,
        (char*)&serv_addr.sin_addr.s_addr,
        server->h_length
    );
    serv_addr.sin_port = htons(atoi(argv[2]));

    sockfd = socket(AF_INET, SOCK_STREAM, 0);
    if (sockfd < 0)
    {
        perror("Error creating socket");
        return 3;
    }

    if(connect(sockfd, (struct sockaddr*)&serv_addr, sizeof(serv_addr)) < 0)
    {
        perror("Error connecting to socket");
        return 4;
    }

    // Klient inicializuje zaciatok hry spravou "start"
    char *buffer = malloc(14);      // Velkost buffera je 14, aby sa don zmestili aj zaverecne spravy. Buffer uklada klavesu stlacenu klientom. Ta sa potom ulozi do spravy a odosle serveru, ktory vykona akciu spojenu so stlacenou klavesou
    strcpy(buffer, "start");
    n = write(sockfd, buffer, strlen(buffer));
    if (n < 0)
    {
        perror("Error writing to socket");
        return 5;
    }

    // Klient prijme inicializacne parametre hry od servera
    Init *init = malloc(sizeof(*init));
    n = read(sockfd, init, sizeof(*init));
    if (n < 0)
    {
        perror("Error reading from socket");
        return 6;
    }

    pong->window_width = init->window_width;
    pong->window_height = init->window_height;
    player_1->width = player_2->width = init->player_width;
    player_1->height = player_2->height = init->player_height;
    ball->width = init->ball_width;
    ball->height = init->ball_height;

    // Kontrolny vypis spravy Init
//    printf("%d;%d;%d;%d;%d;%d\n", pong->window_width, pong->window_height, player_1->width, player_1->height, ball->width, ball->height);

    free(init);
    init = NULL;

    // Inicializuj SDL kniznicu
    SDL_Window *window;                    // Deklarujeme okno
    SDL_Renderer *renderer;                // Deklarujeme renderer

    SDL_Init(SDL_INIT_VIDEO);              // Initializujeme SDL2

    // Vytvorime aplikacne okno s nasledujucimi nastaveniami
    window = SDL_CreateWindow("Infinite PONG - Client",         // nazov okna
                              SDL_WINDOWPOS_UNDEFINED,          // zaciatocna x pozicia
                              SDL_WINDOWPOS_UNDEFINED,          // zaciatocna y pozicia
                              pong->window_width,                // sirka okna v pixeloch
                              pong->window_height,               // vyska okna v pixeloch
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

    // Nacitaj pismo
    // http://www.dafont.com/digital-7.font
    TTF_Font *scoreboard_font = TTF_OpenFont("/home/andrej/Downloads/digital_7/digital-7 (mono).ttf", 50);
    if (scoreboard_font == NULL) {
        printf("Unable to load font: %s \n", TTF_GetError());
        return 400;
    }

    char *scoreboard_text = malloc(10);     // 4 cifry na 1 stranu, dvojbodka, 4 na druhu stranu, nullterminator
    char *player2_score = malloc(5);        // 4 cifry + nullterminator

    int serverUkoncil = 0;  // Premenna na hlasenie, ci hru ukoncil klient sam alebo prisla ukoncovacia sprava od servera
    int done = 0;           // Premenna urcujuca, kedy je hra dokoncena. Inicializuje sa sice tu, ale nastavuje navratovou hodnotou funkcie 'processEvents' pomocou SDL_PollEvent

    // Vytvorime spravu, pomocou ktorej si budu klient a server vymienat informacie o stave hry
    Message *msg = malloc(sizeof(*msg));
    msg->gameStatus = done;

    // Okno je teraz otvorene -> vstupujeme do programoveho cyklu
    // Programovy cyklus
    while(!done)
    {
        // Prijmeme informacie o priebehu hry zo servera
        n = read(sockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error reading from socket");
            return 6;
        }

        // Nahadzeme informacie od servera do struktur
        player_1->x = msg->player1x;
        player_1->y = msg->player1y;
        player_2->x = msg->player2x;
        player_2->y = msg->player2y;
        ball->x = msg->ballx;
        ball->y = msg->bally;
        player_1->score = msg->player1_score;
        player_2->score = msg->player2_score;

//        printf("%d;%d;%d;%d;%d;%d || msg = %d\n", player_1->x, player_1->y, player_2->x, player_2->y, ball->x, ball->y, msg->gameStatus);

        // Server poslal spravu na ukoncenie hry
        if(msg->gameStatus == 1)
        {
            printf("Koniec hry - server\n");
            serverUkoncil = 1;
            break;
        }

        // Spracuj vstup od klienta - odosli ovladaciu klavesu stlacenu klientom
        done = processEvents(window, buffer);
        msg->clientKeyPressed = buffer[0];
        msg->gameStatus = done;
//        printf("Stlacena klavesa od klienta: %c\n", msg->clientKeyPressed);

        // Odosli vstup (stlacenu klavesu) od klienta na server
        n = write(sockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 6;
        }

        // Posli aktualne skore do renderera
        snprintf(scoreboard_text, 4, "%d", player_1->score);
        strncat(scoreboard_text, ":", 1);
        snprintf(player2_score, 4, "%d", player_2->score);
        strncat(scoreboard_text, player2_score, 5);

        // Vykresli obrazovku
        doRender(renderer, player_1, player_2, ball, scoreboard_font, scoreboard_text);
    }

	// Poslat ukoncovaciu spravu, ale iba ak klient ukoncil spojenie. Ak ho ukoncil server, tak ho netreba este raz otravovat so spravovu
	if(serverUkoncil == 0)
	{
        msg->gameStatus = done;
        n = write(sockfd, &msg, sizeof(msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        printf("Koniec hry\n");
	}

	// Vypiseme, kto vyhral: na terminal aj do skore
	printf("%d:%d\n", player_1->score, player_2->score);
    if(player_2->score > player_1->score)
    {
        strncpy(buffer, "Vyhral si! :D", 14);
        printf("%s\n", buffer);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }
    else if(player_1->score == player_2->score)
    {
        strncpy(buffer, "Remiza", 7);
        printf("%s\n", buffer);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }
    else
    {
        strncpy(buffer, "Prehral si :(", 14);
        printf("%s\n", buffer);
        doRender(renderer, player_1, player_2, ball, scoreboard_font, buffer);
    }

    // Pozastavime hru, aby sme si mohli precitat spravu, ci sme vyhrali alebo nie
    sleep(2);

    // Zatvor a znic okno
    SDL_DestroyWindow(window);
    SDL_DestroyRenderer(renderer);

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

    // Zatvor socket so serverom
    close(sockfd);

    TTF_CloseFont(scoreboard_font);  // Treba zatvorit pismo pri ukonceni hry
    TTF_Quit();                 // Znic TTF pre SDL - musi byt PRED znicenim SDL
    SDL_Quit();
    return 0;
}
