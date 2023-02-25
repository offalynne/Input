/// @desc    Reads a JSON (string or struct) that contains Input system data and replaces the current data with it
/// @param   stringOrStruct

function input_system_import(_string)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
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
        return;
    }
    
    //Blank slate!
    input_system_reset();
    
    //Restore accessibility settings
    if (!is_struct(_json[$ "accessibility"]))
    {
        __input_error("Accessibility settings are missing from JSON");
        return;
    }
    
    //Momentary toggle verbs
    _global.__toggle_momentary_state = _json.accessibility.momentary_state;
    _global.__toggle_momentary_dict = {};
    
    var _momentary_verb_array = _json.accessibility.momentary_verbs;
    if (!is_array(_momentary_verb_array))
    {
        __input_error("Momentary toggle verbs are corrupted");
        return;
    }
    
    var _i = 0;
    repeat(array_length(_momentary_verb_array))
    {
        _global.__toggle_momentary_dict[$ _momentary_verb_array[_i]] = true;
        ++_i;
    }
    
    //Cooldown verbs
    _global.__cooldown_state = _json.accessibility.cooldown_state;
    _global.__cooldown_dict = {};
    
    var _cooldown_verb_array = _json.accessibility.cooldown_verbs;
    if (!is_array(_cooldown_verb_array))
    {
        __input_error("Cooldown verbs are corrupted");
        return;
    }
    
    var _i = 0;
    repeat(array_length(_cooldown_verb_array))
    {
        _global.__cooldown_dict[$ _cooldown_verb_array[_i]] = true;
        ++_i;
    }
    
    //Restore mouse settings
    if (!is_struct(_json[$ "mouse"]))
    {
        __input_error("Mouse settings are missing from JSON");
        return;
    }
    
    input_mouse_capture_set(_json.mouse.capture, _json.mouse.sensitivity);
    
    //Restore player data
    if (!is_array(_json[$ "players"]))
    {
        __input_error("Player settings are missing from JSON");
        return;
    }
    
    var _players_array = _json.players;
    if (!is_array(_players_array))
    {
        __input_error("Player settings are corrupted");
        return;
    }
    
    if (array_length(_players_array) != array_length(_global.__players))
    {
        __input_error("Player settings length mismatch\nFound ", array_length(_players_array), " players in JSON but we are expecting ", array_length(_global.__players), " players");
        return;
    }
    
    var _p = 0;
    repeat(array_length(_players_array))
    {
        with(_global.__players[_p]) __import(_players_array[_p]);
        ++_p;
    }
}