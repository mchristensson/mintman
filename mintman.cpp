#include <iostream>
#include "mintman/ui/screen.h"

int main(int argv, char** args)
{
    
    Screen screen = {"Mintman"};
    Board board = {9, 10}; // width, height

    Brick brick1(liggande, 1);
    board.place(brick1, 1, 0);
    
    Brick brick2(staende, 2);
    board.place(brick2, 2, 1);
    
    Brick brick3(mintman, 3);
    board.place(brick3, 2, 4);
    
    Brick brick4(liten, 4);
    board.place(brick4, 1, 6);


    while(screen.isRunning()) 
    {
        
        screen.draw(board);
        screen.handleEvent(board);
    }

    return 0;
}