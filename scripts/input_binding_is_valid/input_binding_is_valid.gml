/// @desc    Returns if the binding is valid for the player's currently assigned source(s)
///          For example, a gamepad binding would not be valid if a player is only using a keyboard
/// @param   binding
/// @param   [playerIndex=0]

function input_binding_is_valid(_binding, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if (_binding == undefined)
    {
        //Invalid if, for example, there is no binding set for the source specified when getting a binding
        return false;
    }
    else
    {
        if (!input_value_is_binding(_binding))
        {
            __input_error("Value provided is not a binding");
            return false;
        }
    }
    
    with(_global.__players[_player_index])
    {
        return __sources_validate_binding(_binding);
    }
}