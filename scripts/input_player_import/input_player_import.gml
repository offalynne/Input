/// @desc    Reads a JSON (string or struct) that contains player data and replaces the given player's data with it
/// @param   [string]
/// @param   [playerIndex=0]

function input_player_import(_string, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__import(_string);
}