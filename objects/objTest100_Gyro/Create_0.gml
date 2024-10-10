if (INPUT_STEAMWORKS_SUPPORT)
{
    if (not InputGetSteamInfo(INPUT_STEAM_INFO.STEAMWORKS))
    {
        show_message_async("Warning! Gamepad motion support on this platform requires Steamworks extension");
    }
}
else if not (INPUT_ON_SWITCH || INPUT_ON_PS4 || INPUT_ON_PS5)
{
    show_message_async("Warning! Platform does not support gamepad motion");
}

pointerX = room_width/2;
pointerY = room_height/2;