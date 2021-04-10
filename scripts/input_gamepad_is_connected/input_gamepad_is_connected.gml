/// @param gamepadIndex

function input_gamepad_is_connected(_index)
{
    if (_index < 0) return false;
    
    return gamepad_is_connected(_index);
}