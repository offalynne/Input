// Feather disable all

// Opens keyboard, starts request
//
// @param {String} caption
// @param {String} initialText
// @param {Real} maxLength
// @param {Function, undefined} callback
// @param {Constant.VirtualKeyboardType} [keyboardType]

function InputTextRequestStart(_caption, _initialText, _maxLength, _callback, _keyboardType = kbv_type_default)
{
    static _system = __InputTextSystem();
    with(_system)
    {
        __enabled = true;
        
        if (__requestStatus == INPUT_TEXT_STATUS.WAITING)
        {
            __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            __InputTextHandleChanges();
            __InputTextHandleStatus();
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

        var _result = true;
        var _useController = false;
        
        if (INPUT_ON_CONSOLE || INPUT_ON_WEB)
        {
            _useController = true;
            if (__asyncId != undefined)
            {
                _result = false;
            }
            else
            {
                __asyncId = get_string_async(_caption, _initialText);
            }
                
        }
        else if (__useSteamKeyboard)
        {
            _result = steam_show_gamepad_text_input(
                            steam_gamepad_text_input_mode_normal, 
                            steam_gamepad_text_input_line_mode_single_line, 
                            _caption, __maxLength, _initialText);                
            if (_result)
            {                    
                _useController = true;
                __steamAsyncRequest = true;
            }
        }
        else
        {
            keyboard_string = _initialText;   
                
            if (INPUT_ON_MOBILE)
            {
                keyboard_virtual_show(_keyboardType, INPUT_TEXT_RETURN_KEY, INPUT_TEXT_CAPITALIZATION, INPUT_TEXT_PREDICTION);
            }
        }
            
        if (_useController && !instance_exists(__InputTextAsyncController))
        {
            instance_create_depth(0, -__INPUT_CONTROLLER_OBJECT_DEPTH, __INPUT_CONTROLLER_OBJECT_DEPTH + 1, __InputTextAsyncController);
        }

        if not (_result)
        {
            __InputTrace("Text request warning: Failed to show keyboard");
            __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            return false;
        }
        else
        {
            __callback     = _callback;
            __keyboardType = _keyboardType;
            __textSet      = string_copy(_initialText, 1, _maxLength);
        }
    }

    return true;
}