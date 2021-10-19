/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set_safe(_verb, _binding, _player_index = 0, _alternate = 0)
{
    if (input_value_is_binding(_binding))
    {
        var _collisions = input_binding_get_collisions(_binding, _player_index);
        if (array_length(_collisions) == 0)
        {
            input_binding_set(_verb, _binding, _player_index, _alternate);
        }
        else
        {
            if (array_length(_collisions) > 1)
            {
                __input_trace("Warning! More than one binding collision found, resolution may not be desirable");
            }
            
            var _config_category = global.__input_players[_player_index].get_binding_config_category(_binding);
            var _verb_b      = _collisions[0].verb;
            var _alternate_b = _collisions[0].alternate;
            
            if ((_verb != _verb_b) || (_alternate != _alternate_b))
            {
                __input_trace("Collision found with config=", _config_category, ", verb=", _verb_b, ", alternate=", _alternate_b);
                input_binding_swap(_verb, _alternate, _verb_b, _alternate_b, _config_category, _player_index);
            }
            else
            {
                __input_trace("New binding (", input_binding_get_name(_binding), ") is the same as existing binding for config=", _config_category, ", verb=", _verb, ", alternate=", _alternate);
            }
        }
        
        input_consume(_verb, _player_index);
        return true;
    }
    else
    {
        __input_trace("Value isn't a binding, ignoring");
        return false;
    }
}