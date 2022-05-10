/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate=0]
/// @param [profileName]

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
            
            var _profile_name = global.__input_players[_player_index].__profile_get(_profile_name);
            var _verb_b      = _collisions[0].verb;
            var _alternate_b = _collisions[0].alternate;
            
            if ((_verb_name != _verb_b) || (_alternate != _alternate_b))
            {
                __input_trace("Collision found in profile=", _profile_name, ", verb=", _verb_b, ", alternate=", _alternate_b);
                input_binding_swap(_verb_name, _alternate, _verb_b, _alternate_b, _profile_name, _player_index);
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
        __input_trace("Value isn't a binding, ignoring");
        return false;
    }
}