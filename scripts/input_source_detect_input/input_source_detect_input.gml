/// @desc    Returns whether input is detected from the target source
///          If the keyword <all> is used then this function will return <true> if ANY supported source is active
///          If an array of sources is given then this function will return <true> if ANY of the sources in the array are active
/// @param   source
/// @param   availableOnly

function input_source_detect_input(_source, _available_only = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_source == all)
    {
        return input_source_detect_input([INPUT_KEYBOARD, INPUT_MOUSE, INPUT_TOUCH, INPUT_GAMEPAD], _available_only);
    }
    
    if (is_array(_source))
    {
        var _i = 0;
        repeat(array_length(_source))
        {
            if (input_source_detect_input(_source[_i], _available_only)) return true;
            ++_i;
        }
        
        return false;
    }
    
    switch(_source.__source)
    {
        case __INPUT_SOURCE.KEYBOARD:
            if (_global.__keyboard_allowed && _global.__any_keyboard_binding_defined
            &&  (!_available_only || input_source_is_available(_source))
            &&  keyboard_check_pressed(vk_anykey)
            &&  !__input_key_is_ignored(__input_keyboard_key())) //Ensure that this key isn't one we're trying to ignore
            {
                return true;
            }
            
            if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER)
            {
                if (_global.__mouse_allowed
                &&  (!_available_only || input_source_is_available(_source))
                &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
                {
                    return true;
                }
            }
        break;
        
        case __INPUT_SOURCE.MOUSE:
            if (_global.__mouse_allowed
            &&  (!_available_only || input_source_is_available(_source))
            &&  (input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()))
            {
                return true;
            }
        break;
        
        case __INPUT_SOURCE.TOUCH:
            if (_global.__touch_allowed
            &&  (!_available_only || input_source_is_available(_source))
            &&  device_mouse_check_button(_global.__pointer_index, mb_left))
            {
                return true;
            }
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            if (_global.__gamepad_allowed && _global.__any_gamepad_binding_defined)
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