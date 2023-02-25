/// @desc    Removes an elastic force that has been added to the given player’s cursor
/// @param   [playerIndex=0]

function input_cursor_elastic_remove(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index].__cursor)
    {
        __elastic_x        = undefined;
        __elastic_y        = undefined;
        __elastic_strength = 0;
    }
}