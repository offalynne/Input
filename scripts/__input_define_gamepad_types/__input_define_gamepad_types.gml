function __input_define_gamepad_types()
{
    __input_global().__simple_type_lookup = {};
    with (__input_global().__simple_type_lookup)
    {
        //Xbox
        #macro INPUT_GAMEPAD_TYPE_XBOX_ONE "xbox one"
        XBoxOneController   = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        CommunityXBoxOne    = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        CommunityDeck       = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        CommunityLuna       = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        CommunityStadia     = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        AppleController     = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        
        #macro INPUT_GAMEPAD_TYPE_XBOX_360 "xbox 360"
        XBox360Controller   = INPUT_GAMEPAD_TYPE_XBOX_360;
        CommunityXBox360    = INPUT_GAMEPAD_TYPE_XBOX_360;
        CommunityDreamcast  = INPUT_GAMEPAD_TYPE_XBOX_360;
        SteamController     = INPUT_GAMEPAD_TYPE_XBOX_360;
        MobileTouch         = INPUT_GAMEPAD_TYPE_XBOX_360;
        
        //Default for XInput and Xbox-like gamepads
        CommunityLikeXBox   = INPUT_GAMEPAD_TYPE_XBOX_ONE;
        
        //PlayStation
        #macro INPUT_GAMEPAD_TYPE_PS5 "ps5"
        PS5Controller       = INPUT_GAMEPAD_TYPE_PS5;    
        
        #macro INPUT_GAMEPAD_TYPE_PS4 "ps4"
        PS4Controller       = INPUT_GAMEPAD_TYPE_PS4;
        XInputPS4Controller = INPUT_GAMEPAD_TYPE_PS4;
        CommunityPS4        = INPUT_GAMEPAD_TYPE_PS4;    
        
        #macro INPUT_GAMEPAD_TYPE_PSX "psx"
        PS3Controller       = INPUT_GAMEPAD_TYPE_PSX;
        CommunityPSX        = INPUT_GAMEPAD_TYPE_PSX;
        
        //Switch
        #macro INPUT_GAMEPAD_TYPE_SWITCH "switch"
        SwitchHandheld            = INPUT_GAMEPAD_TYPE_SWITCH;
        SwitchJoyConPair          = INPUT_GAMEPAD_TYPE_SWITCH;
        SwitchProController       = INPUT_GAMEPAD_TYPE_SWITCH;
        XInputSwitchController    = INPUT_GAMEPAD_TYPE_SWITCH;
        SwitchInputOnlyController = INPUT_GAMEPAD_TYPE_SWITCH;
        CommunityLikeSwitch       = INPUT_GAMEPAD_TYPE_SWITCH;
        Community8BitDo           = INPUT_GAMEPAD_TYPE_SWITCH;
        HIDWiiClassic             = INPUT_GAMEPAD_TYPE_SWITCH;
        CommunitySNES             = INPUT_GAMEPAD_TYPE_SWITCH;
        CommunitySuperFamicom     = INPUT_GAMEPAD_TYPE_SWITCH;
        
        #macro INPUT_GAMEPAD_TYPE_JOYCON_LEFT "switch joycon left"
        SwitchJoyConLeft    = INPUT_GAMEPAD_TYPE_JOYCON_LEFT;
        SwitchJoyConSingle  = INPUT_GAMEPAD_TYPE_JOYCON_LEFT;
        HIDJoyConLeft       = INPUT_GAMEPAD_TYPE_JOYCON_LEFT;    
        
        #macro INPUT_GAMEPAD_TYPE_JOYCON_RIGHT "switch joycon right"
        SwitchJoyConRight = INPUT_GAMEPAD_TYPE_JOYCON_RIGHT;
        HIDJoyConRight    = INPUT_GAMEPAD_TYPE_JOYCON_RIGHT;
        
        //GameCube
        #macro INPUT_GAMEPAD_TYPE_GAMECUBE "gamecube"
        CommunityGameCube = INPUT_GAMEPAD_TYPE_GAMECUBE;
        
        //Unknown
        #macro INPUT_GAMEPAD_TYPE_UNKNOWN "unknown"
        Unknown                   = INPUT_GAMEPAD_TYPE_UNKNOWN;
        unknown                   = INPUT_GAMEPAD_TYPE_UNKNOWN;
        SteamControllerV2         = INPUT_GAMEPAD_TYPE_UNKNOWN;
        UnknownNonSteamController = INPUT_GAMEPAD_TYPE_UNKNOWN;
        CommunityUnknown          = INPUT_GAMEPAD_TYPE_UNKNOWN;
        CommunitySteam            = INPUT_GAMEPAD_TYPE_UNKNOWN;
        
        #region Optional gamepad types (default off)
        
        //#macro INPUT_GAMEPAD_TYPE_STEAM_DECK "steam deck"
        //CommunityDeck = INPUT_GAMEPAD_TYPE_STEAM_DECK;
        
        //#macro INPUT_GAMEPAD_TYPE_STEAM_CONTROLLER "steam controller"
        //SteamController = INPUT_GAMEPAD_TYPE_STEAM_CONTROLLER;
        
        //#macro INPUT_GAMEPAD_TYPE_8BITDO "8bitdo"
        //Community8BitDo = INPUT_GAMEPAD_TYPE_8BITDO;
        
        //#macro INPUT_GAMEPAD_TYPE_MFI "mfi"
        //AppleController = INPUT_GAMEPAD_TYPE_MFI;
        
        //#macro INPUT_GAMEPAD_TYPE_LUNA "luna"
        //CommunityLuna = INPUT_GAMEPAD_TYPE_LUNA;
        
        //#macro INPUT_GAMEPAD_TYPE_STADIA "stadia"
        //CommunityStadia = INPUT_GAMEPAD_TYPE_STADIA;
        
        //#macro INPUT_GAMEPAD_TYPE_VCS_CLASSIC "vcs classic"
        //CommunityVCSClassic = INPUT_GAMEPAD_TYPE_VCS_CLASSIC;
        //HIDAtariVCSClassic  = INPUT_GAMEPAD_TYPE_VCS_CLASSIC;
        
        //#macro INPUT_GAMEPAD_TYPE_VCS_MODERN "vcs modern"
        //CommunityVCSModern = INPUT_GAMEPAD_TYPE_VCS_MODERN;
        
        //#macro INPUT_GAMEPAD_TYPE_OUYA "ouya"
        //CommunityOuya = INPUT_GAMEPAD_TYPE_OUYA;
        
        //#macro INPUT_GAMEPAD_TYPE_DREAMCAST "dreamcast"
        //CommunityDreamcast = INPUT_GAMEPAD_TYPE_DREAMCAST;
        
        //#macro INPUT_GAMEPAD_TYPE_N64 "n64"
        //CommunityN64 = INPUT_GAMEPAD_TYPE_N64;
        
        //#macro INPUT_GAMEPAD_TYPE_SATURN "saturn"
        //CommunitySaturn = INPUT_GAMEPAD_TYPE_SATURN;
        
        //#macro INPUT_GAMEPAD_TYPE_SNES "snes"
        //CommunitySNES = INPUT_GAMEPAD_TYPE_SNES;
        
        //#macro INPUT_GAMEPAD_TYPE_SUPER_FAMICOM "super famicom"
        //CommunitySuperFamicom = INPUT_GAMEPAD_TYPE_SUPER_FAMICOM;
        
        #endregion
    }
}