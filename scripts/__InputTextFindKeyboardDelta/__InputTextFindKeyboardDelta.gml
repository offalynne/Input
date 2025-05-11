// Feather disable all

function __InputTextFindKeyboardDelta()
{
    __textDelta   = "";
    __removeCount = 0;            
            
    if (INPUT_ON_CONSOLE || __steamAsyncRequest || (__textAsync != undefined) ||  (__textSet != undefined)) return;
            
    var _keyboardString = keyboard_string;
    var _length = string_length(_keyboardString);

    if (_keyboardString != __keyboardStringPrevious)
    {
        var _i = 1;
        repeat(_length)
        {
            if (string_char_at(_keyboardString, _i) != string_char_at(__keyboardStringPrevious, _i)) break;
            ++_i;
        }
        
        __textDelta = string_copy(_keyboardString, _i, _length);
    }
    
    if (string_length(__keyboardStringPrevious) > 0)
    {
        var _deleteCount = abs(_length - string_length(__keyboardStringPrevious) - string_length(__textDelta));
        if (_deleteCount != 0)
        {
            __removeCount = _deleteCount;
        }				
		else if (INPUT_ON_MACOS || INPUT_ON_LINUX)
		{
			__removeCount = __repeatCount;
		}
    }
    else
    {
        __removeCount = __repeatCount;
    }
}