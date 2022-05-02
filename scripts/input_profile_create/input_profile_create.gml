/// @param profileName
/// @param [playerIndex=0]

function input_profile_create(_profile_name, _player_index = 0)
{
    if (input_profile_exists(_profile_name)) __input_error("Profile \"", _profile_name, "\" already exists");
    
    //FIXME - Implement
}