#macro __INPUT_VERSION                   "3.3.3"
#macro __INPUT_DATE                      "2020-04-14"
#macro __INPUT_DEBUG                     false
#macro __INPUT_SDL2_DATABASE_FILENAME    "sdl2.txt"                //Name of the SDL2 database to read gamepad remapping definitions from
#macro __INPUT_CONTROLLER_TYPE_FILENAME  "controllertypes.csv"     //Name of the controller type database to read gamepad types from
#macro __INPUT_BLACKLIST_FILENAME        "controllerblacklist.csv" //Name of the controller blacklist database to read from

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
    __SIZE
}

#macro INPUT_NO_GAMEPAD  -1
#macro gp_guide  32789
#macro gp_misc1  32790

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

//Set up the extended debug functionality
global.__input_debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
if (INPUT_EXTERNAL_DEBUG_LOG && __INPUT_DEBUG)
{
    show_debug_message("Input: Set external debug log to \"" + string(global.__input_debug_log) + "\"");
    exception_unhandled_handler(__input_exception_handler);
}

__input_trace("Welcome to Input by @jujuadams and @offalynne! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);

//Global frame counter. This is used for input buffering
global.__input_frame = 0;

//Mouse tracking variables. These are used to detect when the mouse has moved
global.__input_mouse_x     = 0;
global.__input_mouse_y     = 0;
global.__input_mouse_moved = false;

//Cursor tracking variables. This is Input's abstraction layer for the mouse, allowing mouse-like functionality cross-platform
global.__input_cursor_verb_u      = undefined;
global.__input_cursor_verb_d      = undefined;
global.__input_cursor_verb_l      = undefined;
global.__input_cursor_verb_r      = undefined;
global.__input_cursor_speed       = 0;
global.__input_cursor_using_mouse = true;

//Whether these particular input sources are valid
//This is determined by what default keybindings are set up
global.__input_keyboard_valid = false;
global.__input_mouse_valid    = false;
global.__input_gamepad_valid  = false;

//Whether to swap A/B gamepad buttons for default bindings
global.__input_swap_ab = false;

//Struct that contains which verbs to track when recording history
global.__input_history_include = {};

//Struct to store all the keyboard keys we want to ignore
global.__input_ignore_key_dict = {};

//Names for sources. I suspect this'll get sliced out at some point when I start recoding the binding system to serialise per controller type
global.__input_source_names = ["none", "keyboard and mouse", "gamepad"];

//Array of players. Each player is a struct (instanceof __input_class_player) that contains lotsa juicy information
global.__input_players = array_create(INPUT_MAX_PLAYERS, undefined);
var _p = 0;
repeat(INPUT_MAX_PLAYERS)
{
    global.__input_players[@ _p] = new __input_class_player();
    ++_p;
}

//The default player. This player struct holds default binding data
global.__input_default_player = new __input_class_player();

//The last player (struct) that was rebinding a key. Used for input_rebind_undo()
global.__input_rebind_last_player = undefined;

//Array of currently connected gamepads. If an element is <undefined> then the gamepad is disconnected
//Each gamepad in this array is an instance of __input_class_gamepad
//Gamepad structs contain remapping information and current button state
global.__input_gamepads = array_create(gamepad_get_device_count(), undefined);

//Our database of SDL2 definitions, used for the aforementioned remapping information
global.__input_sdl2_database = {
    by_guid           : {},
    by_vendor_product : {},
};

global.__input_sdl2_look_up_table = {
    a:             gp_face1,
    b:             gp_face2,
    x:             gp_face3,
    y:             gp_face4,
    dpup:          gp_padu,
    dpdown:        gp_padd,
    dpleft:        gp_padl,
    dpright:       gp_padr,
    leftx:         gp_axislh,
    lefty:         gp_axislv,
    rightx:        gp_axisrh,
    righty:        gp_axisrv,
    leftshoulder:  gp_shoulderl,
    rightshoulder: gp_shoulderr,
    lefttrigger:   gp_shoulderlb,
    righttrigger:  gp_shoulderrb,
    leftstick:     gp_stickl,
    rightstick:    gp_stickr,
    start:         gp_start,
    back:          gp_select,
}

if (INPUT_SDL2_ALLOW_GUIDE) global.__input_sdl2_look_up_table.guide = gp_guide;
if (INPUT_SDL2_ALLOW_MISC1) global.__input_sdl2_look_up_table.misc1 = gp_misc1;

//Alright, now that we've set up the requisite data structures, let's load the SDL2 database
//PS. Here're some SDL sources
//https://github.com/gabomdq/SDL_GameControllerDB/
//https://yachtclubgames.com/2014/03/steam-controller-support/
//https://github.com/libretro/retroarch-joypad-autoconfig/
//https://support.steampowered.com/kb_article.php?ref=5199-TOKV-4426
//http://www.linux-usb.org/usb.ids

if (file_exists(__INPUT_SDL2_DATABASE_FILENAME))
{
    __input_load_sdl2_from_file(__INPUT_SDL2_DATABASE_FILENAME);
}
else
{
    __input_trace("Warning! \"", __INPUT_SDL2_DATABASE_FILENAME, "\" not found in Included Files");
}

//Try to load an external SDL2 database if possible
if (INPUT_SDL2_ALLOW_EXTERNAL)
{
    var _external_string = environment_get_variable("SDL_GAMECONTROLLERCONFIG");
    if (_external_string != "")
    {
        __input_trace("External SDL2 string found");
        
        try
        {
            __input_load_sdl2_from_string(_external_string);
        }
        catch(_error)
        {
            __input_trace_loud("Error!\n\n%SDL_GAMECONTROLLERCONFIG% could not be parsed.\nYou may see unexpected behaviour when using gamepads.\n\nTo remove this error, clear %SDL_GAMECONTROLLERCONFIG%\n\nInput ", __INPUT_VERSION, "   @jujuadams ", __INPUT_DATE);
        }
    }
}

//Parse the controller type database
global.__input_type_dictionary = { none : "xb360" };

if (file_exists(__INPUT_CONTROLLER_TYPE_FILENAME))
{
    __input_load_type_csv(__INPUT_CONTROLLER_TYPE_FILENAME);
}
else
{
    __input_trace("Warning! \"", __INPUT_CONTROLLER_TYPE_FILENAME, "\" not found in Included Files");
}

//Parse the controller type database
global.__input_blacklist_dictionary = {};

if (file_exists(__INPUT_BLACKLIST_FILENAME))
{
    __input_load_blacklist_csv(__INPUT_BLACKLIST_FILENAME);
}
else
{
    __input_trace("Warning! \"", __INPUT_BLACKLIST_FILENAME, "\" not found in Included Files");
}

//Set up ignored keys as directed
if (INPUT_DESKTOP_IGNORE_RESERVED_KEYS_LEVEL == 1)
{
    input_ignore_key_add(vk_alt);
    input_ignore_key_add(vk_ralt);
    input_ignore_key_add(vk_lalt);
    input_ignore_key_add(91); //left meta
    input_ignore_key_add(92); //right meta
}
else if (INPUT_DESKTOP_IGNORE_RESERVED_KEYS_LEVEL == 2)
{
    input_ignore_key_add(vk_alt);
    input_ignore_key_add(vk_ralt);
    input_ignore_key_add(vk_lalt);
    input_ignore_key_add(91); //left meta
    input_ignore_key_add(92); //right meta
    
    input_ignore_key_add(144); //num lock
    input_ignore_key_add(145); //scroll lock
    
    input_ignore_key_add(0x15); //IME key
    input_ignore_key_add(0x16); //IME key
    input_ignore_key_add(0x17); //IME key
    input_ignore_key_add(0x18); //IME key
    input_ignore_key_add(0x19); //IME key
    input_ignore_key_add(0x1A); //IME key
    input_ignore_key_add(0xE5); //IME key
    
    input_ignore_key_add(0xA6); //Browser key
    input_ignore_key_add(0xA7); //Browser key
    input_ignore_key_add(0xA8); //Browser key
    input_ignore_key_add(0xA9); //Browser key
    input_ignore_key_add(0xAA); //Browser key
    input_ignore_key_add(0xAB); //Browser key
    input_ignore_key_add(0xAC); //Browser key
    
    input_ignore_key_add(0xAD); //Media key
    input_ignore_key_add(0xAE); //Media key
    input_ignore_key_add(0xAF); //Media key
    input_ignore_key_add(0xB0); //Media key
    input_ignore_key_add(0xB1); //Media key
    input_ignore_key_add(0xB2); //Media key
    input_ignore_key_add(0xB3); //Media key
    input_ignore_key_add(0xB4); //Media key
    input_ignore_key_add(0xB5); //Media key
    input_ignore_key_add(0xB6); //Media key
    input_ignore_key_add(0xB7); //Media key
}










//These are globally scoped rather than methods because otherwise they'd get serialised by input_bindings_write()

/// @param source
function __input_binding_duplicate(_source)
{
    with(_source)
    {
        return new __input_class_binding(type, value, axis_negative);
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
    }
    
    return _to;
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
        //  ****0000****0000****0000****0000
        //  ^       ^       ^       ^
        //  Driver  Vendor  Product Revision
        //
        //If not, return an invalid VID+PID
        if ((string_copy(_guid,  5, 4) != "0000")
        ||  (string_copy(_guid, 13, 4) != "0000")
        ||  (string_copy(_guid, 21, 4) != "0000")
        ||  (string_copy(_guid, 29, 4) != "0000"))
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

function __input_get_time()
{
    return (INPUT_TIMER_MILLISECONDS? current_time : global.__input_frame);
}