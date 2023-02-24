/// @desc    Returns the profiles that have been created for the player, including default profiles
/// @param   [playerIndex=0]

function input_profile_get_array(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__profile_get_array();
}