/// @desc    Reads a JSON (string or struct) that contains profile data and replaces the given profile's data with it
/// @param   stringOrStruct
/// @param   profileName
/// @param   [playerIndex=0]

function input_profile_import(_json, _profile_name, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__profile_import(_json, _profile_name);
}