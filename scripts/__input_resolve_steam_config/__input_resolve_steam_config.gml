function __input_resolve_steam_config()
{
    //Native Linux or MacOS
    if (!((os_type == os_linux) || (os_type == os_macosx)) || __INPUT_ON_WEB) exit;

    //Define the virtual controller's identity
    var _os = ((os_type == os_macosx)? "macos"    : "linux");
    var _id = ((os_type == os_macosx)? "5e048e02" : "de28ff11");
    
    //Access the blacklist
    var _blacklist_os = (is_struct(global.__input_blacklist_dictionary)? global.__input_blacklist_dictionary[$ _os] : undefined);
    var _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "vid+pid"] : undefined);
    
    if (is_struct(_blacklist_os) && (_blacklist_id == undefined))
    {
        //Add 'Vendor ID + Product ID' category
        _blacklist_os[$ "vid+pid"] = {};
        _blacklist_id = (is_struct(_blacklist_os)? _blacklist_os[$ "vid+pid"] : undefined);
    }
    
    if (!is_struct(_blacklist_id))
    {
        //Unable to access blacklist
        exit;
    }
    else
    {
        //Blacklist the Steam virtual controller
        _blacklist_id[$ _id] = true;
    }
    
    //Virtual controllers are nonfunctional on Mac
    if (os_type == os_macosx) exit;

    var _steam_environ = environment_get_variable("SteamEnv");
    var _steam_configs = environment_get_variable("EnableConfiguratorSupport");

    if ((_steam_environ != "") && is_string(_steam_environ) && (_steam_environ == "1")
    &&  (_steam_configs != "") && is_string(_steam_configs) && (_steam_configs == string_digits(_steam_configs)))
    {
        //If run through Steam, remove Steam virtual controller from blocklist
        variable_struct_remove(_blacklist_id, _id);
        
        //Resolve Steam Input configuration
        var _bitmask = real(_steam_configs);
        
        var _steam_ps      = (_bitmask & 1);
        var _steam_xbox    = (_bitmask & 2);
        var _steam_generic = (_bitmask & 4);
        var _steam_switch  = (_bitmask & 8);
        
        if (environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == "")
        {
            //If overlay is not loaded, GM accesses controllers meant to be blocked
            //We address this by adding the Steam config types to our own blocklist
            if (_steam_ps)
            {
                global.__input_ignore_gamepad_types[$ "psx"] = true;
                global.__input_ignore_gamepad_types[$ "ps4"] = true;
                global.__input_ignore_gamepad_types[$ "ps5"] = true;
            }
            
            if (_steam_xbox)
            {
                global.__input_ignore_gamepad_types[$ "xbox"    ] = true;
                global.__input_ignore_gamepad_types[$ "xbox 360"] = true;
                global.__input_ignore_gamepad_types[$ "xbox one"] = true;
            }
        
            if (_steam_switch)
            {
                global.__input_ignore_gamepad_types[$ "switch"] = true;
            }
            
            if (_steam_generic)
            {
                global.__input_ignore_gamepad_types[$ "switch joycon left" ] = true;
                global.__input_ignore_gamepad_types[$ "switch joycon right"] = true;
            
                global.__input_ignore_gamepad_types[$ "snes"    ] = true;
                global.__input_ignore_gamepad_types[$ "saturn"  ] = true;
                global.__input_ignore_gamepad_types[$ "n64"     ] = true;
                global.__input_ignore_gamepad_types[$ "gamecube"] = true;
                global.__input_ignore_gamepad_types[$ "unknown" ] = true;
            }
        }
    
        //Check for a reducible type configuration
        var _steam_switch_labels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
        if ((!_steam_switch || ((_steam_switch_labels != "") && is_string(_steam_switch_labels) && (_steam_switch_labels == "1")))
        &&  !_steam_generic && !_steam_ps)
        {
            //The remaining configurations are in the Xbox Controller style including:
            //Steam Controller, Steam Link, Steam Deck, Xbox or Switch with AB/XY swap
            global.__input_simple_type_lookup[$ "CommunitySteam"] = "xbox one";
        }
    }
}
