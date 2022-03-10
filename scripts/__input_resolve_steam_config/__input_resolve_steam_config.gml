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
        
        //Unset Steam Input virtual controller's gamepad type if it is unidentifiable        
        var _bitmask = real(_steam_configs);
        if (_bitmask & 1)
        {
            //Virtual controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or PlayStation
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
        else
        if ((_bitmask & 8) && (_steam_switch_ab != "") && is_string(_steam_switch_ab) && (_steam_switch_ab == "0"))
        {
            //XInput style label swap for Switch buttons (A/B, X/Y) is not enabled
            //Virtual controllers may be Steam Controller, Steam Link Touch Controls, Steam Deck or Switch
            global.__input_simple_type_lookup[$ "SteamController"] = "unknown";
        }
    }
}
