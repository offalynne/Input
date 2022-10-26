/// @desc    Gets gamepad motion data for a player
//           Returned value is a struct containing normalized 
//           acceleration (Gs) and angular velocity (rad/s) values 
/// @param   [playerIndex=0]

function input_motion_data_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX

    var _gamepad = input_player_get_gamepad(_player_index);
    if ((_gamepad < 0) || !is_struct(global.__input_gamepads[_gamepad].__motion))
    {
        return undefined;
    }

    return global.__input_gamepads[_gamepad].__motion.__tick();
}