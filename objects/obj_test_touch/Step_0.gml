input_tick();
input_hotswap_tick();

if (input_mouse_check_released(mb_left))
{
    if (cell_active == cell_tapped) cell_taps[cell_active] += 1;
    cell_tapped = undefined;
}

cell_active = (input_mouse_x() div cell_w) + (input_mouse_y() div cell_h)*cell_split;

if (input_mouse_check_pressed(mb_left))
{
    cell_tapped = (input_mouse_x() div cell_w) + (input_mouse_y() div cell_h)*cell_split;
}