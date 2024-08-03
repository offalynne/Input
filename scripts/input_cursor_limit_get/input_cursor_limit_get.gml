// Feather disable all
/// @desc    Returns the cursor limit state as a struct
///          If no limit has been set, this function returns <undefined>
/// @param   [playerIndex=0]

function input_cursor_limit_get(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index].__cursor)
    {
        return {
            __left:   __limit_l,
            __top:    __limit_t,
            __right:  __limit_r,
            __bottom: __limit_b,
            
            __circle_x:      __limit_x,
            __circle_y:      __limit_y,
            __circle_radius: __limit_radius,
            
            __boundary_margin: __limit_boundary_margin,
        }
    }
}
