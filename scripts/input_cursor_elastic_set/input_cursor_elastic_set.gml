// Feather disable all
/// @desc    Sets up a springy force that pulls the cursor towards the given point
///          This is useful for building aiming systems for shooters and works especially well
///          with input_cursor_limit_circle()
/// @param   x
/// @param   y
/// @param   strength
/// @param   [playerIndex=0]
/// @param   [moveCursor=true]

function input_cursor_elastic_set(_x, _y, _strength, _player_index = 0, _move_cursor = true)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_elastic_set(_x, _y, _strength, _p, _move_cursor);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(_global.__players[_player_index].__cursor)
    {
        if (_move_cursor && (__elastic_x != undefined) && (__elastic_y != undefined))
        {
            __set(_x - __elastic_x, _y - __elastic_y, true);
        }
        
        __elastic_x        = _x;
        __elastic_y        = _y;
        __elastic_strength = _strength;
    }
}
