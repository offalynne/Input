// Feather disable all

/// @param x
/// @param y
/// @param z
/// @param w

function __InputMotionQuatToYaw(_x, _y, _z, _w)
{
    return darctan2(2*(_w*_z + _x*_y), 1 - 2*(_y*_y + _z*_z));
}