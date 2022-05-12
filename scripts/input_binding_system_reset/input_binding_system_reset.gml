/// @param [playerIndex=all]
/// @param [resetThresholds=true]

function input_binding_system_reset(_player_index = all, _reset_thresholds = true)
{
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_binding_system_reset(_i, _reset_thresholds);
            ++_i;
        }
        
        return undefined;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        var _profile_name_array = variable_struct_get_names(__profiles_dict);
        var _i = 0;
        repeat(array_length(_profile_name_array))
        {
            var _profile_name = _profile_name_array[_i];
            
            if (_profile_name == "axis_thresholds")
            {
                //Do nothing!
            }
            else if (!variable_struct_exists(global.__input_default_profile_dict, _profile_name))
            {
                //If this profile isn't a default, remove it
                input_profile_destroy(_profile_name, _player_index);
            }
            else
            {
                //Otherwise reset this profile
                input_profile_reset_bindings(_profile_name, _player_index);
            }
            
            ++_i;
        }
        
        if (_reset_thresholds)
        {
            __profiles_dict.axis_thresholds = {};
        }
    }
}