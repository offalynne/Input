// Feather disable all
/// @desc    Sets the a gamepad type for the player for icon display
///          Set the gamepadType to <undefined> to not set an override
/// @param   gamepadType
/// @param   [playerIndex=0]

function input_player_gamepad_type_override_set(_type, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if ((_type != undefined)
    &&  (_type != INPUT_GAMEPAD_TYPE_XBOX_ONE)
    &&  (_type != INPUT_GAMEPAD_TYPE_XBOX_360)
    &&  (_type != INPUT_GAMEPAD_TYPE_PS5)
    &&  (_type != INPUT_GAMEPAD_TYPE_PS4)
    &&  (_type != INPUT_GAMEPAD_TYPE_PSX)
    &&  (_type != INPUT_GAMEPAD_TYPE_SWITCH)
    &&  (_type != INPUT_GAMEPAD_TYPE_JOYCON_LEFT)
    &&  (_type != INPUT_GAMEPAD_TYPE_JOYCON_RIGHT)
    &&  (_type != INPUT_GAMEPAD_TYPE_GAMECUBE))
    {
        __input_error("Gamepad type \"", _type, "\" not supported");
    }
    
    _global.__players[_player_index].__gamepad_type_override = _type;
}
