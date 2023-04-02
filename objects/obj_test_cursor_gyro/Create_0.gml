input_cursor_set(room_width/2, room_height/2);
input_cursor_limit_aabb(0, 0, room_width, room_height);
input_cursor_speed_set(12);

if ((os_type == os_windows) || (os_type == os_linux))
{
    try
    {
        steam_utils_is_steam_running_on_steam_deck();
    }
    catch(_error)
    {
        show_message_async("Warning! Gamepad motion support on this platform requires Steamworks extension");
    }
}
else if not ((os_type == os_switch) || (os_type == os_ps4) || (os_type == os_ps5))
{
    show_message_async("Warning! Platform does not support gamepad motion");
}