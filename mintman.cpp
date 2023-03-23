#include <iostream>
#include <string>
#include "mintman/model/board.h"
#include <stdio.h>

int main() 
{
    Board board = {8,10};


    Brick brick1(liggande, 1);
    board.place(brick1, 1, 0);
    Brick brick2(staende, 2);
    board.place(brick2, 2, 1);
    Brick brick3(mintman, 3);
    board.place(brick3, 2, 4);
    Brick brick4(mintman, 4);
    board.place(brick4, 1, 6);


    while (true)
    {
        board.draw(true);
    }

}

