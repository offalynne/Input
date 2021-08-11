/// This function should be called in the scope of a gamepad class

function __input_gamepad_set_description(){

   if (!__INPUT_SDL2_SUPPORT)
   {
      __input_trace("SDL2 remapping unsupported for this platform");
      description = gamepad_get_description(index);
      exit;
   }
   
    if (!INPUT_SDL2_REMAPPING)
    {
        __input_trace("Skipping SDL2 remapping");
        description = gamepad_get_description(index);
        exit;
    }
    
   if (blacklisted)
   {
      description = gamepad_get_description(index);
      exit;
   }
    
    if (xinput)
    {
        description = "XInput";
        exit;
    }

}