/// @param [playerIndex=0]

function input_vibrate_get_strength(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    return global.__input_players[_player_index].__vibration_strength;
}