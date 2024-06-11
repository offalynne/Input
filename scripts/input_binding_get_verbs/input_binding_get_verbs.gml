// Feather disable all
/// @desc    Returns an array of structs containing verb/alternate indexes matching a binding
/// @param   binding
/// @param   [playerIndex=0]
/// @param   [profileName]

function input_binding_get_verbs(_binding, _player_index = 0, _profile_name = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    if (!input_value_is_binding(_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    var _output_array = [];
    
    with(_global.__players[_player_index])
    {
        //Get the profile for this particular binding
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot get verbs from binding, profile was <undefined>");
            return _output_array;
        }
        
        //Iterate over every verb
        var _v = 0;
        repeat(array_length(_global.__basic_verb_array))
        {
            var _verb = _global.__basic_verb_array[_v];
            
            //Iterate over every alternate binding
            var _alternate_index = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                //Pick up a binding
                //If this hasn't been defined for the player then it falls through and uses the default binding
                var _extant_binding = __binding_get(_profile_name, _verb, _alternate_index, false);
                    
                //A lot of alternate binding slots don't get used so they return <undefined>
                if (is_struct(_extant_binding) && (_extant_binding.__label == _binding.__label))
                {
                    array_push(_output_array, { __verb: _verb, __alternate: _alternate_index });
                }
                    
                ++_alternate_index;
            }
            
            ++_v;
        }
    }
    
    return _output_array;
}
