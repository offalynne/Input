/// @desc    Returns the y-coordinate of the vector represented by the sum of the verb values
/// @param   {String} _verb_l
/// @param   {String} _verb_r
/// @param   {String} _verb_u
/// @param   {String} _verb_d
/// @param   {Real} _player_index
/// @param   {Bool} _most_recent

function input_y(_verb_l, _verb_r, _verb_u, _verb_d, _player_index = undefined, _most_recent = false)
{
    return (input_xy(_verb_l, _verb_r, _verb_u, _verb_d, _player_index, _most_recent)).y;
}