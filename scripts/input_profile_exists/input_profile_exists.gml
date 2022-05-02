/// @param profileName
/// @param [playerIndex=0]

function input_profile_exists(_profile_name, _player_index = 0)
{
    return variable_struct_exists(global.__input_profile_dict, _profile_name);
}