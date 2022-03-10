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

    var _steam_environ   = environment_get_variable("SteamEnv");
    var _steam_configs   = environment_get_variable("EnableConfiguratorSupport");
    var _steam_switch_ab = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");

    //Test for Steam environment and valid Steam Input config
    if ((_steam_environ != "") && is_string(_steam_environ) && (_steam_environ == "1")
    &&  (_steam_configs != "") && is_string(_steam_configs) && (_steam_configs == string_digits(_steam_configs)))
    {
        //Remove Steam virtual controller from blocklist
        variable_struct_remove(_blacklist_id, _id);
        
        //Get Steam Input configuration
        var _bitmask = real(_steam_configs);
        
        var _steam_ps      = (_bitmask & 1);
        var _steam_xbox    = (_bitmask & 2);
        var _steam_generic = (_bitmask & 4);
        var _steam_switch  = (_bitmask & 8);
                
        //If overlay is not loaded, GM accesses controllers meant to be blocked
        //We can fix this by adding the Steam Config types to our own blocklist
        if (_steam_ps)
        {
            global.__input_steam_blocklist[$ "psx"] = true;
            global.__input_steam_blocklist[$ "ps4"] = true;
            global.__input_steam_blocklist[$ "ps5"] = true;
        }
            
        if (_steam_xbox)
        {
            global.__input_steam_blocklist[$ "xbox"    ] = true;
            global.__input_steam_blocklist[$ "xbox 360"] = true;
            global.__input_steam_blocklist[$ "xbox one"] = true;
        }
                    
        if (_steam_generic)
        {
            global.__input_steam_blocklist[$ "switch joycon left" ] = true;
            global.__input_steam_blocklist[$ "switch joycon right"] = true;
            
            global.__input_steam_blocklist[$ "snes"    ] = true;
            global.__input_steam_blocklist[$ "saturn"  ] = true;
            global.__input_steam_blocklist[$ "n64"     ] = true;
            global.__input_steam_blocklist[$ "gamecube"] = true;
            global.__input_steam_blocklist[$ "unknown" ] = true;
        }
        
        if (_steam_switch)
        {
            global.__input_steam_blocklist[$ "switch"] = true;
        }
    
        if (!_steam_ps && !_steam_generic 
        && (!_steam_switch || ((_steam_switch_ab != "") && is_string(_steam_switch_ab) && (_steam_switch_ab == "1"))))
        {
            //Remaining configurations are in the sytle of XInput
            //Steam Controller, Link Touch Control, Deck and Xbox
            global.__input_simple_type_lookup[$ "CommunitySteam"] = "xbox one";
        }
    }
}