/// @param profileName
/// @param [playerIndex=0]

function input_profile_create(_profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_profile_name == "axis_thresholds")
    {
        __input_error("\"", _profile_name, "\" is an invalid profile name");
    }
    
    return global.__input_players[_player_index].__profile_create(_profile_name);
}