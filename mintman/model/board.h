#include <vector>
#include <iostream>
#include "brick.h"
#include"transition.h"

class Board
{

public: 
    Board(int width, int height);
    void debug();

    bool place(const Brick& brick, int x, int y) 
    { 
        if (_canPlace(x,y, brick.getBricktype(),  brick.getId())) {
            _bricks.push_back(brick); 
            _addBrick(x, y, brick); 
            return true;
        }
        return false;
    }

    bool move(const Brick& brick, const transition& transition)
    {
        return _translateBrick(brick.getId(), transition, brick.getBricktype());
    }

private:
    int _width;
    int _height;
    std::vector<int> _cells;
    std::vector<Brick> _bricks;
    bool _canPlace(int x, int y, const bricktype& bricktype, int key);
    bool _translateBrick(int id, const transition& transition, const bricktype& bricktype);
    void _addBrick(int x, int y, const Brick& brick);
    void _setValue(int x, int y, const bricktype& bricktype, int value);
    bool _matchesAnyOf(int value, int a, int b)
    {
        return value == a || value == b;
    }

};