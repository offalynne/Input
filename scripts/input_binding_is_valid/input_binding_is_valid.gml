/// @param binding
/// @param [playerIndex]

function input_binding_is_valid(_binding, _player_index = 0)
{
	__input_initialize();
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
    
    with(global.__input_players[_player_index])
    {
        return __sources_validate_binding(_binding);
    }
}