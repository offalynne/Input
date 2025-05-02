// Feather disable all

/// Returns `true` if the current platform supports gyro and motion. Platforms that support gyro:
/// - Windows & Linux, if Steam is open and Steamworks has been implemented in the game
/// - PlayStation 4 & PlayStation 5
/// - Nintendo Switch

function InputMotionSupportedByPlatform()
{
    static _result = ((INPUT_ON_SWITCH || INPUT_ON_PS4 || INPUT_ON_PS5)
                  ||  ((INPUT_ON_WINDOWS || INPUT_ON_LINUX) && InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS)));
    
    return _result;
}