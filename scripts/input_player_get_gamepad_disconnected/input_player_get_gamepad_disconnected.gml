// Feather disable all
/// @desc    Returns whether a gamepad assigned to the player has disconnected this frame
/// @param   [playerIndex=0]
function input_player_get_gamepad_disconnected(_player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__cleared) return false;
    
    if (_player_index == all)
    {
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            if (input_player_get_gamepad_disconnected(_p))
            {
                return true;
            }
            
            ++_p;
        }
        
        return false;
    }
    
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _i = 0;
    repeat(array_length(_global.__player_gamepad_disconnections))
    {
        if (_global.__player_gamepad_disconnections[_i] == _player_index)
        {
            return true;
        }
        
        ++_i;
    }
    
    return false;
}