//Release
var _released = input_mouse_check_released(mb_left);
if (_released || input_mouse_check(mb_none))
{
    //Active
    if (_released && (cell_active == cell_tapped))
    {
        cell_taps[cell_active] += 1;
    }
        
    cell_tapped = undefined;
}

//Hover
cell_active = clamp(input_mouse_x() div cell_w, 0, cell_split-1) + cell_split*clamp(input_mouse_y() div cell_h, 0, cell_split-1);

//Press
if (input_mouse_check_pressed(mb_left))
{
    cell_tapped = cell_active;
}
