#macro __INPUT_VERSION "4.2.0.1"
#macro __INPUT_DATE    "2022-04-23"
#macro __INPUT_DEBUG   false


#macro __INPUT_ON_PS       ((os_type == os_ps4)     || (os_type == os_ps5))
#macro __INPUT_ON_XDK      ((os_type == os_xboxone) || (os_type == os_xboxseriesxs))
#macro __INPUT_ON_CONSOLE  (__INPUT_ON_XDK || __INPUT_ON_PS || (os_type == os_switch))

#macro __INPUT_ON_DESKTOP  ((os_type == os_macosx)  || (os_type == os_linux) || (os_type == os_windows))
#macro __INPUT_ON_APPLE    ((os_type == os_macosx)  || (os_type == os_ios)   || (os_type == os_tvos))
#macro __INPUT_ON_MOBILE   ((os_type == os_android) || (os_type == os_ios)   || (os_type == os_tvos))

#macro __INPUT_ON_OPERAGX  (os_type == os_operagx)
#macro __INPUT_ON_WEB      ((os_browser != browser_not_a_browser) || __INPUT_ON_OPERAGX)

#macro __INPUT_TOUCH_SUPPORT      (__INPUT_ON_MOBILE  || __INPUT_ON_PS  || (os_type == os_switch) || ((os_type == os_uwp) && uwp_device_touchscreen_available()))
#macro __INPUT_KEYBOARD_NORMATIVE (__INPUT_ON_DESKTOP || __INPUT_ON_WEB || (os_type == os_switch) ||  (os_type == os_uwp))
#macro __INPUT_KEYBOARD_SUPPORT   (__INPUT_KEYBOARD_NORMATIVE || (os_type == os_android))

#macro __INPUT_SDL2_SUPPORT  (!__INPUT_ON_WEB && (__INPUT_ON_DESKTOP || (os_type == os_android)))

#macro __INPUT_HOLD_THRESHOLD  0.2 //Minimum value from an axis for that axis to be considered activated at the gamepad layer. This is *not* the same as min/max thresholds for players

//Valid keycode bounds
#macro __INPUT_KEYCODE_MIN 8
#macro __INPUT_KEYCODE_MAX 57343

//Extended gamepad constants
#macro gp_guide     32789
#macro gp_misc1     32790
#macro gp_touchpad  32791
#macro gp_paddle1   32792
#macro gp_paddle2   32793
#macro gp_paddle3   32794
#macro gp_paddle4   32795

//Extended keycode constants
#macro vk_meta1  91
#macro vk_meta2  92

#macro vk_capslock   20
#macro vk_scrollock  145
#macro vk_numlock    ((__INPUT_ON_APPLE && __INPUT_ON_WEB) ? 12 : 144)

#macro vk_semicolon  186
#macro vk_comma      188
#macro vk_fslash     191
#macro vk_bslash     220
#macro vk_lbracket   219
#macro vk_rbracket   221

#macro vk_apostrophe  (((os_type == os_macosx) && !__INPUT_ON_WEB) ? 192 : 222)
#macro vk_equals      (((os_type == os_macosx) && !__INPUT_ON_WEB) ?  24 : 187)
#macro vk_hyphen      (((os_type == os_switch) || ((os_type == os_macosx) && !__INPUT_ON_WEB)) ? 109 : 189)
#macro vk_backtick    ((os_type == os_macosx) ? 50 : ((os_type == os_linux) ? 223 : 192))
#macro vk_period      ((os_type == os_switch) ? 110 : 190)

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
// gp_guide      = 32789             32789 = gp_guide
// gp_misc1      = 32790             32790 = gp_misc1
// gp_touchpad   = 32791             32791 = gp_touchpad
// gp_paddle1    = 32792             32792 = gp_paddle1
// gp_paddle2    = 32793             32793 = gp_paddle2
// gp_paddle3    = 32794             32794 = gp_paddle3
// gp_paddle4    = 32795             32795 = gp_paddle4

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
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

//INPUT_STATUS.DISCONNECTED *must* be zero so that array_size() initializes gamepad status to disconnected
//See input_tick() for more details
enum INPUT_STATUS
{
    NEWLY_DISCONNECTED = -1,
    DISCONNECTED       =  0,
    NEWLY_CONNECTED    =  1,
    CONNECTED          =  2,
}

#macro INPUT_NO_GAMEPAD  -1





//These are globally scoped rather than methods because otherwise they'd get serialised by input_bindings_write()

/// @param source
function __input_binding_duplicate(_source)
{
    with(_source)
    {
        var _binding = new __input_class_binding();
        _binding.type          = type;
        _binding.value         = value;
        _binding.axis_negative = axis_negative;
        _binding.label         = label;
        if (variable_struct_exists(self, "android_lowercase")) _binding.android_lowercase = android_lowercase;
        
        return _binding;
    }
}

/// @param from
/// @param to
function __input_binding_overwrite(_from, _to)
{
    with(_to)
    {
        type          = _from.type;
        value         = _from.value;
        axis_negative = _from.axis_negative;
        label         = _from.label;
    }
    
    return _to;
}

function __input_axis_is_directional(_axis)
{
    return ((_axis == gp_padu)   || (_axis == gp_padd)   || (_axis == gp_padl)   || (_axis == gp_padr)
         || (_axis == gp_axislh) || (_axis == gp_axislv) || (_axis == gp_axisrh) || (_axis == gp_axisrv));
}

/// @param GUID
/// @param legacy
/// @param suppressWarnings
function __input_gamepad_guid_parse(_guid, _legacy, _suppress)
{
    var _vendor  = "";
    var _product = "";
    
    if (_guid == "00000000000000000000000000000000")
    {
        if (!_suppress) __input_trace("Warning! GUID was empty");
        return { vendor : "", product : "" };
    }
    
    if (_legacy)
    {
        //GM on Windows uses an older version of SDL so we strip out VID + PID as a special case
        _vendor  = string_copy(_guid, 1, 4);
        _product = string_copy(_guid, 5, 4);
    }
    else
    {
        //Check to see if this GUID fits our expected pattern:
        //
        //  ****0000****0000****0000****????
        //  ^       ^       ^       ^
        //  Driver  Vendor  Product Revision
        //
        //If not, return an invalid VID+PID
        if ((string_copy(_guid,  5, 4) != "0000")
        ||  (string_copy(_guid, 13, 4) != "0000")
        ||  (string_copy(_guid, 21, 4) != "0000"))
        {
            if (!_suppress) __input_trace("Warning! GUID \"", _guid, "\" does not fit expected pattern. VID+PID cannot be extracted");
            return { vendor : "", product : "" };
        }
        
        //Check to see if the driver for this GUID is what we expect
        //In some cases, what we expect for the driver ID is going to be different so this isn't necessarily something that invalidates VID+PID checking
        if ((string_copy(_guid, 1, 4) != "0300") && (string_copy(_guid, 1, 4) != "0500"))
        {
            if (!_suppress) __input_trace("Warning! GUID \"", _guid, "\" driver ID does not match expected (Found ", string_copy(_guid, 1, 4), ", expect either 0300 or 0500)");
        }
        
        _vendor  = string_copy(_guid,  9, 4);
        _product = string_copy(_guid, 17, 4);
    }
    
    return { vendor : _vendor, product : _product };
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
    
    if (INPUT_EXTERNAL_DEBUG_LOG)
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
    
    if (INPUT_EXTERNAL_DEBUG_LOG)
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
    
    show_error("Input:\n" + _string + "\n ", false);
}

function __input_get_previous_time()
{
    return INPUT_TIMER_MILLISECONDS? (current_time - delta_time/1000) : (global.__input_frame - 1);
}

function __input_get_time()
{
    return (INPUT_TIMER_MILLISECONDS? current_time : global.__input_frame);
}
