/// @param source
/// @param [playerIndex=0]

function input_source_set(_source, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_SOURCE
    __INPUT_VERIFY_SOURCE_ASSIGNABLE
    
    __input_source_relinquish(_source);
    global.__input_players[_player_index].__source_add(_source);
}