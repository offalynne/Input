// Feather disable all
/// @desc    Returns the gamepad index for the first gamepad assigned to the player. If the player
///          has no assigned gamepad, this function returns <undefined>
/// @param   [playerIndex=0]
/// @param   [binding]

function input_player_get_gamepad(_player_index = 0, _binding = undefined)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    //If we're not in multidevice mode then ignore the binding argument
    if (_global.__source_mode == INPUT_SOURCE_MODE.MULTIDEVICE)
    {
        _binding = undefined;
    }
    
    if (_binding != undefined)
    {
        if (!input_value_is_binding(_binding))
        {
            __input_error("Parameter is not a binding (typeof=", typeof(_binding), ")");
            return;
        }
        
        var _gamepad_index = _binding.__gamepad_get();
        if (_gamepad_index == undefined)
        {
            //Generic binding, return the player's gamepad
            _binding = undefined;
        }
        else
        {
            return _gamepad_index;
        }
    }
    
    return _global.__players[_player_index].__source_get_gamepad();
}
