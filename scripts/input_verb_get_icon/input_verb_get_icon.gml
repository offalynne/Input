/// @desc    Returns the icon defined in __input_config_icons() for the given verb, taking into account the player's currently assigned source(s)
/// @param   verb
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_verb_get_icon(_verb_name, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
    return input_binding_get_icon(input_binding_get(_verb_name, _player_index, _alternate, _profile_name), _player_index);
}