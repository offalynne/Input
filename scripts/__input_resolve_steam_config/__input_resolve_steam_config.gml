function __input_resolve_steam_config()
{
    if ((os_type != os_linux) || __INPUT_ON_WEB) exit;

    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_no_path = environment_get_variable("LD_LIBRARY_PATH");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");
    
    var _steam_blocklist = environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES");
    var _steam_switch_ab = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");

    //Test for Steam environment and valid Steam Input config
    //Check empty string first to prevent EnVar related crash
    if ((_steam_environ != ""  ) && (_steam_configs != ""   )
    && is_string(_steam_environ) && is_string(_steam_configs)
    && (_steam_environ == "1"  ) && (_steam_configs == string_digits(_steam_configs)))
    {
        //If unset (as by default), GM accesses controllers meant to be blocked
        //We can fix this by adding the device ignore list to our own blocklist
        if ((_steam_no_path == "") && (_steam_blocklist != "") && is_string(_steam_blocklist))
        {
            var _block_array = __input_csv_to_array(_steam_blocklist, ",", "");                    
            var _blocklist_os = global.__input_blacklist_dictionary[$ "linux"];
            var _blocklist_category = _blocklist_os[$ "vid+pid"];
                
            if ((is_struct(_blocklist_os)) && (is_struct(_blocklist_category)) && (array_length(_block_array) == 1))
            {
                var _category_struct = _blocklist_category;
                var _value = "";
                var _vid = "";
                var _pid = "";

                var _count = 0;
                repeat(array_length(_block_array[0]))
                {
                    _value = _block_array[0][_count];
    
                    if (string_length(_value) == 13)
                    {
                        _vid = string_copy(_value,  5, 2) + string_copy(_value,  3, 2);
                        _pid = string_copy(_value, 12, 2) + string_copy(_value, 10, 2);
                        _category_struct[$ _vid + _pid] = true;        
                    }
    
                    ++_count;
                }

                show_message_async(_blocklist_category);
            }
        }
        
        //Set the Steam Input Virtual Controller's underlying gamepad type if identifiable
        var _bitmask = real(_steam_configs);                
        if ((_bitmask & 1) != 0)
        {
            //Steam Input is configured to use controller type "PlayStation" (1)
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
        else if (((_bitmask & 8) != 0) && (_steam_switch_ab != "") 
             && is_string(_steam_switch_ab) && (_steam_switch_ab == "0"))
             {
                //Steam Input is configured to use controller type "Switch" (8)
                //XInput format label swap for Switch buttons (A/B, X/Y) is disabled
                global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
            }
    }
}
