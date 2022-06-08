/// @desc    Returns the speed of the cursor when using keyboard or gamepad input
/// @param   [playerIndex=0]

function input_cursor_speed_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__speed;
}