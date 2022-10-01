/// @desc    Returns whether input is detected from the target source
/// @param   source
/// @param   availableOnly

function input_source_detect_input(_source, _available_only = true)
{
    switch(_source.__source)
    {
        case __INPUT_SOURCE.KEYBOARD:
            if (global.__input_any_keyboard_binding_defined
            &&  (!_available_only || input_source_is_available(_source))
            &&  keyboard_check_pressed(vk_anykey)
            &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
            {
                return true;
            }
            
            if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER)
            {
                if ((!_available_only || input_source_is_available(_source))
                &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
                {
                    return true;
                }
            }
        break;
        
        case __INPUT_SOURCE.MOUSE:
            if ((!_available_only || input_source_is_available(_source))
            &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
            {
                return true;
            }
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            if (global.__input_any_gamepad_binding_defined)
            {
                var _gamepad = _source.__gamepad;
                if (input_gamepad_is_connected(_gamepad)
                && (!_available_only || input_source_is_available(_source)))
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
                    ||  (!input_gamepad_is_axis(_gamepad, gp_shoulderlb) && input_gamepad_check_pressed(_gamepad, gp_shoulderlb))
                    ||  (!input_gamepad_is_axis(_gamepad, gp_shoulderrb) && input_gamepad_check_pressed(_gamepad, gp_shoulderrb))
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
    }
    
    return false;
}