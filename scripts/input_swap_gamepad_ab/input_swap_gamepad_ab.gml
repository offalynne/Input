/// @desc    Sets the A/B swap state. This generally should only be used at the start of the game as it fully resets all player profiles and bindings to what’s found in INPUT_DEFAULT_PROFILES
/// @param   state

function input_swap_gamepad_ab(_state)
{
    __input_initialize();
    
    if (_state == global.__input_swap_ab) return;
    global.__input_swap_ab = _state;
    
    //Don't flip bindings if we haven't set up default profiles yet
    if (global.__input_default_profile_dict == undefined) return;
    
    var _profile_name_array = variable_struct_get_names(global.__input_default_profile_dict);
    var _f = 0;
    repeat(array_length(_profile_name_array))
    {
        var _profile_name = _profile_name_array[_f];
        
        var _profile_dict = global.__input_default_player.__profiles_dict[$ _profile_name];
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            var _alternate_array = _profile_dict[$ _verb_name];
            var _a = 0;
            repeat(array_length(_alternate_array))
            {
                var _binding = _alternate_array[_a];
                if (_binding.type == __INPUT_BINDING_GAMEPAD_BUTTON)
                {
                    if (_binding.value == gp_face1)
                    {
                        __input_trace("Swapping A/X -> B/O for profile \"", _profile_name, "\", verb \"", _verb_name, "\", alternate ", _a);
                        _binding.value = gp_face2;
                    }
                    else if (_binding.value == gp_face2)
                    {
                        __input_trace("Swapping B/O -> A/X for profile \"", _profile_name, "\", verb \"", _verb_name, "\", alternate ", _a);
                        _binding.value = gp_face1;
                    }
                }
                
                ++_a;
            }
            
            ++_v;
        }
        
        ++_f;
    }
    
    //Reset all players to seal the deal
    input_system_reset();
}