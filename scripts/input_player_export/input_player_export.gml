/// @param [playerIndex=0]
/// @param [outputString=true]
/// @param [prettify=false]

function input_player_export(_player_index = 0, _output_string = true, _prettify = false)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__export(_output_string, _prettify);
}