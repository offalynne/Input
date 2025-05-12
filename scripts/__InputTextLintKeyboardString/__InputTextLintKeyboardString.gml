// Feather disable all

function __InputTextLintKeyboardString()
{
    static _charFilter = [
        0x0A, // Line feed
        0x0D, // Carriage Return
        0x7F  // Ctrl + Del
    ];
    
    var _preLintString = __keyboardString;
            
    if ((string_length(__keyboardString) > 0) && (__keyboardString == ""))
    {
        if (INPUT_ON_IOS) keyboard_virtual_hide();
        keyboard_string = "";
    }
            
    if (string_length(__keyboardString) == 0) return;
            
    var _i = 0;            
    repeat(array_length(_charFilter))
    {
        var _char = chr(_charFilter[_i]);
        if (__InputStringContains(__keyboardString, _char))
        {
            __keyboardString = string_replace_all(__keyboardString, _char, "");
        }
                
        ++_i;
    }

    var _overflow = string_length(__keyboardString) - __INPUT_TEXT_MAX_LENGTH;
    var _minimumOverflow = 1;
    
    if (INPUT_ON_IOS)
    {
        _minimumOverflow = 1000 - __INPUT_TEXT_MAX_LENGTH;
    }
    
    if (_overflow >= _minimumOverflow)
    {
        __keyboardString = string_copy(__keyboardString, _overflow + 1, string_length(__keyboardString));
        __keyboardStringPrevious = string_copy(__keyboardStringPrevious, _overflow + 1, string_length(__keyboardStringPrevious));
    }
    
    if (_preLintString != __keyboardString)
    {
        if (INPUT_ON_IOS) keyboard_virtual_hide();
        keyboard_string = __keyboardString;
    }
}
