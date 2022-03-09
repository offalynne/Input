/// @param gamepadIndex

function input_gamepad_is_connected(_gamepad_index)
{
    if (_gamepad_index < 0) return false;
    
    var _gamepad = global.__input_gamepads[_gamepad_index];
    if (is_struct(_gamepad))
    {
        if (_gamepad.blacklisted)
        {
            return false;
        }
    }
    
    return gamepad_is_connected(_gamepad_index);
}