// Feather disable all
/// @desc    Sets whether the player is active or not
/// 
/// An inactive player will have all their verbs "consumed" until the player is reactivated
/// 
/// @param   state
/// @param   [playerIndex=0]

function input_player_active_set(_state, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__active = _state;
}
