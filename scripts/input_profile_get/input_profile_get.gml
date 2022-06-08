/// @desc    Returns the name of the currently active profile for the player
/// @param   [playerIndex=0]

function input_profile_get(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_get();
}