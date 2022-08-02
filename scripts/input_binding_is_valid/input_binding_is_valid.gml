/// @desc    Returns if the binding is valid for the player's currently assigned source(s)
///          For example, a gamepad binding would not be valid if a player is only using a keyboard
/// @param   {Struct.__input_class_binding} _binding
/// @param   {Real} _player_index
/// @returns {Bool}

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