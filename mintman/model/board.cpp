#include "board.h"

#include <iostream>
#include <string>
#include <stdexcept> // innehåller undantagsklasser
#include <algorithm> // Binary search

Board::Board(int width, int height) :
    _width(width), _height(height), _cells(_width * _height, 0), _bricks(0, Brick())
{
};

Board::~Board()
{
    _bricks.clear();
    _cells.clear();
}

void Board::_handleConsoleInput(std::string ch)
{
    if (ch.length() >= 0)
    {
        int idx = ch.find(":");
        std::string id = ch.substr(0, idx);
        if ( idx + 1 != std::string::npos )
        {
            std::string cmd = ch.substr(idx + 1, std::string::npos);
            transition transition;
            if (cmd == "z")
                transition = down;
            else if (cmd == "a")
                transition = left;
            else if (cmd == "s")
                transition = right;
            else if (cmd == "w")
                transition = up;
            else {
                std::cerr << "Ogilitig riktning" << std::endl;
                return;
            }
            //std::cout << "\nYou pressed " << ch << "  with command " << cmd << " transition: " << transition  << " \n";
            try {
                Brick* brick = _findBrick(std::stoi(id));
                _translateBrick(brick->getId(), transition, brick->getBricktype());
            } catch (const std::invalid_argument& e) {
                printf("\nOgilitig bricka!\n");
            } catch (const std::out_of_range& e) {
                printf("\nOgilitigt bricka!\n");
            }
        }
        else {
            printf("\nOgilitigt kommando!\n");
        }
    }
    else
       printf("\nAliens have taken over standard input! Run!\n");

}

bool Board::_canPlace(int x, int y, const bricktype& bricktype, int key) {
    int brick_height = 0;
    int brick_width = 0;
    switch (bricktype)
    {
    case staende:
        brick_height = 1;
        break;
    case liggande:
        brick_width = 1;
        break;
    case mintman:
        brick_width = 1;
        brick_height = 1;
        break;
    default:
        break;
    }

    //Out of bounds-check
    if ( (x < 0 && (x+brick_width) >= _width) || (y < 0 && (y+brick_height) >= _height) )
    {
        return false;
    }

    //Index is not used
    switch (bricktype)
    {
    case staende:
        return 
        _matchesAnyOf(_cells[y * _width + x], 0, key) && 
        _matchesAnyOf(_cells[(y + brick_height) * _width + x], 0, key);
    case liggande:
        return 
        _matchesAnyOf(_cells[y * _width + x], 0, key) && 
        _matchesAnyOf(_cells[y * _width + x + brick_width], 0, key);
    case mintman:
        return 
        _matchesAnyOf(_cells[y * _width + x], 0, key) && 
        _matchesAnyOf(_cells[(y + brick_height) * _width + x], 0, key) && 
        _matchesAnyOf(_cells[y * _width + x + brick_width], 0, key) && 
        _matchesAnyOf(_cells[(y + brick_height) * _width + x + brick_width], 0, key);
    default:
        return _matchesAnyOf(_cells[y * _width + x], 0, key);
    }
    
}

void Board::_addBrick(int x, int y, const Brick& brick) 
{
    _setValue(x, y, brick.getBricktype(), brick.getId());
}

void Board::_setValue(int x, int y, const bricktype& bricktype, int value) 
{
    int brickHeight = 1;
    int brickWidth = 1;
    switch (bricktype)
    {
    case staende:
        brickHeight = 2;
        break;
    case liggande:
        brickWidth = 2;
        break;
    case mintman:
        brickWidth = 2;
        brickHeight = 2;
        break;
    default:
        break;
    }
    for (int r = 0; r < brickHeight; r++)
    {
        int dr = (y+r) * _width + x;
        std::fill_n(_cells.begin() + dr, brickWidth, value);
    }
}

std::vector<BoardCoordinate> Board::getCoordinates()
{
    
    std::vector<BoardCoordinate> output(_cells.size());
    
    
    // Build an vector of all IDs that we haven't yet handled
    std::vector<int> tmpIds(_bricks.size());
    for (int i = 0; i < _bricks.size(); i++)
    {
        tmpIds[i] = _bricks.at(i).getId();
    }

    //Iterate through the board
    int x = 0;
    int y = 0;
    for(int i=0; i < _cells.size(); i++)
    {
        x++;
        if (i != 0 && i % _width == 0)
        {
            y++;
            x = 0;
        }

        //Check if already prcessed, if so - skip
        bool skip = true;
        auto tmpIdsIterator = tmpIds.begin(); 
        while (tmpIdsIterator != tmpIds.end())
        {
            if (_cells[i] == 0) {
                break;
            } 
            else if (*tmpIdsIterator == _cells[i])
            {
                tmpIdsIterator = tmpIds.erase(tmpIdsIterator);
                skip = false; 
                break;
            }
            tmpIdsIterator++;
        }
        if (skip)
        {
            continue;
        }

        auto b = _findBrick(_cells[i]);
        if (!b) 
        {
            continue;
        }

        BoardCoordinate c;
        switch (b->getBricktype())
        {
        case liggande:
            c.width = 2;
            c.height = 1;
            
            //Plastic yellow color
            c.r = 210; 
            c.g = 214;
            c.b = 101;
            
            break;
        case staende:
            c.width = 1;
            c.height = 2;
            
            //Mint green color
            c.r = 92; 
            c.g = 189;
            c.b = 182;
            
            break;
        case mintman:
            c.width = 2;
            c.height = 2;
            
            //Plastic red color
            c.r = 247; 
            c.g = 129;
            c.b = 119;
             
            break;
        case liten:
            c.width = 1;
            c.height = 1;
            
            //Plastic red color
            c.r = 247; 
            c.g = 129;
            c.b = 119;
            
            break;
        default:
            continue;
        }
        c.x = x;
        c.y = y;
        output.push_back(c); 
    }
    return output;
}

Brick* Board::_findBrick(int id)
{
    for(int i=0; i < _bricks.size(); i++)
    {
        if(_bricks[i].getId()==id)
        {
            return &_bricks[i];
        }
    }
    return nullptr;
} 

bool Board::_translateBrick(int id, transition transition, const bricktype& bricktype)
{
    //Find current location
    int x = -1;
    int y = 0;
    for(int i=0; i < _cells.size(); i++)
    {
        x++;
        if (i != 0 && i % _width == 0)
        {
            y++;
            x = 0;
        }
        if(_cells[i]==id)
        {
            break;
        }
    }

    //If not present...
    if (x == -1) 
    {
        return false;
    }

    //Define transition
    int dy = 0;
    int dx = 0;
    switch (transition)
    {
    case left:
        dx = -1;
        break;
    case right:
        dx = 1;
        break;
    case down:
        dy = 1;
        break;
    case up:
        dy = -1;
        break;
    default:
        break;
    }

    if (_canPlace(x+dx,y+dy, bricktype, id)) {
        _setValue(x, y, bricktype, 0);
        _setValue(x+dx, y+dy, bricktype, id);  
        return true;
    }
    else
    {
        std::cerr << "Cannot perform translation " << "\n";
    }
    return false;
}

void Board::debug()
{
    std::cout << "Board [width: " << _width << ", height: " << _height << "]\n";
    //Iterera från vänster till höger, därefter nedåt 
    for (int k = 0; k < _cells.size(); k++)
    {
        if (k != 0 && k % _width == 0)
        {
            std::cout << "\n";
        }
        std::cout << _cells[k];
        if (k < _cells.size() -1) {
            std::cout <<  " "; 
        }
    }
    std::cout << "\n";
}

