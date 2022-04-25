/// @param state

function input_default_gamepad_swap_ab(_state)
{
	__input_initialize();
	
    with(global.__input_default_player)
    {
        var _source_verb_struct = config[$ "gamepad"];
        if (is_struct(_source_verb_struct))
        {
            var _verb_names = variable_struct_get_names(_source_verb_struct);
            var _i = 0;
            repeat(array_length(_verb_names))
            {
                var _verb_name = _verb_names[_i];
                var _verb_alternate_array = _source_verb_struct[$ _verb_name];
                
                if (is_array(_verb_alternate_array))
                {
                    var _j = 0;
                    repeat(array_length(_verb_alternate_array))
                    {
                        var _binding = _verb_alternate_array[_j];
                        if (is_struct(_binding))
                        {
                            with(_binding)
                            {
                                if ((type == "gamepad button") && ((value == gp_face1) || (value == gp_face2)))
                                {
                                    __input_error("input_default_gamepad_swap_ab() should be called before input_default_gamepad_button()");
                                }
                            }
                        }
                        
                        ++_j;
                    }
                }
                
                ++_i;
            }
        }
    }
    
    global.__input_swap_ab = _state;
}