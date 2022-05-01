/// @param profileName

function input_profile_exists(_profile_name)
{
    return variable_struct_exists(global.__input_profile_dict, _profile_name);
}