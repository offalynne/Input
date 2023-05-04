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
        if (!custom_mapping)
        {
            //If we have no mapping then guess at what's available
            //This should only happen when we can't find an SDL map for the gamepad and we're not using a hard-coded map (e.g. for console)
            var _mappings = [gp_face1, gp_face2, gp_face3, gp_face4,
                             gp_padd, gp_padu, gp_padl, gp_padr,
                             gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                             gp_axislh, gp_axislv, gp_axisrh, gp_axisrv,
                             gp_start, gp_stickl, gp_stickr];
                            
            if (!__INPUT_ON_PS || !INPUT_PS_TOUCHPAD_ALLOWED) array_push(_mappings, gp_select);
            
            return _mappings;
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