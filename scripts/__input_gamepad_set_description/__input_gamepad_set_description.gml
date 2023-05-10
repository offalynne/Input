/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_description()
{
    if (xinput || __INPUT_ON_XBOX)
    {
        description = "XInput";
    }
    else if (__INPUT_ON_OPERAGX)
    {
        //FIXME - As of 2021-10-01 (runtime 2.3.5.458), Opera GX descriptions return useless information (usually "Standard Gamepad")
        //        It turns out that the GUID is actually a hex-encoded string of the first few characters of the device's name
        //        This... feels like a bug, but we can at least use that to recover a *little* information about the device
        
        description = "";
        
        var _work_string = guid;
        var _i = 1;
        repeat(string_length(_work_string) div 2)
        {
            var _ord_msf = string_byte_at(_work_string, _i  );
            var _ord_lsf = string_byte_at(_work_string, _i+1);
            
            var _value = (((_ord_msf >= 97)? (_ord_msf - 87) : (_ord_msf - 48)) << 4)
                        | ((_ord_lsf >= 97)? (_ord_lsf - 87) : (_ord_lsf - 48));
            
            description += chr(_value);
            
            _i += 2;
        }
    }
    else if (!__INPUT_SDL2_SUPPORT)
    {
        if (!__INPUT_SILENT) __input_trace("SDL2 remapping unsupported for this platform");
        description = gamepad_get_description(index);
    }
    else if (!INPUT_SDL2_REMAPPING)
    {
        if (!__INPUT_SILENT) __input_trace("Skipping SDL2 remapping");
        description = gamepad_get_description(index);
    }
    else
    {
        //We'll try to set our description based on the SDL2 database (Desktop, Android) or type (Steamworks)
    }
}
