/// @param source
/// @param [playerIndex]
/// @param [resetThresholds]

function input_bindings_reset(_source, _player_index = all, _reset_thresholds = true)
{
    if ((_player_index < 0) && (_player_index != all))
    {
        __input_error("Invalid player index provided (", _player_index, ")");
        return undefined;
    }
    
    if (_player_index >= INPUT_MAX_PLAYERS)
    {
        __input_error("Player index too large (", _player_index, " must be less than ", INPUT_MAX_PLAYERS, ")\nIncrease INPUT_MAX_PLAYERS to support more players");
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
        repeat(array_length(global.__input_config_category_names))
        {
            input_bindings_reset(global.__input_config_category_names[_i], _player_index);
            ++_i;
        }
        
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        //Convert the source enum to a config name if necessary
        var _config_category = convert_source_enum_to_config_category(_source);
        
        __input_trace("Resetting ", _config_category, " bindings for player ", _player_index);
        
        config[$ _config_category] = {};
        
        var _source_verb_struct = global.__input_default_player.config[$ _config_category];
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _v = 0;
            repeat(array_length(_verb_names))
            {
                var _verb = _verb_names[_v];
                var _alternate_array = _source_verb_struct[$ _verb];
                if (is_array(_alternate_array))
                {
                    var _alternate = 0;
                    repeat(array_length(_alternate_array))
                    {
                        var _binding = _alternate_array[_alternate];
                        if (is_struct(_binding)) set_binding(_config_category, _verb, _alternate, __input_binding_duplicate(_binding));
                        ++_alternate;
                    }
                }
                
                ++_v;
            }
        }
        
        if (_reset_thresholds)
        {
            config.axis_thresholds = {};
        }
    }
}