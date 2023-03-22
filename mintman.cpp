#include <iostream>
#include <string>
#include "mintman/model/board.h"

int main() 
{
    Board board = {8,10};
    board.debug();

    Brick brick1(liggande, 1);
    board.place(brick1, 1, 0);

    Brick brick2(staende, 2);
    board.place(brick2, 2, 1);

    board.debug();
    
    Brick brick3(mintman, 3);
    std::cout << "Försöker lägga till brickan på {1,0} (ska inte gå, p.g.a upptagen)\n";
    board.place(brick3, 1, 0);

    std::cout << "Försöker lägga till brickan på {2,2} (ska inte gå, p.g.a. för stor)\n";
    board.place(brick3, 2, 2);

    std::cout << "Försöker lägga till brickan på {2,2} (ska inte gå, p.g.a. krock med brick2)\n";
    board.place(brick3, 2, 1);
    

    std::cout << "Försöker lägga till brickan på {2,4} (ska gå)\n";
    board.place(brick3, 2, 4);

    Brick brick4(mintman, 4);
    std::cout << "Försöker lägga till brickan på {1,6} (ska gå)\n";
    board.place(brick4, 1, 6);

    board.debug();

    std::cout << "Försöker flytta brickan högerut (ska gå)\n";
    board.move(brick4, down);
    board.move(brick4, right);
    board.move(brick4, right);
    board.move(brick4, right);
    board.move(brick4, right);
    board.move(brick4, up);
    board.move(brick4, up);
    board.move(brick4, left);
    board.move(brick4, left);
    board.debug();

}

