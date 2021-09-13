if (__INPUT_TOUCH_SUPPORT)
{
    //Draw touches
    var _i = 0;
    repeat(10)
    {
        draw_set_alpha(0.5);
        draw_set_color((global.__input_pointer_index == _i) ? c_blue : c_gray);
    
        if (device_mouse_check_button(_i, mb_left))
        {
            draw_circle(device_mouse_x_to_gui(_i), device_mouse_y_to_gui(_i), 80, 0);
        }
    
        ++_i;
    }

    //Draw margin
    var _margin = INPUT_TOUCH_EDGE_DEADZONE;
    draw_set_alpha(1/5);
    draw_rectangle(_margin, _margin, display_get_gui_width() - _margin, display_get_gui_height() - _margin, false);
    draw_set_alpha(1);
}