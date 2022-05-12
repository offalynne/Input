/// @param verb
/// @param binding
/// @param [playerIndex=0]
/// @param [profileName]

function input_binding_test_collisions(_verb_name, _src_binding, _player_index = 0, _profile_name = undefined)
{
	__input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_PROFILE_NAME
    
    if (!input_value_is_binding(_src_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    var _src_groups_array = input_verb_get_collision_groups(_verb_name);
    
    var _output_array = [];
    
    with(global.__input_players[_player_index])
    {
        //Get the profile for this particular binding
        _profile_name = __profile_get(_profile_name);
        
        if (_profile_name == undefined)
        {
            __input_trace("Warning! Cannot test binding collisions, profile was <undefined>");
            return _output_array;
        }
        
        //Iterate over every verb
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb = global.__input_basic_verb_array[_v];
            
            var _group_matches = false;
            
            //If the incoming groups array is undefined then the incoming binding is in every group
            if (_src_groups_array == undefined)
            {
                _group_matches = true;
            }
            else
            {
                var _dst_groups_array = input_verb_get_collision_groups(_verb);
                
                //If the incoming groups array is undefined then the incoming binding is in every group
                if (_dst_groups_array == undefined)
                {
                    _group_matches = true;
                }
                else
                {
                    //Check if there's any overlap between the incoming group array and the verb
                    var _j = 0;
                    repeat(array_length(_src_groups_array))
                    {
                        var _src_group = _src_groups_array[_j];
                    
                        var _k = 0;
                        repeat(array_length(_dst_groups_array))
                        {
                            if (_dst_groups_array[_k] == _src_group)
                            {
                                _group_matches = true;
                                break;
                            }
                            
                            ++_k;
                        }
                        
                        if (_group_matches) break;
                        ++_j;
                    }
                }
            }
            
            //Only check for specific binding collisions if the verb groups collide
            if (_group_matches)
            {
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
            }
            
            ++_v;
        }
    }
    
    return _output_array;
}