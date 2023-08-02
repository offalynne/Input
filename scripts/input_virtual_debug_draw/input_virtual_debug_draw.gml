// Feather disable all
/// @desc    Draws a visualisation aid for virtual buttons
///          N.B.  This should be called in a Draw GUI event for accurate results

function input_virtual_debug_draw()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    var _i = 0;
    repeat(array_length(_global.__virtual_array))
    {
        _global.__virtual_array[_i].debug_draw();
        ++_i;
    }
}
