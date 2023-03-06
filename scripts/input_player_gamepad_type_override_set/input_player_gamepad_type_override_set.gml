/// @desc    Sets the a gamepad type for the player for icon display
///          Set the gamepadType to <undefined> to not set an override
/// @param   gamepadType
/// @param   [playerIndex=0]

function input_player_gamepad_type_override_set(_type, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    if ((_type != undefined)
    &&  (_type != "switch")
    &&  (_type != "switch joycon left")
    &&  (_type != "switch joycon right")
    &&  (_type != "psx")
    &&  (_type != "ps4")
    &&  (_type != "ps5")
    &&  (_type != "xbox 360")
    &&  (_type != "xbox one")
    &&  (_type != "saturn")
    &&  (_type != "snes")
    &&  (_type != "n64")
    &&  (_type != "gamecube"))
    {
        __input_error("Gamepad type \"", _type, "\" not supported");
    }
    
    _global.__players[_player_index].__gamepad_type_override = _type;
}
