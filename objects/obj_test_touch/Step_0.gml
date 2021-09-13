input_tick();
input_hotswap_tick();

//Release
var _released = input_mouse_check_released(mb_left)
if (_released || input_mouse_check(mb_none))
{
    if (_released && (cell_active == cell_tapped))
    {
        cell_taps[cell_active] += 1;
    }
        
    cell_tapped = undefined;
}

//Hover
cell_active = (input_mouse_x() div cell_w) + (input_mouse_y() div cell_h)*cell_split;

//Press
if (input_mouse_check_pressed(mb_left))
{
    cell_tapped = cell_active;
}