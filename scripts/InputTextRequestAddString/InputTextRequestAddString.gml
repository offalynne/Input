function InputTextRequestAddString(_string)
{
    static _system = __InputTextSystem();
    if not (is_string(_string)) __InputError("Input Text: Invalid string ", _string);
    
    with(_system)
    {
        if (__requestStatus != INPUT_TEXT_REQUEST_STATUS.WAITING) return;
        array_push(__textChanges, _string);
    }
}