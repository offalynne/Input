/// @param [playerIndex]

function input_player_get_gamepad_type(_player_index = 0)
{
    return input_gamepad_get_type(input_player_get_gamepad(_player_index));
}