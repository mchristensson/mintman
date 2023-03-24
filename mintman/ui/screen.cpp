#include "screen.h"

Screen::Screen(std::string title) : _title(title)
{
    std::cout << "initierar " << _title << std::endl;
    _running = _init();
}

void Screen::handleEvent(Board &board)
{
    SDL_Event event;

    while(SDL_PollEvent(&event)) {
        switch (event.type) {
            case SDL_QUIT:
                _running = false;
                break;
            case SDL_KEYDOWN:
                switch ( event.key.keysym.sym )
                {
                case SDLK_DOWN:
                    board.move(5, down);
                    break;
                case SDLK_UP:
                    board.move(5, up);
                    break;
                case SDLK_LEFT:
                    board.move(5, left);
                    break;
                case SDLK_RIGHT:
                    board.move(5, right);
                    break;
                default:
                    break;
                }
            case SDL_MOUSEBUTTONDOWN: 
                int mouse_x, mouse_y;
                SDL_GetMouseState(&mouse_x, &mouse_y); 
            break;
        }
    }
    SDL_Delay(100);

}

void Screen::draw(Board &board) {
    drawImpl(board);
    SDL_SetRenderDrawColor(_renderer, 190, 90, 150, 255);
    SDL_RenderPresent(_renderer);
    SDL_RenderClear(_renderer);
}