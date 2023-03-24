#include <SDL.h>
#include <iostream>
#include "../model/board.h"

class Screen
{

public:
    Screen(std::string title);

    ~Screen()
    {
        SDL_DestroyRenderer(_renderer);
        SDL_DestroyWindow(_window);
        SDL_Quit();
    }

    bool isRunning()
    {
        return _running;
    }

    void handleEvent(Board &board);

    void draw(Board &board);

    void drawImpl(Board &board)
    {
        int marginHorizontal = 30;
        int marginVertical = 30;
        int padding = 2;
        int widthBrick = 50;
        int heigthBrick = 50;
        
        //Window Size
        int width = 0; 
        int height = 0;
        SDL_GetWindowSize(_window, &width, &height);

        //Draw board area
        SDL_Rect area;
        area.x = marginHorizontal;
        area.y = marginVertical;
        area.h = (heigthBrick * board.getHeight());
        area.w = (widthBrick * board.getWidth());
        SDL_SetRenderDrawColor(_renderer, 80, 80, 90, 255);
        SDL_RenderFillRect(_renderer, &area);

        //Draw bricks
        for (BoardCoordinate c : board.getCoordinates())
        {
            SDL_Rect r;
            r.x = marginHorizontal + (widthBrick * c.x) + padding;
            r.y = marginVertical + (heigthBrick * c.y) + padding;
            r.h = (heigthBrick * c.height) - (2 * padding);
            r.w = (widthBrick * c.width) - (2 * padding);
            SDL_SetRenderDrawColor(_renderer, c.r, c.g, c.b, 255);
            SDL_RenderFillRect(_renderer, &r);
        }
    }


private:
    bool _init() 
    {
        std::cout << "initierar" << std::endl;

        if (SDL_Init(SDL_INIT_VIDEO) < 0)
        {
            std::cerr << "Could not initialize SDL" << std::endl;
            return false;
        }
        
        _window = SDL_CreateWindow(_title.c_str(), SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 800, 600, 0);
        if (!_window)
        {
            std::cerr << "Could not initialize window" << std::endl;
            return false;
        }

        _renderer = SDL_CreateRenderer(_window, -1, 0);
        if (!_renderer) {
            std::cerr << "Could not initialize renderer" << std::endl;
            return false;
        }
        return true;
    }

private:
    std::string _title;
    bool _running;
    SDL_Window* _window;
    SDL_Renderer* _renderer;
};