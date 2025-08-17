// Feather disable all

function __InputSteamHandlesChanged()
{
    static _system = __InputSystem();
    with(_system)
    {
        var _oldSteamHandles = __steamHandlesArray;
        var _newSteamHandles = steam_input_get_connected_controllers();
        
        //Catch any edge cases where steam_input_get_connected_controllers() returns invalid data
        if (not is_array(_newSteamHandles)) return false;
        
        __steamHandlesArray = _newSteamHandles;
        
        if (array_length(_newSteamHandles) != array_length(_oldSteamHandles))
        {
            //Handle count changed
            if (__INPUT_DEBUG_STEAM_INPUT) __InputTrace("Steam handle array length mismatch (old=", array_length(_oldSteamHandles), ", new=", array_length(_newSteamHandles), ")");
            return true;
        }
    
        var _i = 0;
        repeat(array_length(_newSteamHandles))
        {
            if (_newSteamHandles[_i] != _oldSteamHandles[_i])
            {
                //Handle value changed (type)
                if (__INPUT_DEBUG_STEAM_INPUT) __InputTrace("Steam handle value changed (index=", _i, ", old=", _oldSteamHandles[_i], ", new=", _newSteamHandles[_i], ")");
                return true;
            }
            ++_i;
        }
    
        _i = 0;
        repeat(array_length(__gamepadArray))
        {
            var _gamepad = __gamepadArray[_i];
            
            if (is_struct(_gamepad) && (_gamepad.__steamHandle != undefined) 
            && (_gamepad.__steamHandleIndex != steam_input_get_gamepad_index_for_controller(_gamepad.__steamHandle)))
            {
                //Index change (likely exchanging slot)
                if (__INPUT_DEBUG_STEAM_INPUT) __InputTrace("Steam gamped index changed (index=", _i, ", gamepad=", _gamepad.__gamepadIndex, ", handle=", _gamepad.__steamHandle, ", old handle index=", _gamepad.__steamHandleIndex, ", new handle index=", steam_input_get_gamepad_index_for_controller(_gamepad.__steamHandle), ")");
                return true;
            }
            
            ++_i;
        }
    }
    
    return false;
}