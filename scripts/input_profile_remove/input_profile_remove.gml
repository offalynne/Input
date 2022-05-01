function input_profile_remove(_profile_name)
{
    if (!input_profile_exists(_profile_name))
    {
        __input_trace("Profile \"", _profile_name, "\" already exists");
        return;
    }
    
    if (variable_struct_exists(global.__input_default_profile_dict, _profile_name))
    {
        __input_error("Cannot remove profile \"", _profile_name, "\" as it is a default profile");
    }
    
    //FIXME - Implement
}