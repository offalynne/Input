/// @desc    Reads a JSON (string or struct) that contains Input system data and replaces the current data with it.
/// @param   stringOrStruct

function input_system_import(_string)
{
    if (is_string(_string))
    {
        var _json = json_parse(_string);
    }
    else
    {
        var _json = _string;
    }
    
    if (!is_struct(_json))
    {
        __input_error("Input must be valid JSON (typeof=", typeof(_string), ")");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___INVALID_JSON,
        };
    }
    
    //Blank slate!
    input_system_reset();
    
    //Restore accessibility settings
    if (!is_struct(_json[$ "accessibility"]))
    {
        __input_error("Accessibility settings are missing from JSON");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___ACCESSIBILITY_MISSING,
        };
    }
    
    //Momentary toggle verbs
    global.__input_toggle_momentary_state = _json.accessibility.momentary_state;
    global.__input_toggle_momentary_dict = {};
    
    var _momentary_verb_array = _json.accessibility.momentary_verbs;
    if (!is_array(_momentary_verb_array))
    {
        __input_error("Momentary toggle verbs are corrupted");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___MOMENTARY_TOGGLE_VERBS_MISSING,
        };
    }
    
    var _i = 0;
    repeat(array_length(_momentary_verb_array))
    {
        global.__input_toggle_momentary_dict[$ _momentary_verb_array[_i]] = true;
        ++_i;
    }
    
    //Cooldown verbs
    global.__input_cooldown_state = _json.accessibility.cooldown_state;
    global.__input_cooldown_dict = {};
    
    var _cooldown_verb_array = _json.accessibility.cooldown_verbs;
    if (!is_array(_cooldown_verb_array))
    {
        __input_error("Cooldown verbs are corrupted");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___COOLDOWN_VERBS_MISSING,
        };
    }
    
    var _i = 0;
    repeat(array_length(_cooldown_verb_array))
    {
        global.__input_cooldown_dict[$ _cooldown_verb_array[_i]] = true;
        ++_i;
    }
    
    //Restore mouse settings
    if (!is_struct(_json[$ "mouse"]))
    {
        __input_error("Mouse settings are missing from JSON");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___MOUSE_SETTINGS_MISSING,
        };
    }
    
    input_mouse_capture_set(_json.mouse.capture, _json.mouse.sensitivity);
    
    //Restore player data
    if (!is_array(_json[$ "players"]))
    {
        __input_error("Player settings are missing from JSON");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___PLAYER_SETTINGS_MISSING,
        };
    }
    
    var _players_array = _json.players;
    if (!is_array(_players_array))
    {
        __input_error("Player settings are corrupted");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___PLAYER_SETTINGS_MISSING,
        };
    }
    
    if (array_length(_players_array) != array_length(global.__input_players))
    {
        __input_error("Player settings length mismatch\nFound ", array_length(_players_array), " players in JSON but we are expecting ", array_length(global.__input_players), " players");
        
        return {
            scope: "system",
            error: INPUT_IMPORT_ERROR.SYSTEM___PLAYER_LENGTH_MISMATCH,
        };
    }
    
    var _p = 0;
    repeat(array_length(_players_array))
    {
        with(global.__input_players[_p])
        {
            var _error = __import(_players_array[_p]);
            if (_error != undefined) return _error;
        }
        
        ++_p;
    }
}