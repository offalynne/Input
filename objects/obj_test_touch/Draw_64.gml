if (__INPUT_TOUCH_SUPPORT && !__INPUT_ON_PS)
{
    //Draw touches
    var _i = 0;
    repeat(INPUT_MAX_TOUCHPOINTS)
    {
        draw_set_alpha(1/2);
        
        switch(_i)
        {
            case 0: draw_set_colour(c_gray);  break;
            case 1: draw_set_colour(c_red);   break;
            case 2: draw_set_colour(c_green); break;
            case 3: draw_set_colour(c_blue);  break;
        }
        
        if (device_mouse_check_button(_i, mb_left))
        {
            draw_circle(device_mouse_x_to_gui(_i), device_mouse_y_to_gui(_i), 80, 0);
        }
    
        ++_i;
    }

    //Draw margin
    draw_set_alpha(1/5);
    draw_set_color(c_white);
    var _margin = INPUT_TOUCH_EDGE_DEADZONE;
    draw_rectangle(_margin, _margin, display_get_gui_width() - _margin, display_get_gui_height() - _margin, false);
    draw_set_alpha(1);
}