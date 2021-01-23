/// @param verb
/// @param binding
/// @param [source]
/// @param [playerIndex]
/// @param [alternate]

function input_binding_set_safe()
{
    var _verb         = argument[0];
    var _binding      = argument[1];
    var _source       = (argument_count > 2)? argument[2] : undefined;
    var _player_index = ((argument_count > 3) && (argument[3] != undefined))? argument[3] : 0;
    var _alternate    = ((argument_count > 4) && (argument[4] != undefined))? argument[4] : 0;
    
    if (input_value_is_binding(_binding))
    {
        var _collisions = input_binding_get_collisions(_binding, _source, _player_index);
        if (array_length(_collisions) == 0)
        {
            input_binding_set(_verb, _binding, _source, _player_index, _alternate);
        }
        else
        {
            if (array_length(_collisions) > 1)
            {
                __input_trace("Warning! More than one binding collision found, resolution may not be desirable");
            }
            
            __input_trace("Collision found with verb=", _collisions[0].verb, ", alternate=", _collisions[0].alternate);
            
            input_binding_swap(_verb, _alternate, _collisions[0].verb, _collisions[0].alternate, _source, _player_index);
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