/// @desc    Reads a JSON (string or struct) that contains profile data and verifies if it can be imported without error
/// @param   stringOrStruct
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_verify(_json, _profile_name, _player_index = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    //Make a clone of the current settings
    var _backup = input_profile_export(_profile_name, _player_index, false);
    
    var _error = undefined;
    try
    {
        global.__input_players[_player_index].__profile_import(_json, _profile_name);
    }
    catch(_error)
    {
        __input_trace("input_profile_verify() failed with the following error: ", _error);
    }
    
    //Restore the clone of the current settings
    input_profile_import(_backup, _profile_name, _player_index);
    
    return (_error == undefined);
}