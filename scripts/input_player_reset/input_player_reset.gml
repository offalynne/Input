/// @desc    Clears all player data and resets to the defaults set up in __input_config_verbs()
/// @param   [playerIndex=0]

function input_player_reset(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    _global.__players[_player_index].__reset();
}