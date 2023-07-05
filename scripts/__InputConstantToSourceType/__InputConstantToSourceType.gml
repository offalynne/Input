function __InputConstantToSourceType(_constant)
{
    static _constantToSourceTypeDict = __input_global().__constantToSourceTypeDict;
    
    //Try to look up the source type directly
    var _sourceType = _constantToSourceTypeDict[$ string(_constant)];
    
    //If it's a number then we found a direct match, return it
    if (is_numeric(_sourceType)) return _sourceType;
    
    if (is_numeric(_constant))
    {
        if (_constant < 0)
        {
            //If the constant is a number less than zero, try inverting the constant
            return _constantToSourceTypeDict[$ string(-_constant)];
        }
        else
        {
            //Otherwise this is probably a weird keyboard binding
            return __INPUT_SOURCE.KEYBOARD;
        }
    }
    
    //If the constant is a single-character then this is probably a keyboard constant
    if (is_string(_constant) && (string_length(_constant) == 1))
    {
        return __INPUT_SOURCE.KEYBOARD;
    }
    
    //Otherwise this is not a valid constant
    return undefined;
}