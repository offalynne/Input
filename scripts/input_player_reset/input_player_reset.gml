/// @desc    Clears all player data and resets to the defaults set up in INPUT_DEFAULT_PROFILES
/// @param   [playerIndex=0]

function input_player_reset(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__reset();
}