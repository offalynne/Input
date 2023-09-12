//Feather disable all

var _gamepad = input_player_get_gamepad();
if (input_gamepad_is_connected(_gamepad))
{
    input_cursor_gyro_enabled_set((input_check("shoot")));
    
    if (input_check_pressed("special"))
    {
        input_cursor_translate(undefined, room_height/2, 10);
    }
    
    if (input_check_pressed("left"))
    {
        input_cursor_gyro_params_set(INPUT_GYRO.AXIS_ROLL);
    }
    
    if (input_check_pressed("right"))
    {        
        input_cursor_gyro_params_set(INPUT_GYRO.AXIS_YAW);
    }
    
    if (input_check_pressed("up"))
    {        
        input_cursor_gyro_params_set(undefined, undefined, 1, -1);
    }
    
    if (input_check_pressed("down"))
    {        
        input_cursor_gyro_params_set(undefined, undefined, 5, -5);
    }
}