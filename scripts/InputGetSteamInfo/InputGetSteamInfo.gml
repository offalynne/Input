// Feather disable all

/// Returns information about the Steam integration in the library. `infoField` should be a
/// member of the `INPUT_STEAM_INFO` enum:
/// 
/// - `INPUT_STEAM_INFO.STEAMWORKS`  Whether Steamworks has initialized successfully
/// - `INPUT_STEAM_INFO.STEAM_DECK`  Whether we're running on Steam Deck hardware
/// - `INPUT_STEAM_INFO.ON_WINE`     Whether we're running in the WINE emulator
/// 
/// @param {Enum.INPUT_STEAM_INFO,Real} infoField

function InputGetSteamInfo(_infoField)
{
    static _system = __InputSystem();
    
    if (_infoField == INPUT_STEAM_INFO.STEAMWORKS)
    {
        return _system.__usingSteamworks;
    }
    else if (_infoField == INPUT_STEAM_INFO.STEAM_DECK)
    {
        return _system.__onSteamDeck;
    }
    else if (_infoField == INPUT_STEAM_INFO.ON_WINE)
    {
        return _system.__onWINE;
    }
    else 
    {
        __InputError("Field ", _infoField, " unhandled");
    }
}