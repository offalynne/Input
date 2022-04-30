/// @param [playerIndex=0]

function input_player_set_profile_automatically(_player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _profile_name = global.__input_players[_player_index].__get_automatic_profile_name();
    if (_profile_name != undefined) global.__input_players[_player_index].__profile_name = _profile_name;
}