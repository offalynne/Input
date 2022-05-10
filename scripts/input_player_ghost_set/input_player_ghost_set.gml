/// @param state
/// @param [playerIndex=0]

function input_player_ghost_set(_state, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__ghost = _state;
}
