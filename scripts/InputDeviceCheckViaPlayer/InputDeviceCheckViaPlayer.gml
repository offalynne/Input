// Feather disable all

/// Returns the verb value if the targetted device was assigned to a player.
/// 
/// @param {Real}  device
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @param {Real} [playerIndex=0]

function InputDeviceCheckViaPlayer(_device, _verbIndex, _playerIndex = 0)
{
    static _playerArray = __InputSystemPlayerArray();
    
    with(_playerArray[_playerIndex])
    {
        if (_device >= 0)
        {
            var _readArray = __InputGamepadGetReadArray(_device);
            
            var _alternateArray = __gamepadBindingArray[_verbIndex];
            var _i = 0;
            repeat(array_length(_alternateArray))
            {
                var _rawBinding = _alternateArray[_i];
                if (_rawBinding != undefined)
                {
                    var _absBinding = abs(_rawBinding);
                    if (sign(_rawBinding)*_readArray[_absBinding - INPUT_GAMEPAD_BINDING_MIN](_device, _absBinding) > INPUT_GAMEPAD_THUMBSTICK_MIN_THRESHOLD)
                    {
                        return true;
                    }
                }
                
                ++_i;
            }
        }
        else if (_device == INPUT_KBM)
        {
            var _alternateArray = __kbmBindingArray[_verbIndex];
            var _i = 0;
            repeat(array_length(_alternateArray))
            {
                var _binding = _alternateArray[_i];
                
                if ((_binding == mb_left)
                 || (_binding == mb_middle)
                 || (_binding == mb_right)
                 || (_binding == mb_side1)
                 || (_binding == mb_side2))
                {
                    if (mouse_check_button(_binding)) return true;
                }
                else if (_binding == mb_wheel_up)
                {
                    if (mouse_wheel_up()) return true;
                }
                else if (_binding == mb_wheel_down)
                {
                    if (mouse_wheel_down()) return true;
                }
                else if (_binding != undefined)
                {
                    if (keyboard_check(_binding)) return true;
                }
                
                ++_i;
            }
        }
        else //Touch or no device
        {
            return false;
        }
    }
}