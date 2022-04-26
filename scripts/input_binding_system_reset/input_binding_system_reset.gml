/// @param source
/// @param [playerIndex]
/// @param [resetThresholds]

function input_binding_system_reset(_source, _player_index = all, _reset_thresholds = true)
{
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
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_source == all)
    {
        var _i = 0;
        repeat(array_length(global.__input_config_name_array))
        {
            input_binding_system_reset(global.__input_config_name_array[_i], _player_index);
            ++_i;
        }
        
        return undefined;
    }
    
    with(global.__input_players[_player_index])
    {
        //Convert the source enum to a config name if necessary
        var _config_name = __get_config_name_from_source(_source);
        
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb = global.__input_basic_verb_array[_v];
            
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