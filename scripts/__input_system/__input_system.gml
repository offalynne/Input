#macro __INPUT_VERSION "5.6.0"
#macro __INPUT_DATE    "2023-04-04"
#macro __INPUT_DEBUG   false



#region Forbidden Fruit

#macro __INPUT_2D_CHECKER_STATIC_RESULT  true

#macro __INPUT_DEBUG_PROFILES  false
#macro __INPUT_DEBUG_SOURCES   false
#macro __INPUT_DEBUG_BINDING   false
#macro __INPUT_DEBUG_VERBS     false

#macro __INPUT_EXTERNAL_DEBUG_LOG  false  //Do NOT set to <true> unless directed (!)

//How many frames to wait before scanning for connected gamepads
//This works around Steam sometimes reporting confusing connection/disconnection events on boot
#macro __INPUT_GAMEPADS_TICK_PREDELAY  10     

#endregion



#macro __INPUT_BINDING_KEY               "key"
#macro __INPUT_BINDING_MOUSE_BUTTON      "mouse button"
#macro __INPUT_BINDING_MOUSE_WHEEL_UP    "mouse wheel up"
#macro __INPUT_BINDING_MOUSE_WHEEL_DOWN  "mouse wheel down"
#macro __INPUT_BINDING_VIRTUAL_BUTTON    "virtual button"
#macro __INPUT_BINDING_GAMEPAD_BUTTON    "gamepad button"
#macro __INPUT_BINDING_GAMEPAD_AXIS      "gamepad axis"

#macro INPUT_KEYBOARD      global.__input_source_keyboard
#macro INPUT_MOUSE         global.__input_source_mouse
#macro INPUT_GAMEPAD       global.__input_source_gamepad
#macro INPUT_TOUCH         global.__input_source_touch
#macro INPUT_MAX_GAMEPADS  12

#macro INPUT_KEYBOARD_LOCALE  global.__input_keyboard_locale
#macro INPUT_KEYBOARD_TYPE    global.__input_keyboard_type

#macro INPUT_VIRTUAL_BACKGROUND  global.__input_virtual_background

#macro __INPUT_ON_PS       ((os_type == os_ps4)     || (os_type == os_ps5))
#macro __INPUT_ON_XBOX     ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro __INPUT_ON_CONSOLE  (__INPUT_ON_XBOX || __INPUT_ON_PS || (os_type == os_switch))

#macro __INPUT_ON_DESKTOP  ((os_type == os_macosx)  || (os_type == os_linux) || (os_type == os_windows))
#macro __INPUT_ON_APPLE    ((os_type == os_macosx)  || (os_type == os_ios)   || (os_type == os_tvos))
#macro __INPUT_ON_MOBILE   ((os_type == os_android) || (os_type == os_ios)   || (os_type == os_tvos))

#macro __INPUT_ON_OPERAGX  (os_type == os_operagx)
#macro __INPUT_ON_WEB      ((os_browser != browser_not_a_browser) || __INPUT_ON_OPERAGX)

#macro __INPUT_STEAMWORKS_SUPPORT         (((os_type == os_windows) || (os_type == os_linux)) && !__INPUT_ON_WEB)
#macro __INPUT_TOUCH_SUPPORT              (__INPUT_ON_MOBILE  || __INPUT_ON_PS  || (os_type == os_switch) || (os_type == os_windows))
#macro __INPUT_TOUCH_PRIMARY              (!INPUT_TOUCH_IS_MOUSE && (__INPUT_ON_MOBILE  || (os_type == os_switch) || (global.__input_on_steam_deck && (os_type == os_windows))))
#macro __INPUT_KEYBOARD_NORMATIVE         (__INPUT_ON_DESKTOP || __INPUT_ON_WEB || (os_type == os_switch))
#macro __INPUT_KEYBOARD_SUPPORT           (__INPUT_KEYBOARD_NORMATIVE || (os_type == os_android))
#macro __INPUT_GAMEPAD_VIBRATION_SUPPORT  (__INPUT_ON_CONSOLE || (!__INPUT_ON_WEB && (os_type == os_windows)))
#macro __INPUT_SDL2_SUPPORT               (!__INPUT_ON_WEB && (__INPUT_ON_DESKTOP || (os_type == os_android)))

#macro __INPUT_HOLD_THRESHOLD           0.2  //Minimum value from an axis for that axis to be considered activated at the gamepad layer. This is *not* the same as min/max thresholds for players
#macro __INPUT_DELTA_HOTSWAP_THRESHOLD  0.1  //Minimum (absolute) change in gamepad mapping value between frames to register as new input. This triggers hotswapping

#macro __INPUT_RATE_LIMIT_DURATION  500 //In milliseconds

//Valid keycode bounds
#macro __INPUT_KEYCODE_MIN 8
#macro __INPUT_KEYCODE_MAX 57343

//Extended gamepad constants
#macro gp_guide     32889
#macro gp_misc1     32890
#macro gp_touchpad  32891
#macro gp_paddle1   32892
#macro gp_paddle2   32893
#macro gp_paddle3   32894
#macro gp_paddle4   32895

//Enables analogue axis checks from triggers on XInput
#macro __XINPUT_AXIS_LT  4106
#macro __XINPUT_AXIS_RT  4107

//Unfortunately, versions prior to v5.2 used these values for extended gamepad constants
//They collide with GameMaker's native constants for gamepad axis values for PS4/PS5 controllers
#macro __INPUT_LEGACY_GP_GUIDE     32789 //gp_axis_acceleration_x
#macro __INPUT_LEGACY_GP_MISC1     32790 //gp_axis_acceleration_y
#macro __INPUT_LEGACY_GP_TOUCHPAD  32791 //gp_axis_acceleration_z
#macro __INPUT_LEGACY_GP_PADDLE1   32792 //gp_axis_angular_velocity_x
#macro __INPUT_LEGACY_GP_PADDLE2   32793 //gp_axis_angular_velocity_y
#macro __INPUT_LEGACY_GP_PADDLE3   32794 //gp_axis_angular_velocity_z
#macro __INPUT_LEGACY_GP_PADDLE4   32795 //gp_axis_orientation_x
                                         //gp_axis_orientation_y = 32796
                                         //gp_axis_orientation_z = 32797
                                         //gp_axis_orientation_w = 32798

//Extended keycode constants
#macro vk_clear       12
#macro vk_capslock    20
#macro vk_menu        93
#macro vk_scrollock   145
                      
#macro vk_semicolon   186
#macro vk_comma       188
#macro vk_fslash      191
#macro vk_bslash      220
#macro vk_lbracket    219
#macro vk_rbracket    221

#macro vk_apostrophe (((os_type == os_macosx) && !__INPUT_ON_WEB)? 192 : 222)
#macro vk_equals     (((os_type == os_macosx) && !__INPUT_ON_WEB)?  24 : 187)
#macro vk_numlock    ((__INPUT_ON_APPLE && __INPUT_ON_WEB)? 12 : 144)
#macro vk_hyphen     (((os_type == os_switch) || ((os_type == os_macosx) && !__INPUT_ON_WEB))? 109 : 189)
#macro vk_rmeta      ((os_type == os_macosx)? ((__INPUT_ON_APPLE && __INPUT_ON_WEB)? 93 : 91) : 92)
#macro vk_backtick   ((os_type == os_macosx)?  50 : ((os_type == os_linux)? 223 : 192))
#macro vk_lmeta      ((os_type == os_macosx)?  92 : 91)
#macro vk_period     ((os_type == os_switch)? 110 : 190)

// gp_axislh     = 32785             32769 = gp_face1
// gp_axislv     = 32786             32770 = gp_face2
// gp_axisrh     = 32787             32771 = gp_face3
// gp_axisrv     = 32788             32772 = gp_face4
// gp_shoulderl  = 32773             32773 = gp_shoulderl
// gp_shoulderr  = 32774             32774 = gp_shoulderr
// gp_shoulderlb = 32775             32775 = gp_shoulderlb
// gp_shoulderrb = 32776             32776 = gp_shoulderrb
// gp_padu       = 32781             32777 = gp_select
// gp_padd       = 32782             32778 = gp_start
// gp_padl       = 32783             32779 = gp_stickl
// gp_padr       = 32784             32780 = gp_stickr
// gp_face1      = 32769             32781 = gp_padu
// gp_face2      = 32770             32782 = gp_padd
// gp_face3      = 32771             32783 = gp_padl
// gp_face4      = 32772             32784 = gp_padr
// gp_stickl     = 32779             32785 = gp_axislh
// gp_stickr     = 32780             32786 = gp_axislv
// gp_select     = 32777             32787 = gp_axisrh
// gp_start      = 32778             32788 = gp_axisrv
// Plus custom buttons:
// gp_guide      = 32889             32889 = gp_guide
// gp_misc1      = 32890             32890 = gp_misc1
// gp_touchpad   = 32891             32891 = gp_touchpad
// gp_paddle1    = 32892             32892 = gp_paddle1
// gp_paddle2    = 32893             32893 = gp_paddle2
// gp_paddle3    = 32894             32894 = gp_paddle3
// gp_paddle4    = 32895             32895 = gp_paddle4

enum __INPUT_SOURCE
{
    KEYBOARD,
    MOUSE,
    GAMEPAD,
    TOUCH,
    __SIZE
}

enum __INPUT_MAPPING
{
    BUTTON,
    AXIS,
    HAT,
    HAT_TO_AXIS,
    BUTTON_TO_AXIS,
    SPLIT_AXIS,
    __SIZE
}

enum __INPUT_COMBO_STATE
{
    __FAIL    = -1,
    __WAITING =  0,
    __SUCCESS =  1,
}

enum __INPUT_COMBO_PHASE_TYPE
{
    __PRESS,
    __RELEASE,
    __PRESS_OR_RELEASE,
    __HOLD_START,
}

enum __INPUT_VERB_TYPE
{
    __BASIC,
    __CHORD,
    __COMBO,
}

enum __INPUT_TRIGGER_EFFECT
{
    __TYPE_OFF,
    __TYPE_FEEDBACK,
    __TYPE_WEAPON,
    __TYPE_VIBRATION,
}




function __input_axis_is_directional(_axis)
{
    return ((_axis == gp_padu)   || (_axis == gp_padd)   || (_axis == gp_padl)   || (_axis == gp_padr)
         || (_axis == gp_axislh) || (_axis == gp_axislv) || (_axis == gp_axisrh) || (_axis == gp_axisrv));
}

function __input_trace()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Input: " + _string);
    
    if (__INPUT_EXTERNAL_DEBUG_LOG)
    {
        var _file = file_text_open_append(global.__input_debug_log);
        file_text_write_string(_file, _string);
        file_text_writeln(_file);
        file_text_close(_file);
    }
}

function __input_trace_loud()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    show_debug_message("Input: LOUD " + _string);
    
    if (__INPUT_EXTERNAL_DEBUG_LOG)
    {
        var _file = file_text_open_append(global.__input_debug_log);
        file_text_write_string(_file, _string);
        file_text_writeln(_file);
        file_text_close(_file);
    }
    
    show_message(_string);
}

function __input_error()
{
    var _string = "";
    var _i = 0;
    repeat(argument_count)
    {
        _string += string(argument[_i]);
        ++_i;
    }
    
    if (os_browser == browser_not_a_browser)
    {
        show_error("Input " + __INPUT_VERSION + ":\n" + _string + "\n ", false);
    }
    else
    {
        show_error("Input " + __INPUT_VERSION + ":\n" + _string + "\n" + string(debug_get_callstack()), false);
    }
}

function __input_ensure_unique_verb_name(_name)
{
    if (variable_struct_exists(global.__input_basic_verb_dict, _name))
    {
        __input_error("A basic verb named \"", _name, "\" already exists");
        return;
    }
    
    if (variable_struct_exists(global.__input_chord_verb_dict, _name))
    {
        __input_error("A chord named \"", _name, "\" already exists");
        return;
    }
    
    if (variable_struct_exists(global.__input_combo_verb_dict, _name))
    {
        __input_error("A combo named \"", _name, "\" already exists");
        return;
    }
}

function __input_get_previous_time()
{
    return INPUT_TIMER_MILLISECONDS? global.__input_previous_current_time : (global.__input_frame - 1);
}

function __input_get_time()
{
    return (INPUT_TIMER_MILLISECONDS? global.__input_current_time : global.__input_frame);
}
