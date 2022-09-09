input_tick();

var _gamepad = input_player_get_gamepad();
if (_gamepad >= 0)
{
    var _pan = input_value("right") - input_value("left");
    
    if (input_gamepad_check_pressed(_gamepad, gp_face1))
    {
        __input_trace("Testing constant event");
        input_vibrate_constant(1, _pan, 60);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face2))
    {
        __input_trace("Testing ADSR event");
        input_vibrate_adsr(1, 0.2, _pan, 300, 300, 600, 600);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face3))
    {
        __input_trace("Testing pulse event");
        input_vibrate_pulse(1, _pan, 5, 600);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_face4))
    {
        __input_trace("Testing curve event");
        input_vibrate_curve(1, curve_test_vibration, _pan, 1000);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_shoulderl))
    {
        __input_trace("Resuming vibration");
        input_vibrate_set_pause(false);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_shoulderr))
    {
        __input_trace("Pausing vibration");
        input_vibrate_set_pause(true);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_start))
    {
        __input_trace("Stopping all vibration events");
        input_vibrate_stop();
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_select))
    {
        __input_trace("Forcing a constant vibration event");
        input_vibrate_constant(1, _pan, 60, 0, true);
    }
}