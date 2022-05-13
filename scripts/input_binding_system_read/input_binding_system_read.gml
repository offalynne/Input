/// @param stringOrJSON
/// @param [playerIndex]

function input_binding_system_read(_input_json, _player_index = all)
{
    if (__INPUT_ON_WEB) __input_error("Due to up-stream bug in GameMaker's JavaScript runtime, input_binding_system_read() and input_binding_system_write() are unsupported in HTML5");
    
    if (is_string(_input_json)) _input_json = json_parse(_input_json);
    
    if (!is_struct(_input_json) && !is_array(_input_json))
    {
        __input_error("Input must be valid JSON (typeof=", _input_json, ")");
        return;
    }
    
    if (_player_index == all)
    {
        if (!is_array(_input_json)) __input_error("JSON malformed, top-level should be an array");
        if (array_length(_input_json) != INPUT_MAX_PLAYERS) __input_error("JSON malformed, top-level array should have ", INPUT_MAX_PLAYERS, " players, but it had ", array_length(_input_json), " elements");
        
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_binding_system_read(_input_json[_i], _i);
            ++_i;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!is_struct(_input_json)) __input_error("JSON malformed, player ", _player_index, " data should be a struct, but it was ", typeof(_input_json));
    
    if (variable_struct_names_count(_input_json) != 2)
    {
        __input_error("JSON malformed, player ", _player_index, " data should have 2 child objects, but it had ", variable_struct_names_count(_input_json));
    }
    
    if (!variable_struct_exists(_input_json, "profiles")) __input_error("JSON malformed, player ", _player_index, " data missing \"profiles\" child object");
    if (!variable_struct_exists(_input_json, "axis_thresholds")) __input_error("JSON malformed, player ", _player_index, " data missing \"axis_thresholds\" child object");
    
    //Start from a clean slate
    input_binding_system_reset(_player_index, true);
    
    with(global.__input_players[_player_index])
    {
        var _profiles_dict = _input_json.profiles;
        
        //Iterate over every profile in the input
        var _profile_name_array = variable_struct_get_names(_profiles_dict);
        var _f = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_f];
            
            //Make sure the player has this particular profile set up
            __profile_ensure(_profile_name);
            var _existing_verb_dict = __profiles_dict[$ _profile_name];
            
            //Iterate over every verb
            var _profile_struct = _profiles_dict[$ _profile_name];
            var _v = 0;
            repeat(array_length(global.__input_basic_verb_array))
            {
                var _verb_name = global.__input_basic_verb_array[_v];
                
                var _existing_alternate_array = _existing_verb_dict[$ _verb_name];
                var _alternate_array = _profile_struct[$ _verb_name];
                
                //Verify that the input data has this verb
                if (!is_array(_alternate_array)) __input_error("Player ", _player_index, " data is missing verb \"", _verb_name, "\"");
                
                if (array_length(_alternate_array) != INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    __input_error("JSON malformed, player ", _player_index, " verb \"", _verb_name, "\" should have ", INPUT_MAX_ALTERNATE_BINDINGS, " alternate bindings, but it had ", array_length(_alternate_array));
                }
                
                //Iterate over every alternate and import the value into our local data
                var _a = 0;
                repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    _existing_alternate_array[@ _a].__import(_alternate_array[_a]);
                    ++_a;
                }
                
                ++_v;
            }
            
            ++_f;
        }
        
        //Copy axis threshold data
        var _axis_thresholds_dict = _input_json.axis_thresholds;
        var _axis_name_array = variable_struct_get_names(_axis_thresholds_dict);
        var _a = 0;
        repeat(array_length(_axis_name_array))
        {
            var _axis_name = _axis_name_array[_a];
            var _new_thresholds_struct = _axis_thresholds_dict[$ _axis_name];
            
            __axis_thresholds_dict[$ _axis_name] = {
                mini: _new_thresholds_struct.mini,
                maxi: _new_thresholds_struct.maxi,
            };
            
            ++_a;
        }
    }
}