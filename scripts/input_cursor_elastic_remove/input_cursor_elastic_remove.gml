/// @param [playerIndex=0]

function input_cursor_elastic_remove(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        __elastic_x        = undefined;
        __elastic_y        = undefined;
        __elastic_strength = 0;
    }
}