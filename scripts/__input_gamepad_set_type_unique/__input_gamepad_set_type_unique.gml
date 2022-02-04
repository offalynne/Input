function __input_gamepad_set_type_unique()
{
    if ((os_type == os_windows) && (vendor == "0d00") && (product == "0000")
    && (gamepad_button_count(index) == 15) && (gamepad_axis_count(index) == 4)
    && (gamepad_hat_count(index) == 0))
    {
        description = "MFi Extended Controller";
        raw_type = "AppleController";
        simple_type = "xbox one";
        
        return true;
    }
    
    return false;
}