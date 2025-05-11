function InputTextRequestStart(_caption, _initialText, _maxLength, _callback, _keyboardType = kbv_type_default)
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        
        if (__requestStatus == INPUT_TEXT_STATUS.WAITING)
        {
            __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            __HandleChanges();
            __HandleStatus();
        }
        
        __newStatus = INPUT_TEXT_STATUS.WAITING;        
        __maxLength = clamp(_maxLength, 1, __INPUT_TEXT_MAX_LENGTH);
        
        if (_maxLength != __maxLength)
        {
            __InputTrace("Text request warning: max length out of bounds, was ", _maxLength, ", resized to ", __maxLength);
        }

        if (string_length(_initialText) > _maxLength)
        {
            _initialText = string_copy(_initialText, 1, _maxLength);
        }

        __keyboardType = _keyboardType;
        __callback     = _callback;
        __textSet      = string_copy(_initialText, 1, _maxLength);

        var _showKeyboardResult = __ShowKeyboard(_keyboardType, _caption, _initialText);
        if not (_showKeyboardResult)
        {
            __asyncId = undefined;
            __steamAsyncRequest = false;
            __InputTrace("Text request warning: Failed to show keyboard");
        }
    }

    return true;
}