/// @param [playerIndex=0]

function input_profile_get(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__get_profile_name();
}