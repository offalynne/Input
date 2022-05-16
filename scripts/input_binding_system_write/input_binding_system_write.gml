/// @param [playerIndex=all]
/// @param [returnString=true]
/// @param [prettify=false]

function input_binding_system_write(_player_index = all, _return_string = true, _prettify = false)
{
    if (__INPUT_ON_WEB) __input_error("Due to up-stream bug in GameMaker's JavaScript runtime, input_binding_system_read() and input_binding_system_write() are unsupported in HTML5");
    
    if (_player_index == all)
    {
        var _root_json = array_create(INPUT_MAX_PLAYERS, undefined);
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _root_json[@ _p] = input_binding_system_write(_p, false);
            ++_p;
        }
        
        if (_return_string)
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
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _new_profiles_dict = {};
    var _new_axis_thresholds_dict = {};
    
    var _root_json = {
        profiles:        _new_profiles_dict,
        axis_thresholds: _new_axis_thresholds_dict,
    };
    
    with(global.__input_players[_player_index])
    {
        var _profile_name_array = variable_struct_get_names(__profiles_dict);
        var _f = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_f];
            
            var _new_verb_dict = {};
            _new_profiles_dict[$ _profile_name] = _new_verb_dict;
            
            var _profile_struct = __profiles_dict[$ _profile_name];
            var _v = 0;
            repeat(array_length(global.__input_basic_verb_array))
            {
                var _verb_name = global.__input_basic_verb_array[_v];
                
                var _new_alternate_array = [];
                _new_verb_dict[$ _verb_name] = _new_alternate_array;
                
                var _alternate_array = _profile_struct[$ _verb_name];
                var _a = 0;
                repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    array_push(_new_alternate_array, _alternate_array[_a].__export());
                    ++_a;
                }
                
                ++_v;
            }
            
            ++_f;
        }
        
        //Copy axis threshold data
        var _axis_name_array = variable_struct_get_names(__axis_thresholds_dict);
        var _a = 0;
        repeat(array_length(_axis_name_array))
        {
            var _axis_name = _axis_name_array[_a];
            var _thresholds_struct = __axis_thresholds_dict[$ _axis_name];
            
            _new_axis_thresholds_dict[$ _axis_name] = {
                mini: _thresholds_struct.mini,
                maxi: _thresholds_struct.maxi,
            };
            
            ++_a;
        }
    }
    
    if (_return_string)
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