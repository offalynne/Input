/// @param source
/// @param [gamepad]

function input_source_is_available(_source, _gamepad = undefined)
{
    __input_initialize();
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        if (global.__input_players[_p].__is_using_source(_source, _gamepad)) return false;
        ++_p;
    }
    
    return true;
}