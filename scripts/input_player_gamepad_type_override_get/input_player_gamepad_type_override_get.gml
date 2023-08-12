// Feather disable all
/// @desc    Returns the gamepad type override for the player
///          This function will return <undefined> if no override has been set
/// @param   [playerIndex=0]

function input_player_gamepad_type_override_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__gamepad_type_override;
}
