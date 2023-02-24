/// @desc    Returns the icon defined in __input_config_icons() for the given verb, taking into account the player's currently assigned source(s)
/// @param   verb
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_binding_get_icon(_verb_name, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
    if (!is_string(_verb_name))
    {
        __input_error("Usage of input_binding_get_icon() has changed\nYou may want to use input_binding_get_icon_ext() instead\nPlease refer to documentation for more details");
    }
    
    return input_binding_get_icon_ext(input_binding_get(_verb_name, _player_index, _alternate, _profile_name), _player_index);
}