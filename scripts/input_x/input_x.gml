/// @param leftVerb
/// @param rightVerb
/// @param upVerb
/// @param downVerb
/// @param [playerIndex]

function input_x(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined)
{
    return (input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index)).x;
}