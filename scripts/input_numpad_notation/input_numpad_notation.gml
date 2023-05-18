/// @desc    Returns the direction of the vector represented by the sum of the verb values in numpad notation
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]
/// @param   [mostRecent=false]

function input_numpad_notation(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = false)
{
    static _numpad_array = [6, 9, 8, 7, 4, 1, 2, 3];    
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent);
    if ((_result.x == 0) && (_result.y == 0)) return 5;    
    return _numpad_array[round((point_direction(0, 0, _result.x, _result.y))/45) mod 8];
}
