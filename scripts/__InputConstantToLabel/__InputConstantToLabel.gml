function __InputConstantToLabel(_constant, _allowOverride = true)
{
    static _constantToLabelDict = __input_global().__constantToLabelDict;
    
    if (__INPUT_ON_MACOS && _allowOverride)
    {
        static _constantToLabelOverrideDict = __input_global().__constantToLabelOverrideDict;
        
        //Try to look up the label from the override dictionary first
        var _label = _constantToLabelOverrideDict[$ string(_constant)];
        
        //If it's a string then we found a direct match, return it
        if (is_string(_label)) return _label;
    }
    
    //Try to look up the label directly
    var _label = _constantToLabelDict[$ string(_constant)];
    
    //If it's a string then we found a direct match, return it
    if (is_string(_label)) return _label;
    
    if (is_numeric(_constant))
    {
        if (_constant < 0)
        {
            //If the constant is a number less than zero, try inverting the constant
            return _constantToLabelDict[$ string(-_constant)] ?? "binding unknown";
        }
        else
        {
            //Else convert the constant into a character
            return chr(_constant);
        }
    }
    
    //If the constant is a single-character then this is probably a keyboard constant
    if (is_string(_constant) && (string_length(_constant) == 1))
    {
        return string_upper(_constant);
    }
    
    //Otherwise this is not a recognised binding
    return "binding unknown";
}