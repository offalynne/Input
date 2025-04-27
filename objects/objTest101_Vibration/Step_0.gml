//Feather disable all

if (InputPlayerUsingGamepad())
{
    var _device = InputPlayerGetDevice();
    
    var _pan = InputValue(INPUT_VERB.RIGHT) - InputValue(INPUT_VERB.LEFT);
    
    if (gamepad_button_check_pressed(_device, gp_face1))
    {
        show_debug_message("Testing constant event");
        InputVibrateConstant(1, _pan, 100);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face2))
    {
        show_debug_message("Testing ADSR event");
        InputVibrateADSR(1, 0.2, _pan, 300, 300, 600, 600);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face3))
    {
        show_debug_message("Testing pulse event");
        InputVibratePulse(1, _pan, 3, 1000);
    }
    
    if (gamepad_button_check_pressed(_device, gp_face4))
    {
        show_debug_message("Testing curve event");
        InputVibrateCurve(1, acVibrationTest, _pan, 1000);
    }
    
    if (gamepad_button_check_pressed(_device, gp_shoulderl))
    {
        show_debug_message("Resuming vibration");
        InputVibrateSetPause(false);
    }
    
    if (gamepad_button_check_pressed(_device, gp_shoulderr))
    {
        show_debug_message("Pausing vibration");
        InputVibrateSetPause(true);
    }
    
    if (gamepad_button_check_pressed(_device, gp_start))
    {
        show_debug_message("Stopping all vibration events");
        InputVibrateStop();
    }
    
    if (gamepad_button_check_pressed(_device, gp_select))
    {
        show_debug_message("Forcing a constant vibration event");
        InputVibrateConstant(1, _pan, 60, 0, true);
    }
}