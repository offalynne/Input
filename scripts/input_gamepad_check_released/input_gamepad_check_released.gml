/// @desc    Checks if the given button/axis is newly deactivated this frame
/// @param   gamepadIndex
/// @param   GMconstant

function input_gamepad_check_released(_index, _gm)
{
    if (global.__input_cleared
    ||  (_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return false;
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return false;
    
    if not ((_gm >= gp_none) && (_gm <= gp_any))
    {
        return _gamepad.get_released(_gm);
    }
    else
    {
        var _keyword_config = global.__input_gamepad_keyword_config[$ string(_gm)];
        
        var _i = 0;
        repeat(array_length(global.__input_gamepad_all))
        {
            var _gm_i = global.__input_gamepad_all[@ _i];
            
            if (_gamepad.get_released(_gm_i))    
            {
                if (_gamepad.is_axis(_gm_i))
                {
                    if (_keyword_config.axes) return !(_keyword_config.negative);
                }
                else
                {
                    if (_keyword_config.buttons) return !(_keyword_config.negative);
                }                    
            }

            ++_i;
        }
        
        return _keyword_config.negative;
    }
}
