/// @desc    Gets gamepad motion data for a player
//           Returned value is a struct containing normalized 
//           acceleration (Gs) and angular velocity (rad/s) values 
/// @param   [playerIndex=0]

function input_motion_data_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX

    return _global.__players[_player_index].__motion_data_get();
}