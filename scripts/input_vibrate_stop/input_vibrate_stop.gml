// Feather disable all
/// @desc    Immediately stops all vibration events for the given player
/// 
/// @param   [playerIndex=0]

function input_vibrate_stop(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    array_resize(_global.__players[_player_index].__vibration_event_array, 0);
}
