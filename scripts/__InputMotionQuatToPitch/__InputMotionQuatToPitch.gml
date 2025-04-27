// Feather disable all

/// @param x
/// @param y
/// @param z
/// @param w

function __InputMotionQuatToPitch(_x, _y, _z, _w)
{
    return darcsin(clamp(2*(_w*_y - _z*_x), -1, 1));
}