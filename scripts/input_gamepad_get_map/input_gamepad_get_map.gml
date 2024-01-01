// Feather disable all
/// @desc    Returns an array containing the buttons/axes mapped for the current gamepad (as ints)
/// @param   index

function input_gamepad_get_map(_index)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if ((_index == undefined)
    ||  (_index < 0)
    ||  (_index >= array_length(_global.__gamepads)))
    {
        return [];
    }
    
    var _gamepad = _global.__gamepads[_index];
    if (!is_struct(_gamepad)) return [];
    
    with(_gamepad)
    {
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
