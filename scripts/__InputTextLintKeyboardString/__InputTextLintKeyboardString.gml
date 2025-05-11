// Feather disable all

function __InputTextLintKeyboardString()
{
    static _charFilter = [
        0x0A, // Line feed
        0x0D, // Carriage Return
        0x7F  // Ctrl + Del
    ];
    
    var _preLintString = keyboard_string;
    var _keyboardString = _preLintString;
            
    if ((string_length(_keyboardString) > 0) && (_keyboardString == ""))
    {
        if (INPUT_ON_IOS) keyboard_virtual_hide();
        keyboard_string = "";
    }
            
    if (string_length(_keyboardString) == 0) return;
            
    var _i = 0;            
    repeat(array_length(_charFilter))
    {
        var _char = chr(_charFilter[_i]);
        if (__InputStringContains(_keyboardString, _char))
        {
            _keyboardString = string_replace_all(_keyboardString, _char, "");
        }
                
        ++_i;
    }
    
    var _overflow = string_length(_keyboardString) - __INPUT_TEXT_MAX_LENGTH;
    if (_overflow > 0)
    {
        _keyboardString = string_copy(_keyboardString, _overflow + 1, string_length(_keyboardString));
        __keyboardStringPrevious = string_copy(__keyboardStringPrevious, _overflow + 1, string_length(__keyboardStringPrevious));
    }
    
    if (_preLintString != _keyboardString)
    {
        if (INPUT_ON_IOS) keyboard_virtual_hide();
        keyboard_string = _keyboardString;
    }
}