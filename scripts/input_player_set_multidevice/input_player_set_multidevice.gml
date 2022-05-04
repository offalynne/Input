/// @param [playerIndex]

function input_player_set_multidevice(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__behaviour_set(INPUT_BEHAVIOUR.MULTI);
}
