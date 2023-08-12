// Feather disable all
/// @desc    Sets whether a player may use gamepad gyro to drive the cursor
/// @param   State
/// @param   [playerIndex=0]

function input_cursor_gyro_enabled_set(_state, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX

    _global.__players[_player_index].__gyro_enabled_set(_state);
}
