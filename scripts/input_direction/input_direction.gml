// Feather disable all
/// @desc    Returns the direction of the vector represented by the sum of the verb values
/// @param   default
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]
/// @param   [mostRecent]

function input_direction(_default, _verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = INPUT_DEFAULT_2D_MOST_RECENT)
{
    if (is_string(_default)) __input_error("Usage of input_direction() has changed. Please refer to documentation for details");
    
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent);
    if ((_result.x == 0) && (_result.y == 0)) return _default;
    return point_direction(0, 0, _result.x, _result.y);
}
