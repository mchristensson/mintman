#include "bricktype.h"

class Brick 
{
public:
    Brick(bricktype bricktype, int id);
    Brick();

public:
    bricktype getBricktype() const;
    int getId() const;

private:
    bricktype _bricktype;
    int _id;
};