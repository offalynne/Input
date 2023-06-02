/// @desc    Sets the binding for the given verb. The alternate index parameter can be used to
///          set multiple parallel inputs for one verb. If no profile name is provided, the
///          current profile is used
/// @param   verb
/// @param   binding
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_binding_set(_verb_name, _binding, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_BASIC_VERB_NAME
    __INPUT_VERIFY_PROFILE_NAME
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    _global.__players[_player_index].__binding_set(_profile_name, _verb_name, _alternate, _binding);
    
    //Ensure verb state doesn't leak through anywhere
    input_verb_consume(all, _player_index);
}