// Feather disable all

function __InputCreateKbmBindingNameMap()
{
    var _map = ds_map_create();
    
    ds_map_add(_map, mb_left,       "mouse button left");
    ds_map_add(_map, mb_middle,     "mouse button middle");
    ds_map_add(_map, mb_right,      "mouse button right");
    ds_map_add(_map, mb_side1,      "mouse button forward");
    ds_map_add(_map, mb_side2,      "mouse button back");
    ds_map_add(_map, mb_wheel_up,   "mouse wheel up");
    ds_map_add(_map, mb_wheel_down, "mouse wheel down");
    
    ds_map_add(_map, vk_backtick,   "`");
    ds_map_add(_map, vk_hyphen,     "-");
    ds_map_add(_map, vk_equals,     "=");
    ds_map_add(_map, vk_semicolon,  ";");
    ds_map_add(_map, vk_apostrophe, "'");
    ds_map_add(_map, vk_comma,      ",");
    ds_map_add(_map, vk_period,     ".");
    ds_map_add(_map, vk_rbracket,   "]");
    ds_map_add(_map, vk_lbracket,   "[");
    ds_map_add(_map, vk_fslash,     "/");
    ds_map_add(_map, vk_bslash,     "\\");

    ds_map_add(_map, vk_scrollock, "scroll lock");
    ds_map_add(_map, vk_capslock,  "caps lock");
    ds_map_add(_map, vk_numlock,   "num lock");
    ds_map_add(_map, vk_lmeta,     "left meta");
    ds_map_add(_map, vk_rmeta,     "right meta");
    ds_map_add(_map, vk_clear,     "clear");
    ds_map_add(_map, vk_menu,      "menu");

    ds_map_add(_map, vk_printscreen, "print screen");
    ds_map_add(_map, vk_pause,       "pause break");
    
    ds_map_add(_map, vk_escape,    "escape");
    ds_map_add(_map, vk_backspace, "backspace");
    ds_map_add(_map, vk_space,     "space");
    ds_map_add(_map, vk_enter,     "enter");
    
    ds_map_add(_map, vk_up,    "arrow up");
    ds_map_add(_map, vk_down,  "arrow down");
    ds_map_add(_map, vk_left,  "arrow left");
    ds_map_add(_map, vk_right, "arrow right");
    
    ds_map_add(_map, vk_tab,      "tab");
    ds_map_add(_map, vk_ralt,     "right alt");
    ds_map_add(_map, vk_lalt,     "left alt");
    ds_map_add(_map, vk_alt,      "alt");
    ds_map_add(_map, vk_rshift,   "right shift");
    ds_map_add(_map, vk_lshift,   "left shift");
    ds_map_add(_map, vk_shift,    "shift");
    ds_map_add(_map, vk_rcontrol, "right ctrl");
    ds_map_add(_map, vk_lcontrol, "left ctrl");
    ds_map_add(_map, vk_control,  "ctrl");

    ds_map_add(_map, vk_f1,  "f1");
    ds_map_add(_map, vk_f2,  "f2");
    ds_map_add(_map, vk_f3,  "f3");
    ds_map_add(_map, vk_f4,  "f4");
    ds_map_add(_map, vk_f5,  "f5");
    ds_map_add(_map, vk_f6,  "f6");
    ds_map_add(_map, vk_f7,  "f7");
    ds_map_add(_map, vk_f8,  "f8");
    ds_map_add(_map, vk_f9,  "f9");
    ds_map_add(_map, vk_f10, "f10");
    ds_map_add(_map, vk_f11, "f11");
    ds_map_add(_map, vk_f12, "f12");

    ds_map_add(_map, vk_divide,   "numpad /");
    ds_map_add(_map, vk_multiply, "numpad *");
    ds_map_add(_map, vk_subtract, "numpad -");
    ds_map_add(_map, vk_add,      "numpad +");
    ds_map_add(_map, vk_decimal,  "numpad .");

    ds_map_add(_map, vk_numpad0, "numpad 0");
    ds_map_add(_map, vk_numpad1, "numpad 1");
    ds_map_add(_map, vk_numpad2, "numpad 2");
    ds_map_add(_map, vk_numpad3, "numpad 3");
    ds_map_add(_map, vk_numpad4, "numpad 4");
    ds_map_add(_map, vk_numpad5, "numpad 5");
    ds_map_add(_map, vk_numpad6, "numpad 6");
    ds_map_add(_map, vk_numpad7, "numpad 7");
    ds_map_add(_map, vk_numpad8, "numpad 8");
    ds_map_add(_map, vk_numpad9, "numpad 9");

    ds_map_add(_map, vk_delete,   "delete");
    ds_map_add(_map, vk_insert,   "insert");
    ds_map_add(_map, vk_home,     "home");
    ds_map_add(_map, vk_pageup,   "page up");
    ds_map_add(_map, vk_pagedown, "page down");
    ds_map_add(_map, vk_end,      "end");
   
    //Name newline character after Enter
    ds_map_add(_map, 10, _map[? vk_enter]);
    
    //Reset F11 and F12 keycodes on certain platforms
    if (INPUT_ON_LINUX || INPUT_ON_MACOS)
    {
        ds_map_add(_map, 128, "f11");
        ds_map_add(_map, 129, "f12");
    }
   
    //F13 to F32 on Windows and Web
    if (INPUT_ON_WINDOWS || INPUT_ON_WEB)
    {
        for(var _i = vk_f1 + 12; _i < vk_f1 + 32; _i++) ds_map_add(_map, _i, "f" + string(_i));
    }
    
    return _map;
}