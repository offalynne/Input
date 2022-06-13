/// @desc    Returns an array containing all the sources assigned to the player
/// @param   [playerIndex=0]

function input_source_get_array(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__source_array;
}