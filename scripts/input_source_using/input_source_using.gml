// Feather disable all
/// @desc    Returns if the player is using the given source. If INPUT_GAMEPAD is used without
///          specifying a particular gamepad then this function will return <true> if any gamepad
///          is being used by the player
/// @param   source
/// @param   [playerIndex=0]

function input_source_using(_source, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    return _global.__players[_player_index].__source_contains(_source);
}
