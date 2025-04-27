// Feather disable all

function __InputInitializeSteam()
{
    with(__InputSystem())
    {
        __usingSteamworks = false;
        __onSteamDeck     = false;
        __onWINE          = false;
        
        __steamHandlesArray = [];
        
        __steamSwitchLabels          = false;
        __steamTypeToInputTypeMap = ds_map_create();
        __steamTypeToDescriptionMap  = ds_map_create();
        __steamInputTypeIgnoreMap = ds_map_create();
        
        try
        {
            //Using Steamworks extension
            __usingSteamworks = steam_input_init(true);
            __onSteamDeck     = steam_utils_is_steam_running_on_steam_deck();
        }
        catch(_error)
        {
            __InputTrace("Steamworks extension unavailable");
        }
        
        if (__usingSteamworks && (string(steam_get_app_id()) == "480"))
        {
            __InputError("Steam application ID 480 is not supported.\nPlease change to your game's actual Steam application ID.\n \nIf you need a testing ID you should:\n1. Use ID 378090\n2. Install the game itself (Rebel Wings) on Steam.");
        }
        
        //Identify Steam Deck in absence of Steamworks
        if (not __onSteamDeck)
        {
            var _deck_envar = environment_get_variable("SteamDeck");
            if (_deck_envar != "")
            {
                //Try Deck environment variable
                __onSteamDeck = (_deck_envar == "1");
            }
            else
            {
                //Try Deck hardware identity
                var _map = os_get_info();
                if (ds_exists(_map, ds_type_map))
                {
                    var _identifier = undefined;
                    if (INPUT_ON_LINUX  ) _identifier = _map[? "gl_renderer_string"];
                    if (INPUT_ON_WINDOWS) _identifier = _map[? "video_adapter_description"];
                    
                    //Steam Deck GPU identifier
                    if ((_identifier != undefined) && __InputStringContains(_identifier, "AMD Custom GPU 0"))
                    {
                        __onSteamDeck = true;
                    }
                    
                    ds_map_destroy(_map);
                }
            }
        }
        
        //Detect whether in-game labels should use Steam's gamepad types
        var _switchLabels = environment_get_variable("SDL_GAMECONTROLLER_USE_BUTTON_LABELS");
        if (_switchLabels != "")
        {
            //Use environment variable
            __steamSwitchLabels = (_switchLabels == "1");
        }
        else
        {
            //Default enabled on Deck and disabled on desktop
            __steamSwitchLabels = __onSteamDeck;
        }
        
        if (__usingSteamworks)
        {
            //Whether we're on WINE. This is useful for trigger effects but is otherwise unused by this library
            __onWINE = (environment_get_variable("WINEDLLPATH") != "");
            
            //Build look-up table to map Steam gamepad types to native gamepad types
            var _funcAddType = function(_steamType, _inputType, _description)
            {
                __steamTypeToInputTypeMap[? _steamType] = _inputType;
                __steamTypeToDescriptionMap[?  _steamType] = _description;
            }
            
            _funcAddType(steam_input_type_xbox_360_controller,   INPUT_GAMEPAD_TYPE_XBOX, "Xbox 360 Controller");
            _funcAddType(steam_input_type_xbox_one_controller,   INPUT_GAMEPAD_TYPE_XBOX, "Xbox One Controller");
            _funcAddType(steam_input_type_ps3_controller,        INPUT_GAMEPAD_TYPE_PS4,  "PS3 Controller");
            _funcAddType(steam_input_type_ps4_controller,        INPUT_GAMEPAD_TYPE_PS4,  "PS4 Controller");
            _funcAddType(steam_input_type_ps5_controller,        INPUT_GAMEPAD_TYPE_PS5,  "PS5 Controller");
            _funcAddType(steam_input_type_steam_controller,      INPUT_GAMEPAD_TYPE_XBOX, "Steam Controller");
            _funcAddType(steam_input_type_steam_deck_controller, INPUT_GAMEPAD_TYPE_XBOX, "Steam Deck Controller");
            _funcAddType(steam_input_type_mobile_touch,          INPUT_GAMEPAD_TYPE_XBOX, "Steam Link");
            
            if (__steamSwitchLabels)
            {
                //This is weird, but dictated by Steam Input
                _funcAddType(steam_input_type_switch_pro_controller, INPUT_GAMEPAD_TYPE_XBOX, "Switch Pro Controller");
                _funcAddType(steam_input_type_switch_joycon_single,  INPUT_GAMEPAD_TYPE_XBOX, "Joy-Con");
                _funcAddType(steam_input_type_switch_joycon_pair,    INPUT_GAMEPAD_TYPE_XBOX, "Joy-Con Pair");
            }
            else
            {   
                _funcAddType(steam_input_type_switch_pro_controller, INPUT_GAMEPAD_TYPE_SWITCH,       "Switch Pro Controller");
                _funcAddType(steam_input_type_switch_joycon_single,  INPUT_GAMEPAD_TYPE_JOYCON_RIGHT, "Joy-Con");
                _funcAddType(steam_input_type_switch_joycon_pair,    INPUT_GAMEPAD_TYPE_SWITCH,       "Joy-Con Pair");
            }
            
            _funcAddType("unknown", INPUT_GAMEPAD_TYPE_UNKNOWN, "Controller");
        }
        
        //Build a Linux-only gamepad ignore map
        if (INPUT_ON_LINUX)
        {
            var _steamEnviron = environment_get_variable("SteamEnv");
            var _steamConfigs = environment_get_variable("EnableConfiguratorSupport");
        
            if (((_steamEnviron != "") && (_steamEnviron == "1") || __usingSteamworks)
            &&   (_steamConfigs != "") && (_steamConfigs == string_digits(_steamConfigs)))
            {
                var _bitmask = real(_steamConfigs);
                
                //Resolve Steam Input configuration
                var _steamPS      = (_bitmask & 1);
                var _steamXbox    = (_bitmask & 2);
                var _steamGeneric = (_bitmask & 4);
                var _steamSwitch  = (_bitmask & 8);
                
                if (__usingSteamworks || (environment_get_variable("SDL_GAMECONTROLLER_IGNORE_DEVICES") == ""))
                {
                    //If ignore hint isn't set, GM accesses controllers meant to be blocked
                    //We address this by adding the Steam config types to our own blocklist
                    if (_steamPS)
                    {
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_PS4] = true;
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_PS5] = true;
                    }
                    
                    if (_steamXbox)
                    {
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_XBOX] = true;
                    }
                    
                    if (_steamGeneric)
                    {
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_UNKNOWN] = true;
                    }
                    
                    if (_steamSwitch)
                    {
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_SWITCH      ] = true;
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_JOYCON_LEFT ] = true;
                        __steamInputTypeIgnoreMap[? INPUT_GAMEPAD_TYPE_JOYCON_RIGHT] = true;
                    }
                }
                
                //Check for a reducible type configuration
                if (!_steamGeneric && !_steamPS && (!_steamSwitch || __steamSwitchLabels))
                {
                    //The remaining configurations are in the Xbox Controller style including:
                    //Steam Controller, Steam Link, Steam Deck, Xbox or Switch with AB/XY swap
                    
                    _funcAddType("unknown", INPUT_GAMEPAD_TYPE_XBOX, "Controller");
                    __InputTrace("Steam Input configuration indicates Xbox-like identity for virtual controllers");
                }
            }
        }
    }
}