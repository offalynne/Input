#macro __INPUT_VERSION "3.1.0.pre004"
#macro __INPUT_DATE    "2020-01-12"
#macro __INPUT_DEBUG   false
#macro __INPUT_SDL2_DATABASE_FILENAME  "gamecontrollerdb.txt" //Name of the SDL2 database to read gamepad remapping definitions from

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
    __SIZE
}

#macro INPUT_NO_GAMEPAD  -1





//Set up the extended debug functionality
global.__input_debug_log = "input___" + string_replace_all(string_replace_all(date_datetime_string(date_current_datetime()), ":", "-"), " ", "___") + ".txt";
if (INPUT_EXTERNAL_DEBUG_LOG && __INPUT_DEBUG)
{
    show_debug_message("Input: Set external debug log to \"" + string(global.__input_debug_log) + "\"");
    exception_unhandled_handler(__input_exception_handler);
}

__input_trace("Welcome to Input by @jujuadams! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);

if (__INPUT_DEBUG)
{
    __input_trace("gp_axislh = ", gp_axislh);
    __input_trace("gp_axislv = ", gp_axislv);
    __input_trace("gp_axisrh = ", gp_axisrh);
    __input_trace("gp_axisrv = ", gp_axisrv);
    __input_trace("gp_shoulderlb = ", gp_shoulderlb);
    __input_trace("gp_shoulderrb = ", gp_shoulderrb);
    
    __input_trace("gp_padu = ", gp_padu);
    __input_trace("gp_padd = ", gp_padd);
    __input_trace("gp_padl = ", gp_padl);
    __input_trace("gp_padr = ", gp_padr);
    
    __input_trace("gp_face1 = ", gp_face1);
    __input_trace("gp_face2 = ", gp_face2);
    __input_trace("gp_face3 = ", gp_face3);
    __input_trace("gp_face4 = ", gp_face4);
    
    __input_trace("gp_stickl = ", gp_stickl);
    __input_trace("gp_stickr = ", gp_stickr);
    
    __input_trace("gp_select = ", gp_select);
    __input_trace("gp_start = ", gp_start);
}

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
    array             : [],
    by_vendor_product : {},
    by_platform       : {},
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
}
variable_struct_set(global.__input_sdl2_look_up_table, INPUT_SDL2_GP_SELECT_NAME, gp_select);

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

/// @param source
/// @param [gamepad]
function __input_source_is_available()
{
    var _source  = argument[0];
    var _gamepad = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : INPUT_NO_GAMEPAD;
    
    switch(_source)
    {
        case INPUT_SOURCE.NONE:
            return true;
        break;
        
        case INPUT_SOURCE.GAMEPAD:
            if (!global.__input_gamepad_valid) return false;
            if (_gamepad == INPUT_NO_GAMEPAD) return true;
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if ((global.__input_players[_p].source == INPUT_SOURCE.GAMEPAD) && (global.__input_players[_p].gamepad == _gamepad)) return false;
                ++_p;
            }
        break;
        
        case INPUT_SOURCE.KEYBOARD_AND_MOUSE:
            if (!global.__input_keyboard_valid && !global.__input_mouse_valid) return false;
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                if (global.__input_players[_p].source == INPUT_SOURCE.KEYBOARD_AND_MOUSE) return false;
                ++_p;
            }
        break;
    }
    
    return true;
}

/// @param GUID
/// @param legacy
function __input_gamepad_guid_parse(_guid, _legacy)
{
    var _vendor  = "";
    var _product = "";
    
    if (_legacy) //GM on Windows uses an older version of SDL
    {
        _vendor  = string_copy(_guid, 1, 4);
        _product = string_copy(_guid, 5, 4);
    }
    else
    {
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