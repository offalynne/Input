// Feather disable all
/// @desc    Returns whether the player is using the keyboard
/// @param   [playerIndex=0]

function input_player_using_keyboard(_player_index = 0)
{
    return input_source_using(INPUT_KEYBOARD, _player_index);
}
