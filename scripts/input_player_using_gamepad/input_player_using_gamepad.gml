// Feather disable all
/// @desc    Returns whether the player is using a gamepad
/// @param   [playerIndex=0]

function input_player_using_gamepad(_player_index = 0)
{
    return input_source_using(INPUT_GAMEPAD, _player_index);
}
