/// @desc    Returns the contents of the keyboard buffer from the last frame

function input_keyboard_string_frame()
{
    if (global.__input_keyboard_string_frame != global.__input_frame)
    {
        //Update buffer to latest frame
        if (os_type == os_switch)
        {
            var _last_key = __input_keyboard_key();
            if (input_keyboard_check_pressed(_last_key) && (keyboard_lastchar == chr(_last_key)))
            {
                //Use printable key press on Switch platform
                global.__input_keyboard_buffer = chr(_last_key);
            }
            else
            {
                global.__input_keyboard_buffer = "";
            }
        }
        else
        {        
            //Resolve string difference on remaining platforms
            var _old = global.__input_keyboard_string_last;
            var _new = global.__input_keyboard_string;
    
            if (_old == _new)
            {
                //No change
                global.__input_keyboard_buffer = "";
            }
            else if (string_length(_old) == 0)
            {
                //Fully additive
                global.__input_keyboard_buffer = _new;
            }
            else if (string_pos(_old, _new) == 1)
            {
                //Paritally additive
                global.__input_keyboard_buffer = string_replace(_new, _old, "");
            }
            else
            {
                //Subtractive
                var _new_length = string_length(_new);
                var _i = 1;
                repeat(_new_length)
                {
                    //Step left to right until character mismatch
                    if (string_char_at(_new, _i) != string_char_at(_old, _i)) break;
                    _i++;
                }
        
                if (_i == _new_length)
                {
                    //Fully subtractive
                    global.__input_keyboard_buffer = "";
                }
                else
                {
                    //Partially subtractive
                    global.__input_keyboard_buffer = string_copy(_new, _i, _new_length);
                }
            }
        }
        
        //Match frame counter
        global.__input_keyboard_string_frame = global.__input_frame;
    }
    
    //Return cached difference
    return global.__input_keyboard_buffer;
}
