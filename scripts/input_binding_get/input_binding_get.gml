/// @desc    Returns the binding for the given verb. If no binding has been set, this function will return <undefined>
///          If no profile is provided, the current profile is used
/// @param   verb
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_binding_get(_verb_name, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
    __input_initialize();
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_BASIC_VERB_NAME
    __INPUT_VERIFY_PROFILE_NAME
    
    if (is_string(_player_index))
    {
        if (_player_index == "default")
        {
            if (_profile_name == undefined) __input_error("Source must be specified when getting a binding from the default player");
            
            with(global.__input_default_player)
            {
                return __binding_get(_profile_name, _verb_name, _alternate, false).__duplicate();
            }
        }
        else
        {
            __input_error("Player \"", _player_index, "\" not supported");
        }
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        return __binding_get(_profile_name, _verb_name, _alternate, true);
    }
    
    return undefined;
}