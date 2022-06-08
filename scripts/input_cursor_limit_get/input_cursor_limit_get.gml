/// @desc    Returns the cursor limit state as a struct
///          If no limit has been set, this function returns <undefined>
/// @param   [playerIndex=0]

function input_cursor_limit_get(_player_index = 0)
{
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        return {
            left:   __limit_l,
            top:    __limit_t,
            right:  __limit_r,
            bottom: __limit_b,
            
            circle_x:      __limit_x,
            circle_y:      __limit_y,
            circle_radius: __limit_radius,
        }
    }
}