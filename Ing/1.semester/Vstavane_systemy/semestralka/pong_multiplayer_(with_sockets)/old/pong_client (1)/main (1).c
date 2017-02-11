#include "SDL.h"
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
} Message;

int processEvents(SDL_Window *window, char *pa_client_key_pressed)
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

    // Ovladanie pre prveho hraca
    if(state[SDL_SCANCODE_W])
    {
        strcpy(pa_client_key_pressed, "W");
    }

    if(state[SDL_SCANCODE_S])
    {
        strcpy(pa_client_key_pressed, "S");
    }

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

    // otvor tcp socket
    int sockfd, n;
    struct sockaddr_in serv_addr;
    struct hostent* server;

    if (argc < 3)
    {
        fprintf(stderr,"usage %s hostname port\n", argv[0]);
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

    char *buffer = malloc(10);
    strcpy(buffer, "start");
    n = write(sockfd, buffer, strlen(buffer));
    if (n < 0)
    {
        perror("Error writing to socket");
        return 5;
    }

    free(buffer);

    // prijmi inicializacne parametre hry zo servera
    Init *init = malloc(sizeof(*init));
    n = read(sockfd, init, sizeof(*init));
    if (n < 0)
    {
        perror("Error reading from socket");
        return 6;
    }

    pong.window_width = init->window_width;
    pong.window_height = init->window_height;
    player_1.width = player_2.width = init->player_width;
    player_1.height = player_2.height = init->player_height;
    ball.width = init->ball_width;
    ball.height = init->ball_height;

    printf("%d;%d;%d;%d;%d;%d\n", pong.window_width, pong.window_height, player_1.width, player_1.height, ball.width, ball.height);

    free(init);

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

    Message *msg = malloc(sizeof(*msg));
    msg->gameStatus = done;

    buffer = malloc(2);
    int serverUkoncil = 0;
    //Event loop
    while(!done)
    {
        // prijmi informacie o priebehu hry zo servera
        n = read(sockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error reading from socket");
            return 6;
        }

        // nahadzat suradnice do struktur
        player_1.x = msg->player1x;
        player_1.y = msg->player1y;
        player_2.x = msg->player2x;
        player_2.y = msg->player2y;
        ball.x = msg->ballx;
        ball.y = msg->bally;

        printf("%d;%d;%d;%d;%d;%d || msg = %d\n", player_1.x, player_1.y, player_2.x, player_2.y, ball.x, ball.y, msg->gameStatus);

        // Server poslal spravu na ukoncenie hry
        if(msg->gameStatus == 1)
        {
            printf("Koniec hry - server\n");
            serverUkoncil = 1;
            free(buffer);
            free(msg);
            close(sockfd);
            break;
        }

        //Check for events - odosli ovladaciu klavesu stlacenu klientom
        done = processEvents(window, buffer);
        msg->clientKeyPressed = buffer[0];
        msg->gameStatus = done;

        // odosli informacie o priebehu hry od klienta na server
        n = write(sockfd, msg, sizeof(*msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 6;
        }

        //Render display
        doRender(renderer, &player_1, &player_2, &ball);
    }

	// poslat ukoncovaciu spravu, ale iba ak klient ukoncil spojenie
	if(serverUkoncil == 0)
	{
        msg->gameStatus = done;
        n = write(sockfd, &msg, sizeof(msg));
        if (n < 0)
        {
            perror("Error writing to socket");
            return 5;
        }

        free(buffer);
        free(msg);
        close(sockfd);
        printf("Koniec hry\n");
	}

    // Close and destroy the window
    SDL_DestroyWindow(window);
    SDL_DestroyRenderer(renderer);

    // Clean up
    SDL_Quit();
    return 0;
}

// klient je jeden hrac, server je druhy hrac
// z metody accept zistit id klienta
// write odoslat spravu klientovi
