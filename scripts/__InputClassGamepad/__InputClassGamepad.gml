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
    
    __prevValueArray = array_create(4, 0); // [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
    __valueArray     = array_create(4, 0); // [gp_axislh, gp_axislv, gp_axisrh, gp_axisrv]
    
    
    
    static __UpdatePrevValues = function()
    {
        if (INPUT_BAN_GAMEPADS || __blocked || (not gamepad_is_connected(__gamepadIndex)))
        {
            __prevValueArray[@ 0] = 0;
            __prevValueArray[@ 1] = 0;
            __prevValueArray[@ 2] = 0;
            __prevValueArray[@ 3] = 0;
            return;
        }
        
        array_copy(__prevValueArray, 0, __valueArray, 0, 4);
        __valueArray[@ 0] = __readArray[gp_axislh - INPUT_GAMEPAD_BINDING_MIN](__gamepadIndex, gp_axislh);
        __valueArray[@ 1] = __readArray[gp_axislv - INPUT_GAMEPAD_BINDING_MIN](__gamepadIndex, gp_axislv);
        __valueArray[@ 2] = __readArray[gp_axisrh - INPUT_GAMEPAD_BINDING_MIN](__gamepadIndex, gp_axisrh);
        __valueArray[@ 3] = __readArray[gp_axisrv - INPUT_GAMEPAD_BINDING_MIN](__gamepadIndex, gp_axisrv);
    }
}