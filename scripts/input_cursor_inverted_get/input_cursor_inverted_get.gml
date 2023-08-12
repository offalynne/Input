// Feather disable all
/// @desc    Returns whether the vertical axis is inverted for the cursor
/// @param   [playerIndex=0]

function input_cursor_inverted_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX

    return _global.__players[_player_index].__cursor_inverted;
}
