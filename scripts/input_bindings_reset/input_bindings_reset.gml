/// @param [source]
/// @param [playerIndex]

function input_bindings_reset()
{
    var _source       = (argument_count > 0)? argument[0] : all;
    var _player_index = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : all;
    
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " vs. ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
        return undefined;
    }
    
    if (((_source < 0) || (_source >= INPUT_SOURCE.__SIZE)) && (_source != all))
    {
        __input_error("Source (", _source, ") not recognised\nPlease use the INPUT_SOURCE enum");
        return undefined;
    }
    
    if (_source == INPUT_SOURCE.NONE)
    {
        __input_trace("Warning! Cannot reset bindings for INPUT_SOURCE.NONE");
        return undefined;
    }
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_bindings_reset(_source, _i);
            ++_i;
        }
        
        return undefined;
    }
    
    if (_source == all)
    {
        var _i = 0;
        repeat(INPUT_SOURCE.__SIZE)
        {
            if (_i != INPUT_SOURCE.NONE) input_bindings_reset(_i, _player_index);
            ++_i;
        }
        
        return undefined;
    }
    
    __input_trace("Resetting ", input_source_get_name(_source), " bindings for player ", _player_index);
    
    with(global.__input_players[_player_index])
    {
        config[$ _source] = {};
        
        var _source_verb_struct = variable_struct_get(global.__input_default_player.config, global.__input_source_names[_source]);
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb = _verb_names[_v];
                var _alternate_array = variable_struct_get(_source_verb_struct, _verb);
                if (is_array(_alternate_array))
                {
                    var _alternate = 0;
                    repeat(array_length(_alternate_array))
                    {
                        var _binding = _alternate_array[_alternate];
                        if (is_struct(_binding)) set_binding(_source, _verb, _alternate, __input_binding_duplicate(_binding));
                        ++_alternate;
                    }
                }
                
                ++_v;
            }
        }
    }
}