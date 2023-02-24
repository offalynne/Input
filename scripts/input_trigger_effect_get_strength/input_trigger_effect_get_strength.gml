/// @desc    Returns the strength of trigger effects for the player
/// @param   [playerIndex=0]

function input_trigger_effect_get_strength(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__trigger_effect_strength;
}