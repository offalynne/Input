/// @desc    Returns the direction of the vector represented by the sum of the verb values
/// @param   directionDefault
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]
/// @param   [mostRecent=false]

function input_direction(_direction_default, _verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = false)
{
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent);
    if ((_result.x == 0) && (_result.y == 0)) return (_direction_default mod 360);
    return point_direction(0, 0, _result.x, _result.y);
}