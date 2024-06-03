// Feather disable all
/// @desc    Gets parameters for the cursor when gamepad gyro is in use
/// @param   [playerIndex=0]

function input_cursor_gyro_params_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    static _result = {
        __axis_x:        INPUT_GYRO_DEFAULT_AXIS_X,
        __axis_y:        INPUT_GYRO_DEFAULT_AXIS_Y,
        __sensitivity_x: INPUT_GYRO_DEFAULT_SENSITIVITY_X,
        __sensitivity_y: INPUT_GYRO_DEFAULT_SENSITIVITY_Y,
        __gamepad:       undefined,
    };

    _result.__axis_x        = _global.__players[_player_index].__gyro_axis_x;
    _result.__axis_y        = _global.__players[_player_index].__gyro_axis_y;
    _result.__sensitivity_x = _global.__players[_player_index].__gyro_sensitivity_x;
    _result.__sensitivity_y = _global.__players[_player_index].__gyro_sensitivity_y;
    _result.__gamepad       = _global.__players[_player_index].__gyro_gamepad;
    
    return _result;
}
