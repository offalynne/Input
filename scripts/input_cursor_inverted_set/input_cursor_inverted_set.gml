/// @desc    Sets whether the vertical axis is inverted for the cursor
/// @param   speed
/// @param   [playerIndex=0]

function input_cursor_inverted_set(_state, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_inverted_set(_state, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__cursor_inverted = _state;
}