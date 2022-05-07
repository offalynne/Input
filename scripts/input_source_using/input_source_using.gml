/// @param source
/// @param [playerIndex=0]

function input_source_using(_source, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__source_contains(_source);
}