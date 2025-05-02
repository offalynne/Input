// Feather disable all

/// @param {Real} device
/// Returns concatenated vendor and product id for a gamepad as a string

function InputPlugInGamepadGetVendorAndProduct(_device)
{
    static _gamepadArray = __InputSystem().__gamepadArray;
    
    if ((_device >= 0) && (_device < array_length(_gamepadArray)))
    {
        with(_gamepadArray[_device])
        {
            return __vendor + __product;
        }
    }

    return "";
}