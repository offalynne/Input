/// @desc    Sets the movement speed for the cursor when using keyboard or gamepad input
/// @param   speed
/// @param   [playerIndex=0]

function input_cursor_speed_set(_speed, _player_index = 0)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_speed_set(_speed, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__cursor.__speed = _speed;
}