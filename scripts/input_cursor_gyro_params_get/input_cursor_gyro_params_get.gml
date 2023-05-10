/// @desc    Gets parameters for the cursor when gamepad gyro is in use
/// @param   [playerIndex=0]

function input_cursor_gyro_params_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    static _result = {
        axis_x:        INPUT_GYRO_DEFAULT_AXIS_X,
        axis_y:        INPUT_GYRO_DEFAULT_AXIS_Y,
        sensitivity_x: INPUT_GYRO_DEFAULT_SENSITIVITY_X,
        sensitivity_y: INPUT_GYRO_DEFAULT_SENSITIVITY_Y,
        gamepad:       undefined,
    };

    _result.axis_x        = _global.__players[_player_index].__gyro_axis_x;
    _result.axis_y        = _global.__players[_player_index].__gyro_axis_y;
    _result.sensitivity_x = _global.__players[_player_index].__gyro_sensitivity_x;
    _result.sensitivity_y = _global.__players[_player_index].__gyro_sensitivity_y;
    _result.gamepad       = _global.__players[_player_index].__gyro_gamepad;
    
    return _result;
}