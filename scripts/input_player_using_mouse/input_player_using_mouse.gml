// Feather disable all
/// @desc    Returns whether the player is using the mouse
/// @param   [playerIndex=0]

function input_player_using_mouse(_player_index = 0)
{
    return input_source_using(INPUT_MOUSE, _player_index);
}
