function __input_resolve_steam_config()
{
    if (((os_type != os_linux) || (os_type != os_macosx)) || __INPUT_ON_WEB) exit;

    var _os = ((os_type == os_macosx)? "mac" : "linux");
    var _id = ((os_type == os_macosx)? "5e048e02" : "de28ff11");
    
    var _blacklist_os = (is_struct(global.__input_blacklist_dictionary)? global.__input_blacklist_dictionary[$ _os] : undefined);
    var _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "vid+pid"] : undefined);
            
    if (is_struct(_blacklist_id))
    {
        //Block the Steam Virtual controller
        _blacklist_id[$ _id] = true;
    }
    
    if (os_type == os_macosx) exit;

    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_libpath = environment_get_variable("LD_LIBRARY_PATH");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
    var _steam_switchx = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");

    //Test for Steam environment and valid Steam Input config
    //Check empty string first to prevent EnVar related crash
    if ((_steam_environ != "") && is_string(_steam_environ) && (_steam_environ == "1"))
    {        
        if ((_steam_configs != "") && is_string(_steam_configs) && (_steam_configs == string_digits(_steam_configs)))
        {
            //Remove Steam Virtual controller block
            variable_struct_remove(_blacklist_id, _id);
            
            //Get Steam Input settings
            var _bitmask = real(_steam_configs);
                
            //If library path is unset, GM accesses controllers meant to be blocked
            //We can fix this by adding the Steam Config types to our own blocklist
            if (_steam_libpath == "")
            {
                if ((_bitmask & 1) != 0)
                {
                    //Steam Input type 'PlayStation'
                    global.__input_steam_blocklist[$ "psx"] = true;
                    global.__input_steam_blocklist[$ "ps4"] = true;
                    global.__input_steam_blocklist[$ "ps5"] = true;
                }
            
                if ((_bitmask & 2) != 0)
                {
                    //Steam Input type 'Xbox'
                    global.__input_steam_blocklist[$ "xbox"    ] = true;
                    global.__input_steam_blocklist[$ "xbox 360"] = true;
                    global.__input_steam_blocklist[$ "xbox one"] = true;
                }
            
                if ((_bitmask & 8) != 0)
                {
                    //Steam Input type 'Switch'
                    global.__input_steam_blocklist[$ "switch"] = true;
                }
            
                if ((_bitmask & 4) != 0)
                {
                    //Steam Input type 'DInput' (or, "everything else")
                    global.__input_steam_blocklist[$ "switch joycon left" ] = true;
                    global.__input_steam_blocklist[$ "switch joycon right"] = true;
                    global.__input_steam_blocklist[$ "snes"               ] = true;
                    global.__input_steam_blocklist[$ "saturn"             ] = true;
                    global.__input_steam_blocklist[$ "n64"                ] = true;
                    global.__input_steam_blocklist[$ "gamecube"           ] = true;
                    global.__input_steam_blocklist[$ "unknown"            ] = true;
                }
            }
        
            //Unset Steam Input Virtual Controller's gamepad type if it is unidentifiable        
            if ((_bitmask & 1) != 0)
            {
                //Steam Input is configured to use controller type "PlayStation" (1)
                //Virtual Controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or PlayStation
                global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
            }
            else
            if (((_bitmask & 8) != 0)    && (_steam_switchx != "") 
            && is_string(_steam_switchx) && (_steam_switchx == "0"))
            {
                //Steam Input is configured to use controller type "Switch" (8)
                //XInput style label swap for Switch buttons (A/B, X/Y) is disabled
                //Virtual Controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or Switch
                global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
           }
        }
    }
}
