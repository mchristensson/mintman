#include <iostream>
#include "mintman/ui/screen.h"

int main(int argv, char** args)
{
    Screen screen = {"Mintman"};
    Board board = {4, 5}; // Board width, height

    Brick brick1(staende, 1);
    board.place(brick1, 0, 0);
    
    Brick brick2(mintman, 2);
    board.place(brick2, 1, 0);
    
    Brick brick3(staende, 3);
    board.place(brick3, 3, 0);

    Brick brick4(staende, 4);
    board.place(brick4, 0, 2);

    Brick brick5(liggande, 5);
    board.place(brick5, 1, 2);

    while(screen.isRunning()) 
    {
        screen.draw(board);
        screen.handleEvent(board);
    }
    return 0;
}