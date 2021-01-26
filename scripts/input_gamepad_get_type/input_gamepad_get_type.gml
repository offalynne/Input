/// @param gamepadIndex

function input_gamepad_get_type(_index)
{
    if (is_struct(_index))
    {
        var _gamepad = _index;
    }
    else
    {
        var _gamepad = global.__input_gamepads[_index];
    }
    
    if (!is_struct(_gamepad)) return "unknown";
    
    with(_gamepad)
    {
        if (type != undefined) return type;
        
        if (xinput == true)
        {
            type = "xbox360";
        }
        else if (!variable_struct_exists(global.__input_type_dictionary, vendor + product))
        {
            type = "unknown";
        }
        else
        {
            type = global.__input_type_dictionary[$ vendor + product];
        }
        
        return type;
    }
}