/// @param binding
/// @param [playerIndex]

function input_binding_get_collisions(_src_binding, _player_index = 0)
{
    if (_player_index < 0)
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (!input_value_is_binding(_src_binding))
    {
        __input_error("Value provided is not a binding");
        return undefined;
    }
    
    var _output_array = [];
    
    with(global.__input_players[_player_index])
    {
        var _source_verb_struct = config[$ get_binding_config_category(_src_binding)];
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb = _verb_names[_v];
                
                var _alternate_array = _source_verb_struct[$ _verb];
                var _a = 0;
                repeat(array_length(_alternate_array))
                {
                    var _binding = _alternate_array[_a];
                    if (is_struct(_binding))
                    {
                        if ((_binding.type          == _src_binding.type)
                        &&  (_binding.value         == _src_binding.value)
                        &&  (_binding.axis_negative == _src_binding.axis_negative))
                        {
                            array_push(_output_array, { verb: _verb, alternate: _a });
                        }
                    }
                    
                    ++_a;
                }
                
                ++_v;
            }
        }
    }
    
    return _output_array;
}