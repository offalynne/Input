/// @desc    Resets the player device color
/// @param   [playerIndex=0]

function input_color_reset(_player_index = 0)
{
    static _global = __input_state();
    __INPUT_VERIFY_PLAYER_INDEX
    
    global.__input_players[_player_index].__color_set(undefined);
}
