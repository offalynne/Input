/// @param leftVerb
/// @param rightVerb
/// @param upVerb
/// @param downVerb
/// @param [playerIndex]

function input_direction(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined)
{
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index);
    if ((_result.x == 0) && (_result.y == 0)) return undefined;
    return point_direction(0, 0, _result.x, _result.y);
}