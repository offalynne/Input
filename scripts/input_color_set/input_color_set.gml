/// @desc    Sets the player device color
/// @param   color
/// @param   [playerIndex=0]

function input_color_set(_color, _player_index = 0)
{
    __input_initialize();
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (!is_numeric(_color) || (_color < c_black) || (_color > c_white))
    {
        __input_error("Invalid color value ", _color);
        return;
    }
    
    global.__input_players[_player_index].__color_set(_color);
}
