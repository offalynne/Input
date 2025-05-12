// Feather disable all

function __InputTextHandleKeyboard()
{
    static _virtualHeightPrevious = 0;
    static _virtualStatusPrevious = false;
    static _osPausedPrevious      = false;
    static _heldPrevious          = false;
    static _ignore                = false;
    static _pressedTime           = infinity;
    static _timePrevious          = InputPlugInGetTime();
    
    __keyboardStringPrevious = __keyboardString;
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
            if (!_osPaused && _osPausedPrevious)
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
            else if (!_osPaused && !_virtualStatus && _virtualStatusPrevious)
            {
                __newStatus = INPUT_TEXT_STATUS.CANCELLED;
            }
        }
                
        _virtualHeightPrevious = _virtualHeight;
        _virtualStatusPrevious = _virtualStatus;
        _osPausedPrevious      = _osPaused;
    }
            
    if not (INPUT_ON_DESKTOP) return;

    var _keyReleased = keyboard_check_released(vk_anykey);
    var _deleteCheck = keyboard_check(vk_backspace) && !keyboard_check(vk_control) && !keyboard_check(vk_alt);
    var _deleteHeld  = _deleteCheck && ((keyboard_key == vk_backspace) || keyboard_check(ord(string_upper(keyboard_lastchar))));
    var _currentTime = InputPlugInGetTime();
            
    if (_deleteHeld && _keyReleased)
    {
        _pressedTime = _currentTime;
    }            
            
    if (_ignore && !_deleteCheck)
    {
        _ignore = false;
    }
    else if (keyboard_check(vk_anykey) && !_deleteHeld)
    {
        _ignore = true;
    }
            
    __repeatCount = 0;
            
    if (!_ignore && _deleteHeld)
    {
        if (!_heldPrevious)
        {
            __repeatCount = 1;
            _pressedTime = _currentTime;
        }
        else
        {
            var _heldTime = _currentTime - _pressedTime;
            if (_heldTime < INPUT_TEXT_REPEAT_DELAY)
            {
                __repeatCount = 0;
            }
            else
            {
                var _repeatStart = _pressedTime + INPUT_TEXT_REPEAT_DELAY;
                var _repeatCountPrevious = floor((_timePrevious  - _repeatStart)/INPUT_TEXT_REPEAT_INTERVAL);
                var _repeatCountCurrent  = floor((_currentTime   - _repeatStart)/INPUT_TEXT_REPEAT_INTERVAL);
                __repeatCount = max(0, _repeatCountCurrent - _repeatCountPrevious);
            }
        }
    }
            
    if (__useSteamKeyboard) 
    {
        steam_update();
    }
            
    _heldPrevious = _deleteHeld;
    _timePrevious = _currentTime;
}
