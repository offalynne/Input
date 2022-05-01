/// @param [playerIndex=all]
/// @param [resetThresholds=true]

function input_binding_system_reset(_player_index = all, _reset_thresholds = true)
{
    if (_player_index == all)
    {
        var _i = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_binding_system_reset(_i);
            ++_i;
        }
        
        return undefined;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index])
    {
        var _f = 0;
        repeat(array_length(global.__input_profile_name_array))
        {
            var _profile_name = global.__input_profile_name_array[$ _f];
            
            var _v = 0;
            repeat(array_length(global.__input_basic_verb_array))
            {
                var _verb = global.__input_basic_verb_array[_v];
                
                var _alternate = 0;
                repeat(INPUT_MAX_ALTERNATE_BINDINGS)
                {
                    __binding_reset(_profile_name, _verb, _alternate);
                    ++_alternate;
                }
                
                ++_v;
            }
            
            ++_f;
        }
        
        if (_reset_thresholds)
        {
            __profiles_dict.axis_thresholds = {};
        }
    }
}