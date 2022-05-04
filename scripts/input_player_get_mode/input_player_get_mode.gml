/// @param [playerIndex]

function input_player_get_mode(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__behaviour_get();
}
