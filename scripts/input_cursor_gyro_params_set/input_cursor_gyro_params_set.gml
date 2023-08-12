// Feather disable all
/// @desc    Sets parameters for the cursor when gamepad gyro is in use
/// @param   [gyroAxisX=undefined]
/// @param   [gyroAxisY=undefined]
/// @param   [gyroSensitivityX=undefined]
/// @param   [gyroSensitivityY=undefined]
/// @param   [playerIndex=0]
/// @param   [gamepad=undefined]

function input_cursor_gyro_params_set(_gyro_axis_x = undefined, _gyro_axis_y = undefined, _gyro_sensitivity_x = undefined, _gyro_sensitivity_y = undefined, _player_index = 0, _gamepad = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_gyro_params_set(_gyro_axis_x, _gyro_axis_y, _gyro_sensitivity_x, _gyro_sensitivity_y, _p, _gamepad);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_gamepad != undefined) _global.__players[_player_index].__gyro_gamepad = _gamepad;

    if (_gyro_axis_x != undefined) _global.__players[_player_index].__gyro_axis_x = _gyro_axis_x;
    if (_gyro_axis_y != undefined) _global.__players[_player_index].__gyro_axis_y = _gyro_axis_y;

    if (_gyro_sensitivity_x != undefined) _global.__players[_player_index].__gyro_sensitivity_x = _gyro_sensitivity_x;
    if (_gyro_sensitivity_y != undefined) _global.__players[_player_index].__gyro_sensitivity_y = _gyro_sensitivity_y;
}
