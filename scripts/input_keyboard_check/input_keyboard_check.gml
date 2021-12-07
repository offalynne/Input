//param binding
function input_keyboard_check(_binding)
{
    if (!global.__input_keyboard_allowed) 
    {
        return false;
    }
    
    return keyboard_check(_binding);
}
