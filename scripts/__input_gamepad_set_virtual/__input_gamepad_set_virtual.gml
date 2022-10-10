/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_virtual()
{
    if not (global.__input_using_steamworks) exit;
    
    var _gamepad_is_virtual = ((os_type == os_windows) && xinput);
    var _slot = index;
    if (os_type == os_linux)
    {
        var _gamepad_handle_index = -1;
        var _gamepad_is_virtual = false;

        var _i = 0;
        repeat(index + 1)
        {
            if ((gamepad_get_description(_i) == "Valve Streaming Gamepad") || __input_string_contains(gamepad_get_guid(_i), "03000000de280000fc11", "03000000de280000ff11"))
            {
                _gamepad_handle_index++;
                _gamepad_is_virtual = true;
            }
            ++_i;
        }

        _slot = _gamepad_handle_index;
    }

    __steam_handle = steam_input_get_controller_for_gamepad_index(_slot);
    if not (_gamepad_is_virtual && is_numeric(__steam_handle) && (__steam_handle > 0))
    {
        __steam_handle = undefined;
    }
    else
    {
        __steam_handle_index = steam_input_get_gamepad_index_for_controller(__steam_handle);
        if (__steam_handle_index == -1) exit;
                
        var _handle_type = steam_input_get_input_type_for_handle(__steam_handle);
        if not (is_numeric(_handle_type) && (_handle_type >= 0)) exit;

        var _description = global.__input_steam_type_to_name[$ _handle_type];
        if (_description == undefined) exit;
        
        var _raw_type = global.__input_steam_type_to_raw[$ _handle_type];
        if (_raw_type == undefined) exit;
        
        var _simple_type = global.__input_simple_type_lookup[$ _raw_type];
        if (_simple_type == undefined) exit;

        description = _description;
        raw_type    = _raw_type;
        simple_type = _simple_type;
    }
}
