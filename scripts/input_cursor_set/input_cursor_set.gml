/// @desc    Sets the position of the player's cursor
/// @param   x
/// @param   y
/// @param   [playerIndex=0]
/// @param   [relative=false]

function input_cursor_set(_x, _y, _player_index = 0, _relative = false)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_set(_x, _y, _p, _relative);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__cursor.__set(_x, _y, _relative);
}