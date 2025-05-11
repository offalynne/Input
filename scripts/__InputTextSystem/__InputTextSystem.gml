enum INPUT_TEXT_STATUS
{
    NONE,
    WAITING,
    STOPPED,
    CANCELLED,
    CONFIRMED,
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
        __callback  = undefined;
        __asyncId   = undefined;
        __textSet   = undefined;
        __textAsync = undefined;
        
        __virtualHeightPrevious = 0;
        __virtualStatusPrevious = false;
        __osPausedPrevious      = false;
        
        __removeCount = 0;
        __textChanges = [];
        __textRequest = "";
        __textDelta   = "";        
        
        __maxLength     = __INPUT_TEXT_MAX_LENGTH;
        __keyboardType  = kbv_type_default;
        __requestStatus = INPUT_TEXT_STATUS.NONE;
        __newStatus     = undefined;
        
        __ignore       = false;
        __heldPrevious = false;
        __pressedTime  = infinity;
        __repeatCount  = 0;
        
        __timePrevious = InputPlugInGetTime();        
        
        __useSteamKeyboard = false;        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            __useSteamKeyboard = true;
            steam_utils_enable_callbacks();
        }
        
        __emptyString = "";
        if (INPUT_ON_ANDROID)
        {
            __emptyString = " ";
            keyboard_string = __emptyString;
        }
        
        __keyboardString = keyboard_string;   
        __keyboardStringPrevious = __keyboardString;
        
        __ApplyChanges = function()
        {
            var _i = 0;
            repeat(array_length(__textChanges))
            {
                var _value = __textChanges[_i];
                if (is_string(_value))
                {
                    __textRequest += _value;
                }
                else if (is_real(_value))
                {
                    __textRequest = string_copy(__textRequest, 1, max(0, string_length(__textRequest) - _value));
                }
                
                ++_i;
            }
            
            array_resize(__textChanges, 0);            
            __textRequest = string_copy(__textRequest, 1, __maxLength);
        }

        __ShowKeyboard = function(_keyboardType, _caption, _initialText, _playerIndex)
        {
            if (INPUT_ON_CONSOLE || INPUT_ON_WEB)
            {
                __asyncId = get_string_async(_caption, _initialText);    
            }
            else if (INPUT_ON_MOBILE)
            {
                _initialText = __emptyString + _initialText;                
                keyboard_string = _initialText;                
                keyboard_virtual_show(_keyboardType, INPUT_TEXT_RETURN_KEY, INPUT_TEXT_CAPITALIZATION, INPUT_TEXT_PREDICTION);
            }
            else if (__useSteamKeyboard && InputPlayerUsingGamepad(_playerIndex))
            {
                return steam_show_gamepad_text_input(
                            steam_gamepad_text_input_mode_normal, 
                            steam_gamepad_text_input_line_mode_single_line, 
                            _caption, __maxLength, _initialText);
            }

            return true;
        }
        
        __HandleKeyboardInput = function()
        {
            __keyboardStringPrevious = __keyboardString;
            __keyboardString = keyboard_string;
            
            if (INPUT_ON_WEB) return;
            
            if (INPUT_ON_MOBILE)
            {
                var _osPaused = os_is_paused();
                var _virtualStatus = keyboard_virtual_status();
                var _virtualHeight = keyboard_virtual_height();
                
                if (__requestStatus == INPUT_TEXT_STATUS.WAITING)
                {
                    if (!_osPaused && __osPausedPrevious)
                    {
                        keyboard_virtual_show(__keyboardType, INPUT_TEXT_RETURN_KEY, INPUT_TEXT_CAPITALIZATION, INPUT_TEXT_PREDICTION);
                    }
                
                    var _tail = "";
                    if (string_length(__keyboardString) > string_length(__keyboardStringPrevious))
                    {
                        _tail = string_copy(__keyboardString, string_length(__keyboardString), 1);
                    }
                
                    if ((keyboard_check_pressed(0x0A) || (_tail == chr(0x0A)))  // Line feed
                    ||  (keyboard_check_pressed(0x0D) || (_tail == chr(0x0D)))) // Carriage Return
                    {
                        __newStatus = INPUT_TEXT_STATUS.CONFIRMED;
                        keyboard_virtual_hide();
                    }                
                    else if (!_osPaused)
                    {
                        if ((!_virtualStatus && __virtualStatusPrevious) || ((_virtualHeight == 0) && (__virtualHeightPrevious > 0)))
                        {
                            __newStatus = INPUT_TEXT_STATUS.CANCELLED;
                        }
                    }
                }
                
                __virtualHeightPrevious = _virtualHeight;
                __virtualStatusPrevious = _virtualStatus;
                __osPausedPrevious      = _osPaused;
            }
            
            if not (INPUT_ON_DESKTOP) return;

            var _keyReleased = keyboard_check_released(vk_anykey);    
            var _deleteCheck = keyboard_check(vk_backspace) && !keyboard_check(vk_control) && !keyboard_check(vk_alt);
            var _deleteHeld  = _deleteCheck && ((keyboard_key == vk_backspace) || keyboard_check(ord(keyboard_lastchar)));            
            
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
            
            if (__useSteamKeyboard) 
            {
                steam_update();
            }
            
            __heldPrevious = _deleteHeld;
            __timePrevious = _currentTime;
        }
        
        __LintKeyboardString = function()
        {   
            var _preLintString = keyboard_string;
            var _keyboardString = _preLintString;
            
            if ((string_length(_keyboardString) > 0) && (_keyboardString == ""))
            {
                if (INPUT_ON_IOS) keyboard_virtual_hide();
                keyboard_string = "";
            }
            
            if (_keyboardString == "")
            {
                _keyboardString = __emptyString;
            }
            
            if (string_length(_keyboardString) == 0)
            {
                return;
            }

            var _charFilter = [
                0x0A, // Line feed
                0x0D, // Carriage Return
                0x7F  // Ctrl+Del
            ];
            
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
    
            if (_preLintString != _keyboardString)
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
            
            var _offsetChar = INPUT_ON_ANDROID? 1 : 0;
            if (_keyboardString != __keyboardStringPrevious)
            {
                var _i = 1 + _offsetChar;
                repeat(_length)
                {
                    if (string_char_at(_keyboardString, _i) != string_char_at(__keyboardStringPrevious, _i)) break;
                    ++_i;
                }
        
                __textDelta = string_copy(_keyboardString, _i, _length);
            }
    
            if (string_length(__keyboardStringPrevious) > _offsetChar)
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
                if ((__newStatus == undefined) && (__requestStatus == INPUT_TEXT_STATUS.WAITING) && (array_length(__textChanges) == 0))
                {
                    if (__removeCount > 0) array_push(__textChanges, __removeCount);
                    if (string_length(__textDelta)) array_push(__textChanges, __textDelta);
                }

                __ApplyChanges();
            }
        }
        
        __HandleStatus = function()
        {   
            if (__newStatus != undefined)
            {
                if (__newStatus == INPUT_TEXT_STATUS.STOPPED)
                {
                    if (INPUT_ON_MOBILE) keyboard_virtual_hide();
                }
                
                if ((__newStatus != INPUT_TEXT_STATUS.WAITING) && is_method(__callback))
                {
                    __callback();
                    __callback = undefined;
                }
                
                __requestStatus = __newStatus;                
                __newStatus = undefined;
            }
        }

        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
        {            
            __LintKeyboardString();
            __HandleKeyboardInput();
            __FindKeyboardDelta();
            __HandleChanges();
            __HandleStatus();
        });
    }
}
