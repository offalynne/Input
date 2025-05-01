// Feather disable all

/// Returns the first available (i.e. unassigned) device that has activity on a verb (as though a
/// player had been assigned the device).
/// 
/// @param {Enum.INPUT_VERB,Real} verbIndex
/// @parma {Real} [playerIndex=0]

function InputDeviceGetNewActivityOnVerb(_verbIndex, _playerIndex = 0)
{
    __INPUT_VALIDATE_PLAYER_INDEX
    
    var _array = InputDeviceEnumerate(false);
    var _i = 0;
    repeat(array_length(_array))
    {
        var _device = _array[_i];
        if (InputDeviceIsAvailable(_device)
        &&  InputDeviceCheckViaPlayer(_device, _verbIndex, _playerIndex))
        {
            return _device;
        }
        
        ++_i;
    }
    
    return INPUT_NO_DEVICE;
}