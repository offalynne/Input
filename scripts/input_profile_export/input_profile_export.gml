/// @desc    Outputs a string or struct containing the bindings and axis thresholds for the given profile
/// @param   profileName
/// @param   [playerIndex=0]
/// @param   [outputString=true]
/// @param   [prettify=false]

function input_profile_export(_profile_name, _player_index = 0, _output_string = true, _prettify = false)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_export(_profile_name, _output_string, _prettify);
}