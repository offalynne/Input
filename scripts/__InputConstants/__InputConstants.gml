// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//          Customisation options can be found in __InputConfig().        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro INPUT_VERSION  "10.0.8"
#macro INPUT_DATE     "2025-05-01"

#macro INPUT_NO_DEVICE       -666
#macro INPUT_KBM             -1
#macro INPUT_TOUCH           -2
#macro INPUT_GENERIC_DEVICE  -3

#macro INPUT_ALL_PLAYERS  -3

#macro INPUT_GAMEPAD_TYPE_NO_GAMEPAD    0
#macro INPUT_GAMEPAD_TYPE_UNKNOWN       1
#macro INPUT_GAMEPAD_TYPE_XBOX          2
#macro INPUT_GAMEPAD_TYPE_PS4           3
#macro INPUT_GAMEPAD_TYPE_PS5           4
#macro INPUT_GAMEPAD_TYPE_SWITCH        5
#macro INPUT_GAMEPAD_TYPE_JOYCON_LEFT   6
#macro INPUT_GAMEPAD_TYPE_JOYCON_RIGHT  7

#macro INPUT_SUPPORT_GAMEPADS  (not INPUT_BAN_GAMEPADS)
#macro INPUT_SUPPORT_KBM       (not INPUT_BAN_KBM)
#macro INPUT_SUPPORT_TOUCH     (not INPUT_BAN_TOUCH)
#macro INPUT_SUPPORT_HOTSWAP   (not INPUT_BAN_HOTSWAP)

enum INPUT_PLAYER_STATUS
{
    DISCONNECTED,
    NEWLY_DISCONNECTED,
    NEWLY_CONNECTED,
    CONNECTED,
}

enum INPUT_THRESHOLD
{
    LEFT,
    RIGHT,
    BOTH,
    __SIZE,
}

enum INPUT_VIRTUAL_TYPE
{
    BUTTON,
    DPAD_4DIR,
    DPAD_8DIR,
    DPAD_HORIZONTAL,
    DPAD_VERTICAL,
    THUMBSTICK,
    TOUCHPAD,
}

enum INPUT_VIRTUAL_REFERENCE
{
    CENTER,
    TOUCH_POINT,
    DELTA,
}

enum INPUT_VIRTUAL_RELEASE
{
    DO_NOTHING,
    DESTROY,
    RESET_POSITION,
}

enum INPUT_STEAM_INFO
{
    STEAMWORKS,
    STEAM_DECK,
    ON_WINE,
}

enum INPUT_PLUG_IN_CALLBACK
{
    COLLECT,
    UPDATE,
    GAMEPAD_DISCONNECTED,
    GAMEPAD_CONNECTED,
    PLAYER_DEVICE_CHANGED,
    COLLECT_PLAYER,
    UPDATE_PLAYER,
    LOSE_FOCUS,
    GAIN_FOCUS,
    __SIZE,
}

#macro INPUT_RUNNING_FROM_IDE  (GM_build_type == "run")

#macro INPUT_ON_WINDOWS  (os_type == os_windows)
#macro INPUT_ON_MACOS    (os_type == os_macosx)
#macro INPUT_ON_LINUX    (os_type == os_linux)
#macro INPUT_ON_DESKTOP  (INPUT_ON_WINDOWS || INPUT_ON_MACOS || INPUT_ON_LINUX)
#macro INPUT_ON_IOS      (os_type == os_ios)
#macro INPUT_ON_ANDROID  (os_type == os_android)
#macro INPUT_ON_MOBILE   (INPUT_ON_IOS || INPUT_ON_ANDROID)
#macro INPUT_ON_XBOX     ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro INPUT_ON_PS4      (os_type == os_ps4)
#macro INPUT_ON_PS5      (os_type == os_ps5)
#macro INPUT_ON_SWITCH   (os_type == os_switch)
#macro INPUT_ON_CONSOLE  (INPUT_ON_XBOX || INPUT_ON_PS4 || INPUT_ON_PS5 || INPUT_ON_SWITCH)
#macro INPUT_ON_APPLE    (INPUT_ON_MACOS || INPUT_ON_IOS)
#macro INPUT_ON_OPERAGX  (os_type == os_operagx)
#macro INPUT_ON_WEB      ((os_browser != browser_not_a_browser) || INPUT_ON_OPERAGX)

#macro INPUT_STEAMWORKS_SUPPORT   ((INPUT_ON_LINUX || INPUT_ON_WINDOWS) && (not INPUT_ON_WEB))
#macro INPUT_SDL_SUPPORT          ((not INPUT_ON_WEB) && INPUT_ON_DESKTOP)

#macro INPUT_BAN_GAMEPADS  INPUT_ON_MOBILE
#macro INPUT_BAN_KBM       (not INPUT_ON_DESKTOP)
#macro INPUT_BAN_TOUCH     (not INPUT_ON_MOBILE)
#macro INPUT_BAN_HOTSWAP   INPUT_ON_MOBILE

#macro INPUT_BLOCK_MOUSE_CHECKS  INPUT_ON_CONSOLE

//How many frames to wait before scanning for connected gamepads
//This works around Steam sometimes reporting confusing connection/disconnection events on boot
#macro INPUT_GAMEPADS_TICK_PREDELAY  10

//How many frames to wait before considering a gamepad disconnected
//This works around momentary disconnections such as a jiggled cable or low battery level
#macro INPUT_GAMEPADS_DISCONNECTION_TIMEOUT  5

// 32769 = gp_face1
// 32770 = gp_face2
// 32771 = gp_face3
// 32772 = gp_face4
// 32773 = gp_shoulderl
// 32774 = gp_shoulderr
// 32775 = gp_shoulderlb
// 32776 = gp_shoulderrb
// 32777 = gp_select
// 32778 = gp_start
// 32779 = gp_stickl
// 32780 = gp_stickr
// 32781 = gp_padu
// 32782 = gp_padd
// 32783 = gp_padl
// 32784 = gp_padr
// 32785 = gp_axislh
// 32786 = gp_axislv
// 32787 = gp_axisrh
// 32788 = gp_axisrv
// 32789
// 32790
// 32791
// 32792
// 32793
// 32794
// 32795
// 32796
// 32797
// 32798
// 32799 = gp_home
// 32800 = gp_extra1
// 32801 = gp_extra2
// 32802 = gp_extra3
// 32803 = gp_extra4
// 32804 = gp_paddler
// 32805 = gp_paddlel
// 32806 = gp_paddlerb
// 32807 = gp_paddlelb
// 32808 = gp_touchpadbutton
// 32809 = gp_extra5
// 32810 = gp_extra6

#macro INPUT_GAMEPAD_BINDING_MIN  gp_face1
#macro INPUT_GAMEPAD_BINDING_MAX  gp_extra6