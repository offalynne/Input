/// @param source
/// @param [gamepad]

function input_source_detect(_source, _gamepad = INPUT_NO_GAMEPAD)
{
    switch(_source)
    {
        case INPUT_SOURCE.GAMEPAD:
            //Check gamepad input before keyboard input to correctly handle Android duplicating button presses with keyboard presses
            if (global.__input_gamepad_default_defined)
            {
                if (gamepad_is_connected(_gamepad) && input_source_is_available(INPUT_SOURCE.GAMEPAD, _gamepad))
                {
                    if (input_gamepad_check_pressed(_gamepad, gp_face1)
                    ||  input_gamepad_check_pressed(_gamepad, gp_face2)
                    ||  input_gamepad_check_pressed(_gamepad, gp_face3)
                    ||  input_gamepad_check_pressed(_gamepad, gp_face4)
                    ||  input_gamepad_check_pressed(_gamepad, gp_padu)
                    ||  input_gamepad_check_pressed(_gamepad, gp_padd)
                    ||  input_gamepad_check_pressed(_gamepad, gp_padl)
                    ||  input_gamepad_check_pressed(_gamepad, gp_padr)
                    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderl)
                    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderr)
                    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderlb)
                    ||  input_gamepad_check_pressed(_gamepad, gp_shoulderrb)
                    ||  input_gamepad_check_pressed(_gamepad, gp_start)
                    ||  input_gamepad_check_pressed(_gamepad, gp_select)
                    ||  input_gamepad_check_pressed(_gamepad, gp_stickl)
                    ||  input_gamepad_check_pressed(_gamepad, gp_stickr))
                    {
                        return true;
                    }
                    
                    if (INPUT_SDL2_ALLOW_EXTENDED)
                    {
                        if (input_gamepad_check_pressed(_gamepad, gp_guide)
                        ||  input_gamepad_check_pressed(_gamepad, gp_misc1)
                        ||  input_gamepad_check_pressed(_gamepad, gp_touchpad)
                        ||  input_gamepad_check_pressed(_gamepad, gp_paddle1)
                        ||  input_gamepad_check_pressed(_gamepad, gp_paddle2)
                        ||  input_gamepad_check_pressed(_gamepad, gp_paddle3)
                        ||  input_gamepad_check_pressed(_gamepad, gp_paddle4))
                        {
                            return true;                
                        }
                    }
                }
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
            if (global.__input_keyboard_default_defined
            &&  input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
            &&  keyboard_check_pressed(vk_anykey)
            &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
            {
                return true;
            }
            
            if (global.__input_mouse_default_defined
            &&  input_source_is_available(INPUT_SOURCE.KEYBOARD_AND_MOUSE)
            &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
            {
               return true;
            }
        break;
    }
    
    return false;
}