// Feather disable all
/// @desc    Sets whether the player is a "ghost" or not
/// @param   state
/// @param   [playerIndex=0]

function input_player_ghost_set(_state, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_player_ghost_set(_state, _i);
            ++_i;
        }
        
        return;
    }
    
    if (_global.__players[_player_index].__ghost == _state) return;
    _global.__players[_player_index].__ghost = _state;
    
    if (_state) input_source_clear(_player_index);
}
