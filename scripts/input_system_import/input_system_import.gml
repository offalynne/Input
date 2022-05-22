/// @param stringOrStruct

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
    
    if (!is_struct(_json) && !is_array(_json))
    {
        __input_error("Input must be valid JSON (typeof=", _string, ")");
        return;
    }
    
    //Blank slate!
    input_system_reset();
    
    //Restore accessibility settings
    global.__input_toggle_momentary_state = _json.accessibility.momentary_state;
    global.__input_toggle_momentary_dict = {};
    
    var _momentary_verb_array = _json.accessibility.momentary_verbs;
    var _i = 0;
    repeat(array_length(_momentary_verb_array))
    {
        global.__input_toggle_momentary_dict[$ _momentary_verb_array[_i]] = true;
        ++_i;
    }
    
    //Restore mouse settings
    input_mouse_capture_set(_json.mouse.capture, _json.mouse.sensitivity);
    
    //Restore player data
    var _players_array = _json.players;
    var _p = 0;
    repeat(array_length(_players_array))
    {
        with(global.__input_players[_p]) __import(_players_array[_p]);
        ++_p;
    }
}