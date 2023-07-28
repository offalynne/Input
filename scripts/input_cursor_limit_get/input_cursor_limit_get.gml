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
            left:   __limit_l,
            top:    __limit_t,
            right:  __limit_r,
            bottom: __limit_b,
            
            circle_x:      __limit_x,
            circle_y:      __limit_y,
            circle_radius: __limit_radius,
            
            boundary_margin: __limit_boundary_margin,
        }
    }
}
