/// @param [playerIndex]

function input_player_set_ghost(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__set_ghost();
}
