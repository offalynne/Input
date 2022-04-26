/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set_safe(_verb_name, _binding, _player_index = 0, _alternate = 0)
{
	__input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    __INPUT_VERIFY_ALTERNATE_INDEX
    __INPUT_VERIFY_BASIC_VERB_NAME
    
    if (input_value_is_binding(_binding))
    {
        var _collisions = input_binding_get_collisions(_binding, _player_index);
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
            
            var _config_name = global.__input_players[_player_index].__get_config_name_from_binding(_binding);
            var _verb_b      = _collisions[0].verb;
            var _alternate_b = _collisions[0].alternate;
            
            if ((_verb_name != _verb_b) || (_alternate != _alternate_b))
            {
                __input_trace("Collision found with config=", _config_name, ", verb=", _verb_b, ", alternate=", _alternate_b);
                input_binding_swap(_verb_name, _alternate, _verb_b, _alternate_b, _config_name, _player_index);
            }
            else
            {
                __input_trace("New binding (", input_binding_get_name(_binding), ") is the same as existing binding for config=", _config_name, ", verb=", _verb_name, ", alternate=", _alternate);
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