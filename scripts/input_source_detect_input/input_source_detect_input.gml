/// @desc    Returns whether input is detected from the target source
/// @param   source

function input_source_detect_input(_source)
{
    switch(_source.__source)
    {
        case __INPUT_SOURCE.KEYBOARD:
            if (global.__input_any_keyboard_binding_defined
            &&  input_source_is_available(_source)
            &&  keyboard_check_pressed(vk_anykey)
            &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
            {
                return true;
            }
            
            if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER)
            {
                if (global.__input_any_mouse_binding_defined
                &&  input_source_is_available(_source)
                &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
                {
                    return true;
                }
            }
        break;
        
        case __INPUT_SOURCE.MOUSE:
            if (global.__input_any_mouse_binding_defined
            &&  input_source_is_available(_source)
            &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
            {
                return true;
            }
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            if (global.__input_any_gamepad_binding_defined)
            {
                var _gamepad = _source.__gamepad;
                if (input_source_is_available(_source))
                {
                    input_gamepad_check_pressed_any(_gamepad, false);
                }
            }
        break;
    }
    
    return false;
}