/// @desc    Outputs a string or struct containing all player and accessibility data
/// @param   [outputString=true]
/// @param   [prettify=false]

function input_system_export(_output_string = true, _prettify = false)
{
    var _players_array = array_create(INPUT_MAX_PLAYERS, undefined);
    
    var _root_json = {
        accessibility: {
            momentary_state: global.__input_toggle_momentary_state,
            momentary_verbs: variable_struct_get_names(global.__input_toggle_momentary_dict),
            cooldown_state:  global.__input_cooldown_state,
            cooldown_verbs:  variable_struct_get_names(global.__input_cooldown_dict),
        },
        
        mouse: {
            capture:     global.__input_mouse_capture,
            sensitivity: global.__input_mouse_capture_sensitivity,
        },
        
        players: _players_array,
    };
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        with(global.__input_players[_p]) _players_array[@ _p] = __export();
        ++_p;
    }
    
    if (_output_string)
    {
        if (_prettify)
        {
            return __input_snap_to_json(_root_json, true, true);
        }
        else
        {
            return json_stringify(_root_json);
        }
    }
    else
    {
        return _root_json;
    }
}