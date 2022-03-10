function __input_resolve_steam_config()
{
    if ((os_type != os_linux) || __INPUT_ON_WEB) exit;

    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_libpath = environment_get_variable("LD_LIBRARY_PATH");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
    
    var _steam_blocklist = environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES");
    var _steam_switch_ab = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");

    //Test for Steam environment and valid Steam Input config
    //Check empty string first to prevent EnVar related crash
    if ((_steam_environ != ""  ) && (_steam_configs != ""   )
    && is_string(_steam_environ) && is_string(_steam_configs)
    && (_steam_environ == "1"  ) && (_steam_configs == string_digits(_steam_configs)))
    {
        //If library path is unset, GM accesses controllers meant to be blocked
        //We can fix this by adding the device ignore list to our own blocklist
        if ((_steam_libpath == "") && (_steam_blocklist != "") && is_string(_steam_blocklist))
        {
            var _block_array = __input_csv_to_array(_steam_blocklist, ",", "");                    
            var _blocklist_os = global.__input_blacklist_dictionary[$ "linux"];
            var _blocklist_category = (is_struct(_blocklist_os) ? _blocklist_os[$ "vid+pid"] : undefined);
                
            if (is_struct(_blocklist_category) && (array_length(_block_array) > 0))
            {
                var _value = "";
                var _vid = "";
                var _pid = "";

                var _count = 0;
                repeat(array_length(_block_array[0]))
                {
                    _value = _block_array[0][_count];
    
                    if (string_length(_value) == 13)
                    {
                        //Build ID reversing endianness
                        _vid = string_copy(_value,  5, 2) + string_copy(_value,  3, 2);
                        _pid = string_copy(_value, 12, 2) + string_copy(_value, 10, 2);
                        
                        //Add to internal dictionary
                        _blocklist_category[$ _vid + _pid] = true;        
                    }
    
                    ++_count;
                }

                show_message_async(_blocklist_category); //TODO confirm and remove
            }
        }
        
        //Unset Steam Input Virtual Controller's gamepad type if it is unidentifiable
        var _bitmask = real(_steam_configs);                
        if ((_bitmask & 1) != 0)
        {
            //Steam Input is configured to use controller type "PlayStation" (1)
            //Virtual Controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or PlayStation
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
        else
        if (((_bitmask & 8) != 0)      && (_steam_switch_ab != "") 
        && is_string(_steam_switch_ab) && (_steam_switch_ab == "0"))
        {
            //Steam Input is configured to use controller type "Switch" (8)
            //XInput format label swap for Switch buttons (A/B, X/Y) is disabled
            //Virtual Controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or Switch
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
       }
    }
}
