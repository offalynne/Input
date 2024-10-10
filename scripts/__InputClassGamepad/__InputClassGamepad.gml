// Feather disable all

/// @param gamepadIndex

function __InputClassGamepad(_gamepadIndex) constructor
{
    static _genericReadArray = __InputSystem().__genericReadArray;
    
    __gamepadIndex      = _gamepadIndex;
    __blocked           = false;
    __lastConnectedTime = current_time;
    
    __guid    = undefined;
    __vendor  = "";
    __product = "";
    
    __description = "Generic Gamepad";
    __type        = INPUT_GAMEPAD_TYPE_XBOX;
    __xinput      = false;
    
    __xinput            = false;
    __steamHandle       = undefined;
    __steamHandleIndex  = undefined;
    
    __readArray = variable_clone(_genericReadArray, 1);
}