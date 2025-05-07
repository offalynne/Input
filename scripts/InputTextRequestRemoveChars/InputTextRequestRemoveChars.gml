function InputTextRequestRemoveChars(_characterCount = infinity)
{
    static _system = __InputTextSystem();    
    if not (is_real(_characterCount)) __InputError("Input Text: Invalid number ", _characterCount);
    
    with(_system)
    {
        if (__requestStatus != INPUT_TEXT_REQUEST_STATUS.WAITING) return;
        array_push(__textChanges, abs(_characterCount));
    }
}