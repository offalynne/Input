//param string
function input_string_set(_string = "")
{
    _string = string(_string);
    
    if (!__INPUT_KEYBOARD_SUPPORT)
    {
        //Set internal string
        global.__input_string = _string;
    }
    else
    {
        //Enforce length limit
        _string = string_copy(_string, 1, __INPUT_KEYBOARD_STRING_MAX_LENGTH);
        
        //Enforce leading space on Android
        if ((os_type == os_android) && (string_char_at(_string, 1) != " "))
        {
            _string = " " + _string;
        }
        
        //Set keyboard string
        //Conditional since setting is costly on some platforms
        if (keyboard_string != _string)
        {
            keyboard_string = _string;
        }
        
        global.__input_keyboard_prev_string = _string;
    }
}