/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_description()
{
    if (!__INPUT_SDL2_SUPPORT)
    {
        __input_trace("SDL2 remapping unsupported for this platform");
        description = gamepad_get_description(index);
    }
    else if (!INPUT_SDL2_REMAPPING)
    {
        __input_trace("Skipping SDL2 remapping");
        description = gamepad_get_description(index);
    }
    else if (blacklisted)
    {
        description = gamepad_get_description(index);
    }
    else if (xinput)
    {
        description = "XInput";
    }
    else
    {
        //We'll try to set our description based on the SDL2 database
    }
}