//param binding
function input_keyboard_check(_binding)
{
    
    //Validate keycode
    if (!is_numeric(_binding))
    {
        __input_error("Invalid keycode format (", _binding, ")");
        return false;
    }

    //Native iOS/tvOS keyboard events are catastrophic
    if (__INPUT_ON_APPLE && __INPUT_ON_MOBILE && (!__INPUT_ON_WEB))
    {
        return false;
    }
    
    return keyboard_check(_binding);
}
