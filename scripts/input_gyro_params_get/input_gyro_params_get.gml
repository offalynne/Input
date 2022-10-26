/// @desc    Gets parameters for the cursor when gamepad gyro is in use
/// @param   [playerIndex=0]

function input_gyro_params_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX

    return { 
        axis_x: global.__input_players[_player_index].__gyro_axis_x,
        axis_y: global.__input_players[_player_index].__gyro_axis_y,

        sensitivity_x: global.__input_players[_player_index].__gyro_sensitivity_x,
        sensitivity_y: global.__input_players[_player_index].__gyro_sensitivity_y
    };
}
