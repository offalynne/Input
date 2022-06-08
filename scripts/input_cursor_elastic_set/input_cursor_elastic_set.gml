/// @desc    Sets up a springy force that pulls the cursor towards the given point
///          This is useful for building aiming systems for shooters and works especially well
///          with input_cursor_limit_circle()
/// @param   x
/// @param   y
/// @param   strength
/// @param   [playerIndex=0]

function input_cursor_elastic_set(_x, _y, _strength, _player_index = 0)
{
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            input_cursor_elastic_set(_x, _y, _strength, _p);
            ++_p;
        }
        
        return;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    with(global.__input_players[_player_index].__cursor)
    {
        //If we already had a rubber band set up and we move it then it's highly likely we need to move the cursor position as well
        //This is the use case for point-of-aim implementations in situations where the character is moving around a room
        if (__elastic_strength > 0)
        {
            input_cursor_set(_x - __elastic_x, _y - __elastic_y, _player_index, true);
        }
        
        __elastic_x        = _x;
        __elastic_y        = _y;
        __elastic_strength = _strength;
    }
}