/// @param verb
/// @param binding
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set_safe()
{
    var _verb         = argument[0];
    var _binding      = argument[1];
    var _player_index = ((argument_count > 2) && (argument[2] != undefined))? argument[2] : 0;
    var _alternate    = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;
    
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
            
            var _source      = __input_binding_get_source(_binding);
            var _verb_b      = _collisions[0].verb;
            var _alternate_b = _collisions[0].alternate;
            
            if ((_verb != _verb_b) || (_alternate != _alternate_b))
            {
                __input_trace("Collision found with source=", input_source_get_name(_source), ", verb=", _verb_b, ", alternate=", _alternate_b);
                input_binding_swap(_verb, _alternate, _verb_b, _alternate_b, _source, _player_index);
            }
            else
            {
                __input_trace("New binding (", input_binding_get_name(_binding), ") is the same as existing binding for source=", input_source_get_name(_source), ", verb=", _verb, ", alternate=", _alternate);
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