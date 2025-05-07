function InputTextRequest(_caption, _initialText, _maxLength, _callback, _playerIndex = 0, _keyboardType = kbv_type_default)
{
    __INPUT_VALIDATE_PLAYER_INDEX

    static _system = __InputTextSystem();
    with(_system)
    {        
        var _stopResult = __RequestStop();
        if not (_stopResult)
        {
            __InputTrace("Text request warning: Failed to stop text request");
            return false;
        }
            
        __maxLength = clamp(_maxLength, 1, __INPUT_TEXT_MAX_LENGTH);
        if (_maxLength != __maxLength)
        {
            __InputTrace("Text request warning: max length out of bounds: ", _maxLength, " resized to ", __maxLength);
        }

        __ConsumeVerbs();

        if (string_length(_initialText) > _maxLength)
        {
            _initialText = string_copy(_initialText, 1, _maxLength);
        }

        __textSet = string_copy(_initialText, 1, _maxLength);
        
        __playerIndex   = _playerIndex;
        __keyboardType  = _keyboardType;
        __requestStatus = INPUT_TEXT_REQUEST_STATUS.WAITING;

        if (__collectKeyboardText)
        {
            var _showKeyboardResult = __ShowKeyboard(_keyboardType, _caption, _initialText);
            if not (_showKeyboardResult)
            {
                __InputTrace("Text request warning: Failed to show keyboard");
            }
        }
        
        if (is_method(_callback))
        {
            __requestCallback = _callback;
        }
    }

    return true;
}