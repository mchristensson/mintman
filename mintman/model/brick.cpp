#include "brick.h"

Brick::Brick(bricktype bricktype, int id) : _bricktype(bricktype), _id(id)
{
}

Brick::Brick()
{
}

bricktype Brick::getBricktype() const
{
    return _bricktype;
}

int Brick::getId() const
{
    return _id;
}