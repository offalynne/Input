/// @desc    Returns the x-coordinate of the vector represented by the sum of the verb values
/// @param   leftVerb
/// @param   rightVerb
/// @param   upVerb
/// @param   downVerb
/// @param   [playerIndex=0]
/// @param   [mostRecent=false]

function input_x(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = false)
{
    return (input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent)).x;
}