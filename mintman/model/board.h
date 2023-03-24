#include <vector>
#include <iostream>
#include "brick.h"
#include"transition.h"

struct BoardCoordinate
{
    int x, y, width, height;
    int r, g, b;
    BoardCoordinate() {}
};

class Board
{

public: 
    Board(int width, int height);
    ~Board();
    void debug();
    std::vector<BoardCoordinate> getCoordinates();

    bool place(const Brick& brick, int x, int y) 
    { 
        if (_canPlace(x,y, brick.getBricktype(),  brick.getId())) {
            _bricks.push_back(brick); 
            _addBrick(x, y, brick); 
            return true;
        }
        return false;
    }

    bool move(const Brick* brick, const transition& transition)
    {
        return _translateBrick(brick->getId(), transition, brick->getBricktype());
    }

    bool move(int id, const transition& transition)
    {
        Brick* brick = _findBrick(id);
        return move(brick, transition);
    }

    void draw(bool console)
    {
        _clear();
        debug(); 
        std::string command;
        std::cin >> command;
        _handleConsoleInput(command);
    }

    int getWidth()
    {
        return _width;
    }

    int getHeight()
    {
        return _height;
    }

private:
    int _width;
    int _height;
    std::vector<int> _cells;
    std::vector<Brick> _bricks;
    bool _canPlace(int x, int y, const bricktype& bricktype, int key);
    bool _translateBrick(int id, transition transition, const bricktype& bricktype);
    Brick* _findBrick(int id);
    void _addBrick(int x, int y, const Brick& brick);
    void _setValue(int x, int y, const bricktype& bricktype, int value);
    bool _matchesAnyOf(int value, int a, int b)
    {
        return value == a || value == b;
    }
    void _handleConsoleInput(std::string ch);
    void _clear() 
    {
        #if defined( _WIN32)  ||  defined(_WIN64)
            system("cls");
        #else
            system("clear");
        #endif

        //printf("\033[2J");
        //printf("\033[%d;%dH", 0, 0);
    }

};