/// @desc    Sets whether vibration for the given player should be paused
/// 
/// @param   state
/// @param   [playerIndex=0]

function input_vibrate_set_pause(_state, _player_index = 0)
{
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_vibrate_set_pause(_state, _i);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__vibration_paused = _state;
}
