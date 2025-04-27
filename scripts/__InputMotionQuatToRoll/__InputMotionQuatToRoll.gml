// Feather disable all

/// @param x
/// @param y
/// @param z
/// @param w

function __InputMotionQuatToRoll(_x, _y, _z, _w)
{
    return darctan2(2*(_w*_x + _y*_z), 1 - 2*(_x*_x + _y*_y));
}