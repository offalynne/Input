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
            return true;
        }
    
        var _i = 0;
        repeat(array_length(_newSteamHandles))
        {
            if (_newSteamHandles[_i] != _oldSteamHandles[_i])
            {
                //Handle value changed (type)
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
                return true;
            }
            ++_i;
        }
    }
    
    return false;
}