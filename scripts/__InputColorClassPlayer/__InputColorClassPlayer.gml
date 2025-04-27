// Feather disable all

/// @param playerIndex

function __InputColorClassPlayer(_playerIndex) constructor
{
    __playerIndex = _playerIndex;
    
    __color = undefined;
    
    static __SetColor = function(_color)
    {
        static _deviceMap = __InputVibrateSystem().__deviceMap;
        
        __color = _color;
        
        var _device = InputPlayerGetDevice(__playerIndex);
        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            var _steamHandle = InputDeviceGetSteamHandle(_device);
            if (_steamHandle != undefined)
            {
                var _ledFlag = steam_input_led_flag_set_color;
                if (_color == undefined)
                {
                    _color = 0;
                    _ledFlag = steam_input_led_flag_restore_user_default;
                }           
                
                steam_input_set_led_color(_steamHandle, _color, _ledFlag);
            }
        }
        else if (INPUT_ON_PS4 || INPUT_ON_PS5)
        {
            if (_color == undefined)
            {
                if (INPUT_ON_PS4) ps4_gamepad_reset_color(_device);
                if (INPUT_ON_PS5) ps5_gamepad_reset_color(_device);
            }
            else
            {
                gamepad_set_color(_device, _color);
            }
        }
    }
    
    static __SupportedByDevice = function()
    {
        var _device = InputPlayerGetDevice(__playerIndex);
        
        if (InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
        {
            var _steamHandle = InputDeviceGetSteamHandle(_device);
            if (_steamHandle != undefined)
            {
                var _type = InputDeviceGetGamepadType(_device);
                return ((_type == INPUT_GAMEPAD_TYPE_PS4) || (_type == INPUT_GAMEPAD_TYPE_PS5));
            }
        }
        else if (INPUT_ON_PS4 || INPUT_ON_PS5)
        {
            return InputDeviceIsConnected(_device);
        }
        
        return false;
    }
}