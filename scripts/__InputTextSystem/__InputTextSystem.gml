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
        
        __removeCount = 0;
        __textChanges = [];
        __textRequest = "";
        __textDelta   = "";        
        
        __newStatus     = undefined;
        __keyboardType  = kbv_type_default;
        __requestStatus = INPUT_TEXT_STATUS.NONE;
        __maxLength     = __INPUT_TEXT_MAX_LENGTH;
        
        __ignore       = false;
        __heldPrevious = false;
        __repeatCount  = 0;
        __pressedTime  = infinity;
        
        __virtualHeightPrevious = 0;
        __virtualStatusPrevious = false;
        __osPausedPrevious      = false;        
        __timePrevious          = InputPlugInGetTime();        
        
        __steamAsyncRequest = false;
        __useSteamKeyboard  = false;
        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAM_DECK)
        &&  InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            __useSteamKeyboard = true;
            steam_utils_enable_callbacks();
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

        __ShowKeyboard = function(_keyboardType, _caption, _initialText)
        {
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

            return _result;
        }
        
        __HandleKeyboardInput = function()
        {
            __keyboardString = keyboard_string;
            
            if (INPUT_ON_WEB || INPUT_ON_CONSOLE)
            {
                return;
            }            
            else if (INPUT_ON_MOBILE)
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
            var _deleteHeld  = _deleteCheck && ((keyboard_key == vk_backspace) || keyboard_check(ord(string_upper(keyboard_lastchar))));
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
            
            if (string_length(_keyboardString) == 0) return;

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
    
            var _overflow = string_length(_keyboardString) - __INPUT_TEXT_MAX_LENGTH;
            if (_overflow > 0)
            {
                _keyboardString = string_copy(_keyboardString, _overflow + 1, string_length(_keyboardString));
                __keyboardStringPrevious = string_copy(__keyboardStringPrevious, _overflow + 1, string_length(__keyboardStringPrevious));
            }
    
            if (_preLintString != _keyboardString)
            {
                if (INPUT_ON_IOS) keyboard_virtual_hide();
                keyboard_string = _keyboardString;
            }
        }
        
        __FindKeyboardDelta = function()
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
        
        __HandleChanges = function()
        {
            __keyboardStringPrevious = __keyboardString;
            
            if (__textAsync != undefined)
            {
                __textRequest = __textAsync;
                __textAsync   = undefined;
                __textSet     = undefined;
            }
            else if (__textSet != undefined)
            {
                __textRequest = __textSet;
                __textSet     = undefined;    
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
            if (__newStatus == undefined) return;

            if (__newStatus == INPUT_TEXT_STATUS.STOPPED)
            {
                if (INPUT_ON_MOBILE) keyboard_virtual_hide();
            }
                
            if (__newStatus != INPUT_TEXT_STATUS.WAITING)
            {
                if (is_method(__callback))
                {
                    __callback();
                }
                    
                __callback = undefined;
            }
                
            __requestStatus = __newStatus;                
            __newStatus = undefined;
        }
        
        __HandleController = function()
        {
            if (!instance_exists(__InputTextAsyncController) && (__steamAsyncRequest || (__asyncId != undefined)))
            {
                if (GM_build_type == "run")
                {
                    //Be nasty when running from the IDE >:(
                    __InputError("__InputTextAsyncController has been destroyed\nPlease ensure that __InputTextAsyncController is never destroyed");
                }
                else
                {
                    //Be nice when in production <:)
                    __InputTrace("Warning! __InputTextAsyncController has been destroyed. Please ensure that __InputTextAsyncController is never destroyed");
                }
                
                __steamAsyncRequest = false;
                __asyncId = undefined;
            }
        }

        InputPlugInRegisterCallback(INPUT_PLUG_IN_CALLBACK.UPDATE, undefined, function()
        {            
            if (__enabled)
            {
                __LintKeyboardString();
                __HandleKeyboardInput();
                __FindKeyboardDelta();
                __HandleController();
            }
            
            __HandleChanges();
            __HandleStatus();
        });
    }
}
