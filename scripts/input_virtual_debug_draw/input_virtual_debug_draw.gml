/// @desc    Draws a visualisation aid for virtual buttons
///          N.B.  This should be called in a Draw GUI event for accurate results

function input_virtual_debug_draw()
{
    var _i = 0;
    repeat(array_length(global.__input_virtual_array))
    {
        global.__input_virtual_array[_i].debug_draw();
        ++_i;
    }
}