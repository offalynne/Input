// Feather disable all
/// @desc    Sets the strength of vibration for the player
/// @param   strength
/// @param   [playerIndex=0]

function input_vibrate_set_strength(_strength, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _strength = clamp(_strength, 0, 1);
    
    _global.__players[_player_index].__vibration_strength = _strength;
}
