/// @param binding
/// @param [playerIndex]
/// @param [profileName]

function input_binding_get_collisions(_src_binding, _player_index = 0, _profile_name = undefined)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    if (!input_value_is_binding(_src_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    var _output_array = [];
    
    with(global.__input_players[_player_index])
    {
        //Get the profile for this particular binding
        var _profile_name = __get_profile_struct(_profile_name);
        
        //Iterate over every verb
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb = global.__input_basic_verb_array[_v];
            
            //Iterate over every alternate binding
            var _alternate_index = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                //Pick up a binding
                //If this hasn't been defined for the player then it falls through and uses the default binding
                var _extant_binding = __binding_get(_profile_name, _verb, _alternate_index);
                
                //A lot of alternate binding slots don't get used so they return <undefined>
                if (is_struct(_extant_binding))
                {
                    if ((_extant_binding.type          == _src_binding.type)
                    &&  (_extant_binding.value         == _src_binding.value)
                    &&  (_extant_binding.axis_negative == _src_binding.axis_negative))
                    {
                        array_push(_output_array, { verb: _verb, alternate: _alternate_index });
                    }
                }
                
                ++_alternate_index;
            }
            
            ++_v;
        }
    }
    
    return _output_array;
}