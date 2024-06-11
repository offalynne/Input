// Feather disable all

/// @desc    Shows virtual keyboard
///          This covers mobile platforms as well as Xbox and Steam
/// @param   [virtualKeyboardType]

function input_keyboard_virtual_show(_virtual_keyboard_type = kbv_type_default)
{
    static __warned = false;    
    if (!__warned)
    {
        if (INPUT_KEYBOARD_TYPE != "virtual") __input_trace("Warning! Onscreen keyboard is not suitable for use on the current platform");
        if (INPUT_KEYBOARD_TYPE == "async")   __input_trace("Consider using async dialog for modal text input instead");        
        __warned = true;
    }
    
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global  
    
    if (_global.__using_steamworks)
    {
        switch(_virtual_keyboard_type)
        {
            case kbv_type_email:   _virtual_keyboard_type = steam_floating_gamepad_text_input_mode_email;       break;
            case kbv_type_numbers: _virtual_keyboard_type = steam_floating_gamepad_text_input_mode_numeric;     break;
            default:               _virtual_keyboard_type = steam_floating_gamepad_text_input_mode_single_line; break;
        }
            
        steam_show_floating_gamepad_text_input(_virtual_keyboard_type, 0, 0, 0, 0);
    }
    else if (!keyboard_virtual_status() || __INPUT_ON_ANDROID) //Status detect is unreliable on Android platform
    {
        if not (__INPUT_ON_WINDOWS)
        {
            keyboard_virtual_show(_virtual_keyboard_type, kbv_returnkey_default, INPUT_VIRTUAL_KEYBOARD_AUTOCAPITALIZATION_TYPE, INPUT_VIRTUAL_KEYBOARD_PREDICTIVE_TEXT_ENABLED);
        }
    }
}
