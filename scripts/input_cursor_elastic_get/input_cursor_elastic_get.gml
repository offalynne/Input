/// @desc    Returns the elastic properties for the player's cursor as a struct
///          If no elastic state has been set, this function returns <undefined>
/// @param   [playerIndex=0]

function input_cursor_elastic_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index].__cursor)
    {
        return {
            x:        __elastic_x,
            y:        __elastic_y,
            strength: __elastic_strength,
        }
    }
}