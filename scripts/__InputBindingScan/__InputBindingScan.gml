function __InputBindingScan(_device, _ignoreStruct, _allowStruct)
{
    static _system = __InputSystem();
    
    static _funcFilter = function(_input, _ignoreStruct, _allowStruct) //Returns <false> if the binding failed to pass the filter
    {
        if (is_struct(_ignoreStruct) && variable_struct_exists(_ignoreStruct, string(_input))) return false;
        if (is_struct(_allowStruct) && (not variable_struct_exists(_allowStruct, string(_input)))) return false;
        return true;
    }
    
    if (_device == INPUT_KBM)
    {
        if (not INPUT_BAN_KBM)
        {
            var _binding = __InputGetKeyboardOutput();
            if ((_binding != undefined) && _funcFilter(_binding, _ignoreStruct, _allowStruct))
            {
                ////On Mac we update the binding label to the actual keyboard character if it is a Basic Latin alphabetic character
                ////This works around problems where a keyboard might be sending a character code for e.g. A but the OS is typing another letter
                //if (INPUT_ON_MACOS)
                //{
                //    var _keychar = string_upper(keyboard_lastchar);
                //                    
                //    //Basic Latin only
                //    if ((ord(_keychar) >= ord("A")) && (ord(_keychar) <= ord("Z")))
                //    {
                //        _result.labelOverride = _keychar; 
                //    }
                //}
                
                return _binding;
            }
        }
        
        if (not INPUT_BLOCK_MOUSE_CHECKS)
        {
            var _binding = __InputGetMouseOutput();
            if ((_binding != undefined) && _funcFilter(_binding, _ignoreStruct, _allowStruct))
            {
                return _binding;
            }
        }
    }
    else if (InputDeviceIsGamepad(_device))
    {
        if (not INPUT_BAN_GAMEPADS)
        {
            var _binding = __InputGetGamepadOutput(_device);
            if ((_binding != undefined) && _funcFilter(_binding, _ignoreStruct, _allowStruct))
            {
                return sign(InputDeviceGetGamepadValue(_device, _binding))*_binding;
            }
        }
    }
    
    return undefined;
}
