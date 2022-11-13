var _gamepad = input_player_get_gamepad();
if (input_gamepad_is_connected(_gamepad))
{
    input_gyro_enabled_set(input_gamepad_check(_gamepad, gp_shoulderl));
    if (input_gamepad_check_pressed(_gamepad, gp_shoulderr))
    {
        input_cursor_translate(undefined, room_height/2, 10);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padl))
    {
        input_gyro_params_set(INPUT_GYRO.AXIS_ROLL);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padr))
    {        
        input_gyro_params_set(INPUT_GYRO.AXIS_YAW);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padu))
    {        
        input_gyro_params_set(undefined, undefined, 1, -1);
    }
    
    if (input_gamepad_check_pressed(_gamepad, gp_padd))
    {        
        input_gyro_params_set(undefined, undefined, 5, -5);
    }
}