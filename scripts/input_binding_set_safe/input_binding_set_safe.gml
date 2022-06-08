/// @desc    Sets the binding for the given verb. The alternate index parameter can be used to
///          set multiple parallel inputs for one verb. If no profile name is provided, the
///          current profile is used.
///          
///          This function, in contrast to input_binding_set(), will try to automatically
///          resolve conflicts based on verb groups defined in INPUT_VERB_GROUPS. This function
///          is effective for simple control schemes but may fail in more complex situations;
///          in these cases, you’ll need to handle conflict resolution yourself.
///          
/// @param   verb
/// @param   binding
/// @param   [playerIndex=0]
/// @param   [alternate=0]
/// @param   [profileName]

function input_binding_set_safe(_verb_name, _binding, _player_index = 0, _alternate = 0, _profile_name = undefined)
{
	__input_initialize();
    __INPUT_VERIFY_BASIC_VERB_NAME
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    
    if (input_value_is_binding(_binding))
    {
        var _collisions = input_binding_test_collisions(_verb_name, _binding, _player_index, _profile_name);
        if (array_length(_collisions) == 0)
        {
            input_binding_set(_verb_name, _binding, _player_index, _alternate);
        }
        else
        {
            if (array_length(_collisions) > 1)
            {
                __input_trace("Warning! More than one binding collision found, resolution may not be desirable");
            }
            
            _profile_name = global.__input_players[_player_index].__profile_get(_profile_name);
            
            if (_profile_name == undefined)
            {
                __input_trace("Warning! Cannot set binding, profile was <undefined>");
                return false;
            }
            
            var _verb_b      = _collisions[0].verb;
            var _alternate_b = _collisions[0].alternate;
            
            if ((_verb_name != _verb_b) || (_alternate != _alternate_b))
            {
                __input_trace("Collision found in profile=", _profile_name, ", verb=", _verb_b, ", alternate=", _alternate_b);
                input_binding_swap(_verb_name, _alternate, _verb_b, _alternate_b, _player_index, _profile_name);
                
                //We have to force set the new binding in case we had a gamepad collision in multidevice mode with an existing binding without a specific gamepad index
                input_binding_set(_verb_name, _binding, _player_index, _alternate, _profile_name);
            }
            else
            {
                __input_trace("New binding (", input_binding_get_name(_binding), ") is the same as existing binding for profile=", _profile_name, ", verb=", _verb_name, ", alternate=", _alternate);
            }
        }
        
        input_consume(_verb_name, _player_index);
        return true;
    }
    else
    {
        __input_trace("Warning! Value isn't a binding, ignoring");
        return false;
    }
}