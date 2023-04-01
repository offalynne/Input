/// @desc    Returns the player device color
/// @param   [playerIndex=0]
/// @param   [binding=undefined]

function input_led_pattern_get(_player_index = 0, _binding = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    var _gamepad = input_player_get_gamepad(_player_index, _binding);
    if (_gamepad >= 0)
    {
        with _global.__gamepads[@ _gamepad]
        {
            return __led_pattern;
        }
    }
    
    return undefined;
}