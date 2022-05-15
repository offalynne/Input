/// @param [playerIndex=0]

function input_cursor_elastic_get(_x, _y, _strength, _player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        return {
            x:        __elastic_x,
            y:        __elastic_y,
            strength: __elastic_strength,
        }
    }
}