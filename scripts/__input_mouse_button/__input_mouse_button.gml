function __input_mouse_button(){
    
    if mouse_check_button(mouse_button)
    {
        return mouse_button;
    }
    
    return global.__input_tap_click;
}