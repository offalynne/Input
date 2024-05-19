// Feather disable all
/// @desc    Returns whether the player is using touch input
/// @param   [playerIndex=0]

function input_player_using_touch(_player_index = 0)
{
    return input_source_using(INPUT_TOUCH, _player_index);
}
