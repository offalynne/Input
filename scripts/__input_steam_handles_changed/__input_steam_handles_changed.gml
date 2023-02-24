/// Returns whether Steam Input handles have changed since last tick

function __input_steam_handles_changed()
{
    var _steam_handles = steam_input_get_connected_controllers();
    
    //Catch any edge cases where steam_input_get_connected_controllers() returns invalid data
    if (!is_array(_steam_handles)) return false;
    
    if (array_length(_steam_handles) != array_length(global.__input_steam_handles))
    {
        //Handle count changed
        return true;
    }
    
    var _i = 0;
    repeat(array_length(_steam_handles))
    {
        if (_steam_handles[_i] != global.__input_steam_handles[_i])
        {
            //Handle value changed (type)
            return true;
        }
        ++_i;
    }
    
    _i = 0;
    repeat(array_length(global.__input_gamepads))
    {
        var _gamepad = global.__input_gamepads[_i];
        if (is_struct(_gamepad) && (_gamepad.__steam_handle != undefined) 
        && (_gamepad.__steam_handle_index != steam_input_get_gamepad_index_for_controller(_gamepad.__steam_handle)))
        {
            //Index change (likely exchanging slot)
            return true;
        }
        ++_i;
    }
    
    return false;
}
