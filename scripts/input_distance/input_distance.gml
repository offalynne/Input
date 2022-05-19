/// @param leftVerb
/// @param rightVerb
/// @param upVerb
/// @param downVerb
/// @param [playerIndex]
/// @param [mostRecent]

function input_distance(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = false)
{
    var _result = input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent);
    return point_distance(0, 0, _result.x, _result.y);
}