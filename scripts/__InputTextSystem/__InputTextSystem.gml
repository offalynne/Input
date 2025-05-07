enum INPUT_TEXT_REQUEST_STATUS
{
    NONE,
    WAITING,
    STOPPED,
    CANCELLED,
    CONFIRMED
}

#macro __INPUT_TEXT_MAX_LENGTH  256

__InputTextSystem();
function __InputTextSystem()
{
    static _system = undefined;
    if (_system != undefined) return _system;
        
    _system = {};
    with(_system)
    {
        __useSteamKeyboard = InputGetSteamInfo(INPUT_STEAM_INFO.BIG_PICTURE);

        __verbCancel      = undefined;
        __verbConfirm     = undefined;
        __requestCallback = undefined;
        __textSet         = undefined;
        __textAsync       = undefined;
        __asyncId         = undefined;

        __awaitingSteamRequest = false;
        __collectKeyboardText  = true;
        __surpressVerbs        = true;
        
        __playerIndex = 0;
        __removeCount = 0;
        __textDelta   = "";
        __textRequest = "";
        __textChanges = [];
        
        __keyboardType  = kbv_type_default;
        __requestStatus = INPUT_TEXT_REQUEST_STATUS.NONE;
        __maxLength     = __INPUT_TEXT_MAX_LENGTH;
        
        __ignore       = false;
        __heldPrevious = false;
        __pressedTime  = infinity;
        __repeatCount  = 0;
        
        __timePrevious = InputPlugInGetTime();     
        
        if (INPUT_ON_ANDROID) keyboard_string = " ";
        
        __keyboardString = keyboard_string;   
        __keyboardStringPrevious = __keyboardString;
    
        __RequestStop = function(_newStatus = INPUT_TEXT_REQUEST_STATUS.STOPPED)
        {
            if (__requestStatus == INPUT_TEXT_REQUEST_STATUS.WAITING)
            {
                if ((__asyncId != undefined) || __awaitingSteamRequest)
                {
                    __InputTrace("Text request warning: previous async requst is waiting");
                    return false;
                }

                __requestStatus = _newStatus;
                __Callback();
            }

            return true;
        }
        
        __ApplyChanges = function()
        {
            repeat(array_length(__textChanges))
            {
                var _value = array_pop(__textChanges);
                if (is_string(_value))
                {
                    __textRequest += _value;
                    continue;
                }
                
                __textRequest = string_copy(__textRequest, 1, max(0, string_length(__textRequest) - _value));
            }
            
            __textRequest = string_copy(__textRequest, 1, __maxLength);
        }

        __Callback = function()
        {
            if (is_method(__requestCallback))
            {
                __requestCallback();
                __requestCallback = undefined;
            }
        }
        
        __ConsumeVerbs = function()
        {
            if not (__surpressVerbs) return;
            
            var _i = 0;
            repeat (array_length(INPUT_MAX_PLAYERS))
            {
                if (INPUT_TEXT_CONSUME_ALL_PLAYERS || (_i == __playerIndex))
                {
                    InputVerbConsumeAll(_i);
                }

                ++_i;
            }
        }

        __ShowKeyboard = function(_keyboardType, _caption, _initialText)
        {
            if (INPUT_ON_CONSOLE || INPUT_ON_WEB)
            {
                __asyncId = get_string_async(_caption, _initialText);    
            }
            else if (INPUT_ON_MOBILE)
            {
                if (INPUT_ON_IOS)
                {
                    keyboard_virtual_hide();
                    keyboard_string = _initialText;
                }
                else if (INPUT_ON_ANDROID)
                {
                    keyboard_string = " " + _initialText;
                }
                
                keyboard_virtual_show(_keyboardType, INPUT_TEXT_RETURN_KEY, INPUT_TEXT_CAPITALIZATION, INPUT_TEXT_PREDICTION);
            }
            else if (__useSteamKeyboard)
            {
                return steam_show_gamepad_text_input(
                            steam_gamepad_text_input_mode_normal, 
                            steam_gamepad_text_input_line_mode_single_line, 
                            _caption, _maxLength, _initialText);
            }

            return true;
        }
        
        __HandleVerbs = function()
        {
            if (__requestStatus != INPUT_TEXT_REQUEST_STATUS.WAITING) return;

            if (__verbCancel != undefined)
            {
                if (InputPressed(__verbCancel,  __playerIndex))
                {
                    __RequestStop(INPUT_TEXT_REQUEST_STATUS.CANCELLED);
                }
            }
    
            if (__verbConfirm != undefined)
            {
                if (InputPressed(__verbConfirm,  __playerIndex))
                {
                    __RequestStop(INPUT_TEXT_REQUEST_STATUS.CONFIRMED);
                }
            }
    
            __ConsumeVerbs();
        }
        
        __HandleKeyboard = function()
        {
            __keyboardStringPrevious = __keyboardString;
            __keyboardString = keyboard_string;
            
            var _keyReleased = keyboard_check_released(vk_anykey);    
            var _deleteCheck = keyboard_check(vk_backspace) && !keyboard_check(vk_control) && !keyboard_check(vk_alt);
            var _deleteHeld  = _deleteCheck && ((keyboard_key == vk_backspace) || keyboard_check(ord(keyboard_lastchar)));
            
            if (INPUT_ON_ANDROID)
            {
                var _i = 0;
                repeat(gamepad_get_device_count())
                {
                    if (gamepad_button_check(_i, gp_face2))
                    {
                        _deleteCheck = false;
                        _deleteHeld  = false;
                        break;
                    }
                    
                    ++_i;
                }
            }
            
            var _currentTime = InputPlugInGetTime();
            if (_deleteHeld && _keyReleased)
            {
                __pressedTime = _currentTime;
            }            
            
            if (__ignore && !_deleteCheck)
            {
                __ignore = false;
            }
            else if (keyboard_check(vk_anykey) && !_deleteHeld)
            {
                __ignore = true;
            }
            
            __repeatCount = 0;
            if (!__ignore && _deleteHeld)
            {
                if (!__heldPrevious)
                {
                    __repeatCount = 1;
                    __pressedTime = _currentTime;
                }
                else
                {
                    var _heldTime = _currentTime - __pressedTime;
                    if (_heldTime < INPUT_TEXT_REPEAT_DELAY)
                    {
                        __repeatCount = 0;
                    }
                    else
                    {
                        var _repeatStart = __pressedTime + INPUT_TEXT_REPEAT_DELAY;
                        var _repeatCountPrevious = floor((__timePrevious - _repeatStart)/INPUT_TEXT_REPEAT_INTERVAL);
                        var _repeatCountCurrent  = floor((_currentTime   - _repeatStart)/INPUT_TEXT_REPEAT_INTERVAL);
                        __repeatCount = max(0, _repeatCountCurrent - _repeatCountPrevious);
                    }
                }
            }
            
            __heldPrevious = _deleteHeld;
            __timePrevious = _currentTime;
        }
        
        __LintKeyboardString = function()
        {
            var _preLintString = keyboard_string;
            var _keyboardString = _preLintString;          
            var _charFilter = [10, 13, 127];
            
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
    
            if (string_length(_keyboardString) > __INPUT_TEXT_MAX_LENGTH)
            {
                _keyboardString = string_copy(_keyboardString, 1, __INPUT_TEXT_MAX_LENGTH);
            }
    
            if (_keyboardString != _keyboardString)
            {
                if (INPUT_ON_IOS) keyboard_virtual_hide();
                keyboard_string = _keyboardString;
            }
        }
        
        __FindKeyboardDelta = function()
        {
            var _keyboardString = keyboard_string;
            var _length = string_length(_keyboardString);

            __textDelta = "";
            __removeCount = 0;
            
            if ((__textAsync != undefined) || (__textSet != undefined)) return;
            
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
    
            if (string_length(__keyboardStringPrevious) > (INPUT_ON_ANDROID? 1 : 0))
            {
                __removeCount = abs(_length - string_length(__keyboardStringPrevious) - string_length(__textDelta));
            }
            else
            {
                __removeCount = __repeatCount;
            }
        }
        
        __HandleChanges = function()
        {
            if (__requestStatus != INPUT_TEXT_REQUEST_STATUS.WAITING) return;
            
            if (__textAsync != undefined)
            {
                __textRequest = __textAsync;
                __textAsync = undefined;
            }
            else if (__textSet != undefined)
            {
                __textRequest = __textSet;
                __textSet = undefined;    
            }
            else
            {
                if (__collectKeyboardText && (array_length(__textChanges) == 0))
                {
                    if (__removeCount > 0) array_push(__textChanges, __removeCount);
                    if (string_length(__textDelta)) array_push(__textChanges, __textDelta);
                }

                __ApplyChanges();
            }
        }
        
        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.GAIN_FOCUS, undefined, function()
        {
            if (!INPUT_ON_ANDROID || (__requestStatus != INPUT_TEXT_REQUEST_STATUS.WAITING)) return;
            
            if (__collectKeyboardText)
            {
                keyboard_virtual_show(__keyboardType, INPUT_TEXT_RETURN_KEY, INPUT_TEXT_CAPITALIZATION, INPUT_TEXT_PREDICTION);
            }
        });

        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
        {
            __HandleVerbs();
            __HandleKeyboard();
            __LintKeyboardString();
            __FindKeyboardDelta();
            __HandleChanges();
        });
    }
}