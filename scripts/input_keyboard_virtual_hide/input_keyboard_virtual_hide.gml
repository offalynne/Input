// Feather disable all
/// @desc    Hides virtual keyboard
///          This covers mobile platforms as well as Steam

function input_keyboard_virtual_hide()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global  
    
    if (_global.__using_steamworks)
    {
        steam_dismiss_floating_gamepad_text_input();
    }
    else if (keyboard_virtual_status() || __INPUT_ON_ANDROID) //Status detect is unreliable on Android platform
    {
        keyboard_virtual_hide();
    }
}
