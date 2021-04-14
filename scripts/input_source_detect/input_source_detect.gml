function input_source_detect(_source, _gamepad)
{
    switch(_source)
    {
        case INPUT_SOURCE.GAMEPAD:
            //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
            if (global.__input_gamepad_valid)
            {
                var _g = 0;
                repeat(gamepad_get_device_count())
                {
                    if (gamepad_is_connected(_g) && __input_source_is_available(INPUT_SOURCE.GAMEPAD, _g))
                    {
                        if (input_gamepad_check_pressed(_g, gp_face1)
                        ||  input_gamepad_check_pressed(_g, gp_face2)
                        ||  input_gamepad_check_pressed(_g, gp_face3)
                        ||  input_gamepad_check_pressed(_g, gp_face4)
                        ||  input_gamepad_check_pressed(_g, gp_padu)
                        ||  input_gamepad_check_pressed(_g, gp_padd)
                        ||  input_gamepad_check_pressed(_g, gp_padl)
                        ||  input_gamepad_check_pressed(_g, gp_padr)
                        ||  input_gamepad_check_pressed(_g, gp_shoulderl)
                        ||  input_gamepad_check_pressed(_g, gp_shoulderr)
                        ||  input_gamepad_check_pressed(_g, gp_shoulderlb)
                        ||  input_gamepad_check_pressed(_g, gp_shoulderrb)
                        ||  input_gamepad_check_pressed(_g, gp_start)
                        ||  input_gamepad_check_pressed(_g, gp_select)
                        ||  input_gamepad_check_pressed(_g, gp_stickl)
                        ||  input_gamepad_check_pressed(_g, gp_stickr)
                        ||  (INPUT_SDL2_ALLOW_GUIDE && input_gamepad_check(_g, gp_guide))
                        ||  (INPUT_SDL2_ALLOW_MISC1 && input_gamepad_check(_g, gp_misc1)))
                        {
                            return true;
                        }
                    }
                    
                    ++_g;
                }
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
            if (global.__input_keyboard_valid
            &&  __input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
            &&  keyboard_check_pressed(vk_anykey)
            &&  !__input_key_is_ignored(keyboard_key)) //Ensure that this key isn't one we're trying to ignore
            {
                return true;
            }
            
            if (global.__input_mouse_valid
            &&  __input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
            &&  (device_mouse_check_button_pressed(0, mb_any) || mouse_wheel_up() || mouse_wheel_down()))
            {
               return true;
            }
        break;
    }
    
    return false;
}