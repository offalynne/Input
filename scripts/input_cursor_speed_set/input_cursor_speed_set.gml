/// @param speed
/// @param [playerIndex=0]

function input_cursor_speed_set(_speed, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__cursor.__speed = _speed;
}