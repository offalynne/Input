// Feather disable all
/// @desc    Returns whether the vector represented by the sum of the verb values points to the radial sector indicated by angle and magnitude bounds
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [minAngle=0]
/// @param   [maxAngle=360]
/// @param   [minMagnitude=0]
/// @param   [maxMagnitude=1]
/// @param   [playerIndex=0]

function input_radial_sector(_verb_l, _verb_r, _verb_u, _verb_d, _angle_min = 0, _angle_max = 360, _magnitude_min = 0, _magnitude_max = 1, _player_index = undefined)
{
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, false);
    
    //Magnitude bound
    var _distance = point_distance(0, 0, _result.x, _result.y);
    if ((_distance <= max(0, _magnitude_min)) || (_distance > _magnitude_max)) return false;
    
    //Angle bound
    if (angle_difference(_angle_min, _angle_max) == 0.0) return true;
    
    //Angle difference
    _angle_min = _angle_min mod 360;
    if (_angle_min < 0.0) _angle_min += 360;

    _angle_max = _angle_max mod 360 - _angle_min;
    if (_angle_max < 0.0) _angle_max += 360;

    var _direction = point_direction(0, 0, _result.x, _result.y) - _angle_min;
    if (_direction < 0.0) _direction += 360;
    
    return (_direction < _angle_max); 
}
