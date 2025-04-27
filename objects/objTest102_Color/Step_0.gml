//Feather disable all

if (InputPlayerUsingGamepad())
{
    var _device = InputPlayerGetDevice();
    
    if (gamepad_button_check_pressed(_device, gp_face1))
    {
        show_debug_message("Gamepad color = red");
        InputColorSet(c_red);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face2))
    {
        show_debug_message("Gamepad color = yellow");
        InputColorSet(c_yellow);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face3))
    {
        show_debug_message("Gamepad color = lime");
        InputColorSet(c_lime);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face4))
    {
        show_debug_message("Gamepad color = blue");
        InputColorSet(c_blue);
    }
    
    if (gamepad_button_check_pressed(_device, gp_start))
    {
        show_debug_message("Restting gamepad color");
        InputColorReset();
    }
}