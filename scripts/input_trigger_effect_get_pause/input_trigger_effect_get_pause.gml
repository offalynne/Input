/// @desc    Gets pause state for gamepad trigger effects for a player
/// @param   [playerIndex=0]

function input_trigger_effect_get_pause(_player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX    
    
    return global.__input_players[_player_index].__trigger_effect_paused;
}