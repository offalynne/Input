// Feather disable all

/// @param description

function __InputGamepadIdentifyDescriptionType(_description)
{
    _description = string_lower(_description);

    if (__InputStringContains(_description, "joy-con (l)", "left joy-con"))
    {
        return INPUT_GAMEPAD_TYPE_JOYCON_LEFT;
    }
    else if (__InputStringContains(_description, "joy-con (r)", "right joy-con"))
    {
        return INPUT_GAMEPAD_TYPE_JOYCON_RIGHT;
    }
    else if (__InputStringContains(_description, "ps5", "dualsense", "backbone one playstation"))
    {
        return INPUT_GAMEPAD_TYPE_PS5;
    }
    else if (__InputStringContains(_description, "ps4", "ps3", "ps2", "ps1", "psx", "playstation", "dualshock", "sony", "8bitdo p30"))
    {
        return INPUT_GAMEPAD_TYPE_PS4;
    }
    else if (__InputStringContains(_description, "xinput", "xbox", "stadia", "luna", "amazon game", "steam", "nimbus", "horipad ultimate", "mfi"))
    {
        return INPUT_GAMEPAD_TYPE_XBOX;
    }
    else if (__InputStringContains(_description, "joy-con (l/r)", "for switch", "for nintendo switch", "switch controller", "switch pro", "lic pro", "mobapad", "8bitdo", "retroid", "odin", "wii", "snes", "sfc"))
    {
        return INPUT_GAMEPAD_TYPE_SWITCH;
    }
    
    return undefined;
}