function input_profile_add(_profile_name)
{
    if (input_profile_exists(_profile_name)) __input_error("Profile \"", _profile_name, "\" already exists");
    
    //FIXME - Implement
}