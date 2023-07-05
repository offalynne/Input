function __InputInitializeConstants()
{
    var _funcAdd = function(_sourceType, _constant, _label)
    {
        static _constantToLabelDict      = __input_global().__constantToLabelDict;
        static _labelToConstantDict      = __input_global().__labelToConstantDict;
        static _constantToSourceTypeDict = __input_global().__constantToSourceTypeDict;
        
        _constantToLabelDict[$      string(_constant)] = _label;
        _labelToConstantDict[$      _label           ] = _constant;
        _constantToSourceTypeDict[$ string(_constant)] = _sourceType;
    }
    
    #region Mouse
    
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_left,       "mouse button left");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_middle,     "mouse button middle");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_right,      "mouse button right");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_side1,      "mouse button back");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_side2,      "mouse button forward");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_wheel_up,   "mouse wheel up");
    _funcAdd(__INPUT_SOURCE.MOUSE, mb_wheel_down, "mouse wheel down");
    
    #endregion
    
    #region Keyboard
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_backtick,   "`");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_hyphen,     "-");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_equals,     "=");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_semicolon,  ";");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_apostrophe, "'");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_comma,      ",");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_period,     ".");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_rbracket,   "]");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_lbracket,   "[");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_fslash,     "/");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_bslash,     "\\");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_scrollock, "scroll lock");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_capslock,  "caps lock");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numlock,   "num lock");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_lmeta,     "left meta");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_rmeta,     "right meta");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_clear,     "clear");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_menu,      "menu");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_printscreen, "print screen");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_pause,       "pause break");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_escape,    "escape");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_backspace, "backspace");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_space,     "space");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_enter,     "enter");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_up,    "arrow up");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_down,  "arrow down");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_left,  "arrow left");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_right, "arrow right");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_tab,      "tab");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_ralt,     "right alt");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_lalt,     "left alt");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_alt,      "alt");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_rshift,   "right shift");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_lshift,   "left shift");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_shift,    "shift");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_rcontrol, "right ctrl");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_lcontrol, "left ctrl");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_control,  "ctrl");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f1,  "f1");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f2,  "f2");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f3,  "f3");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f4,  "f4");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f5,  "f5");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f6,  "f6");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f7,  "f7");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f8,  "f8");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f9,  "f9");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f10, "f10");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f11, "f11");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_f12, "f12");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_divide,   "numpad /");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_multiply, "numpad *");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_subtract, "numpad -");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_add,      "numpad +");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_decimal,  "numpad .");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad0, "numpad 0");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad1, "numpad 1");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad2, "numpad 2");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad3, "numpad 3");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad4, "numpad 4");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad5, "numpad 5");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad6, "numpad 6");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad7, "numpad 7");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad8, "numpad 8");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_numpad9, "numpad 9");
    
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_delete,   "delete");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_insert,   "insert");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_home,     "home");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_pageup,   "page up");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_pagedown, "page down");
    _funcAdd(__INPUT_SOURCE.KEYBOARD, vk_end,      "end");
   
    //Name newline character after Enter
    _funcAdd(__INPUT_SOURCE.KEYBOARD, 10, "enter");
    
    //Reset F11 and F12 keycodes on certain platforms
    if (__INPUT_ON_LINUX || __INPUT_ON_MACOS)
    {
        _funcAdd(__INPUT_SOURCE.KEYBOARD, 128, "f11");
        _funcAdd(__INPUT_SOURCE.KEYBOARD, 129, "f12");
    }
   
    //F13 to F32 on Windows and Web
    if (__INPUT_ON_WINDOWS || INPUT_ON_WEB)
    {
        for(var _i = vk_f1 + 12; _i < vk_f1 + 32; _i++)
        {
            _funcAdd(__INPUT_SOURCE.KEYBOARD, _i, "f" + string(_i));
        }
    }
    
    #endregion
    
    #region Gamepad
    
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_face1,      "gamepad face south"        );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_face2,      "gamepad face east"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_face3,      "gamepad face west"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_face4,      "gamepad face north"        );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_shoulderl,  "gamepad shoulder l"        );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_shoulderr,  "gamepad shoulder r"        );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_shoulderlb, "gamepad trigger l"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_shoulderrb, "gamepad trigger r"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_start,      "gamepad start"             );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_select,     "gamepad select"            );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_stickl,     "gamepad thumbstick l click");
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_stickr,     "gamepad thumbstick r click");
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_padu,       "gamepad dpad up"           );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_padd,       "gamepad dpad down"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_padl,       "gamepad dpad left"         );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_padr,       "gamepad dpad right"        );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_guide,      "gamepad guide"             );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_misc1,      "gamepad misc 1"            );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_touchpad,   "gamepad touchpad click"    );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_paddle1,    "gamepad paddle 1"          );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_paddle2,    "gamepad paddle 2"          );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_paddle3,    "gamepad paddle 3"          );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_paddle4,    "gamepad paddle 4"          );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_axislh,     "gamepad thumbstick l right");
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_axislv,     "gamepad thumbstick l down" );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_axisrh,     "gamepad thumbstick r right");
    _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_axisrv,     "gamepad thumbstick r down" );
    
    _funcAdd(__INPUT_SOURCE.GAMEPAD, -gp_axislh,    "gamepad thumbstick l left" );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, -gp_axislv,    "gamepad thumbstick l up"   );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, -gp_axisrh,    "gamepad thumbstick r left" );
    _funcAdd(__INPUT_SOURCE.GAMEPAD, -gp_axisrv,    "gamepad thumbstick r up"   );
    
    #endregion
    
    #region Platform Special Cases
    
    if (!INPUT_ON_PC)
    {
        //Touch bindings
        if (__INPUT_ON_PS)
        {
            _funcAdd(__INPUT_SOURCE.GAMEPAD, gp_select, "gamepad touchpad click");
            _funcAdd(__INPUT_SOURCE.MOUSE,   mb_left,   "gamepad touchpad click");
        }
        else
        {
            _funcAdd(__INPUT_SOURCE.MOUSE, mb_left, "touchscreen press");
        }
    }
    
    #endregion
}