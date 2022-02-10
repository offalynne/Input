function __input_resolve_steam_config()
{
    //Skip platforms without Steam
    if (__INPUT_ON_WEB || !__INPUT_ON_DESKTOP) exit;
    
    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");

    //Test for Steam environment and valid Steam Input config
    //Check empty string first to prevent EnVar related crash
    if ((_steam_environ != ""  ) && (_steam_configs != ""   )
    && is_string(_steam_environ) && is_string(_steam_configs)
    && (_steam_environ == "1"  ) && (_steam_configs == string_digits(_steam_configs)))
    {
        //Evaluate Steam Input configuration
        var _bitmask = real(_steam_configs);
        if ((_bitmask & 1) != 0)
        {
            //Steam Input is configured to use controller type "PlayStation" (1)
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
        else if ((_bitmask & 8) != 0) 
        {
            //Steam Input is configured to use controller type "Switch" (8)
            var _switch_layout = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");                    
            if ((_switch_layout != "") && is_string(_switch_layout) && (_switch_layout == "0"))
            {
                //XInput format label swap for Switch buttons (A/B X/Y) is disabled
                global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
            }
        }
    }
}
