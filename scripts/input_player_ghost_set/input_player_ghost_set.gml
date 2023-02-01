/// @desc    Sets whether the player is a "ghost" or not
/// @param   state
/// @param   [playerIndex=0]

function input_player_ghost_set(_state, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (global.__input_players[_player_index].__ghost == _state) return;
    global.__input_players[_player_index].__ghost = _state;
    
    if (_state) input_source_clear(_player_index);
}
