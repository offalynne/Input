/// @desc    Returns an array containing the buttons/axes mapped for the current gamepad (as ints)
/// @param   index

function input_gamepad_get_map(_index)
{
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(global.__input_gamepads)))
    {
        return [];
    }
    
    var _gamepad = global.__input_gamepads[_index];
    if (!is_struct(_gamepad)) return [];
    
    with(_gamepad)
    {
        if (!custom_mapping)
        {
            //If we have no mapping then guess at what's available
            //This should only happen when we can't find an SDL map for the gamepad and we're not using a hard-coded map (e.g. for console)
            var _array = [];
            return array_copy(_array, 0, global.__input_gamepad_all, 0, array_length(global.__input_gamepad_all));
        }
        
        //Otherwise build an array to return based on the mapping in use
        var _output = array_create(array_length(mapping_array), undefined);
        
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            _output[@ _i] = mapping_array[_i].gm;
            ++_i;
        }
        
        return _output;
    }
}