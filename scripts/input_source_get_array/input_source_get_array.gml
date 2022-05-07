/// @param [playerIndex=0]

function input_source_get_array()
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__source_array;
}