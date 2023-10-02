// Feather disable all
/// @desc    Returns whether the game is focused

function input_game_has_focus()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    return (_global.__game_focus && !os_is_paused());
}
