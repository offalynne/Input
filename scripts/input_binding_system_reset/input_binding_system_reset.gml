/// @param source
/// @param [playerIndex]
/// @param [resetThresholds]

function input_binding_system_reset(_source, _player_index = all, _reset_thresholds = true)
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
    
    if (_source == INPUT_SOURCE.GHOST)
    {
        __input_trace("Warning! Cannot reset bindings for INPUT_SOURCE.GHOST");
        return undefined;
    }
    
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_binding_system_reset(_source, _i);
            ++_i;
        }
        
        return undefined;
    }
    
    if (_source == all)
    {
        var _i = 0;
        repeat(array_length(global.__input_config_name_names))
        {
            input_binding_system_reset(global.__input_config_name_names[_i], _player_index);
            ++_i;
        }
        
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        //Convert the source enum to a config name if necessary
        var _config_name = convert_source_enum_to_config_name(_source);
        
        __input_trace("Resetting ", _config_name, " bindings for player ", _player_index);
        
        var _v = 0;
        repeat(array_length(global.__input_verb_array))
        {
            var _verb = global.__input_verb_array[_v];
            
            var _alternate = 0;
            repeat(INPUT_MAX_ALTERNATE_BINDINGS)
            {
                __reset_binding(_config_name, _verb, _alternate);
                ++_alternate;
            }
            
            ++_v;
        }
        
        if (_reset_thresholds)
        {
            config.axis_thresholds = {};
        }
    }
}