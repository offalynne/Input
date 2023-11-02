// Feather disable all
/// @desc    Returns whether input is detected from the target source
///          If the keyword <all> is used then this function will return <true> if ANY supported source is active
///          If an array of sources is given then this function will return <true> if ANY of the sources in the array are active
/// @param   source
/// @param   availableOnly

function input_source_detect_input(_source, _available_only = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if not (_global.__game_input_allowed)
    {
        return false;
    }
    
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
                && (!_available_only || input_source_is_available(_source))
                && (_global.__gamepads[_gamepad].__get_any_pressed()))
                {
                    return true;
                }
            }
        break;
    }
    
    return false;
}
