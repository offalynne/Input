function input_tick()
{
    global.__input_frame++;
    
    global.__input_mouse_moved = (point_distance(display_mouse_get_x(), display_mouse_get_y(), global.__input_mouse_x, global.__input_mouse_y) > INPUT_MOUSE_MOVE_DEADZONE);
    global.__input_mouse_x = display_mouse_get_x();
    global.__input_mouse_y = display_mouse_get_y();
    
    var _g = 0;
    repeat(array_length(global.__input_gamepads))
    {
        var _gamepad = global.__input_gamepads[_g];
        if (is_struct(_gamepad)) _gamepad.tick();
        ++_g;
    }
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].tick();
        ++_p;
    }
}





//------------------------------------------------------------------------------------------------------------------------------------------------
//
// Beneath here lies the internal code for the library (including the initialisation flow)
// It gets pretty gnarly. Proceed with caution
//
//------------------------------------------------------------------------------------------------------------------------------------------------





#region Library Initialisation

__input_trace("Welcome to Input by @jujuadams! This is version ", __INPUT_VERSION, ", ", __INPUT_DATE);

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
if (INPUT_SDL2_DATABASE_FILENAME != "")
{
    if (file_exists(INPUT_SDL2_DATABASE_FILENAME))
    {
        __input_load_sdl2_database(INPUT_SDL2_DATABASE_FILENAME);
    }
    else
    {
        __input_trace("Warning! \"", INPUT_SDL2_DATABASE_FILENAME, "\" not found in Included Files");
    }
}

//PS. Here're some SDL sources
//https://github.com/gabomdq/SDL_GameControllerDB/
//https://yachtclubgames.com/2014/03/steam-controller-support/
//https://github.com/libretro/retroarch-joypad-autoconfig/
//https://support.steampowered.com/kb_article.php?ref=5199-TOKV-4426
//http://www.linux-usb.org/usb.ids

#endregion




#region Binding Functions

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
}

#endregion



#region Utility

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

#endregion



#region Internal macros

#macro __INPUT_VERSION "3.0.0.pre003"
#macro __INPUT_DATE    "2020-08-14"

enum INPUT_SOURCE
{
    NONE,
    KEYBOARD_AND_MOUSE,
    GAMEPAD,
    __SIZE
}

#macro INPUT_NO_GAMEPAD  -1

#endregion



#region Database loading and parsing

function __input_load_sdl2_database(_filename)
{
    var _t = get_timer();
    
    __input_trace("Loading SDL2 database from \"", _filename, "\"");
    
    #region Break down the input database into a 2D array
    
    var _cell_delimiter   = ",";
    var _string_delimiter = "\"";
    
    var _buffer = buffer_load(_filename);
    var _size = buffer_get_size(_buffer) + 1;
    buffer_resize(_buffer, _size);
    
    var _cell_delimiter_ord      = ord(_cell_delimiter);
    var _string_delimiter_double = _string_delimiter + _string_delimiter;
    var _string_delimiter_ord    = ord(_string_delimiter);
    
    var _root_array = [];
    var _row_array  = undefined;
    
    var _newline     = false;
    var _read        = false;
    var _word_start  = 0;
    var _in_string   = false;
    var _string_cell = false;
    
    repeat(_size)
    {
        var _value = buffer_read(_buffer, buffer_u8);
        
        if (_value == _string_delimiter_ord)
        {
            _in_string = !_in_string;
            if (_in_string) _string_cell = true;
        }
        else
        {
            if (_value == 0)
            {
                if (_in_string) _string_cell = true;
                _in_string = false;
                
                var _prev_value = buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8);
                if ((_prev_value != _cell_delimiter_ord) && (_prev_value != 10) && (_prev_value != 13))
                {
                    _read = true;
                }
            }
            
            if (!_in_string)
            {
                if ((_value == 10) || (_value == 13))
                {
                    var _prev_value = buffer_peek(_buffer, buffer_tell(_buffer)-2, buffer_u8);
                    if ((_prev_value != 10) && (_prev_value != 13))
                    {
                        _newline = true;
                        if (_prev_value != _cell_delimiter_ord)
                        {
                            _read = true;
                        }
                        else
                        {
                            ++_word_start;
                        }
                    }
                    else
                    {
                        ++_word_start;
                    }
                }
            
                if (_read || (_value == _cell_delimiter_ord))
                {
                    _read = false;
                
                    var _tell = buffer_tell(_buffer);
                    var _old_value = buffer_peek(_buffer, _tell-1, buffer_u8);
                    buffer_poke(_buffer, _tell-1, buffer_u8, 0x00);
                    buffer_seek(_buffer, buffer_seek_start, _word_start);
                    var _string = buffer_read(_buffer, buffer_string);
                    buffer_poke(_buffer, _tell-1, buffer_u8, _old_value);
                    
                    if (_string_cell)
                    {
                        if ((string_byte_at(_string, 1) == _string_delimiter_ord)
                        &&  (string_byte_at(_string, string_byte_length(_string)) == _string_delimiter_ord))
                        {
                            _string = string_copy(_string, 2, string_length(_string)-2); //Trim off leading/trailing quote marks
                        }
                    }
                    
                    _string = string_replace_all(_string, _string_delimiter_double, _string_delimiter); //Replace double quotes with single quotes
                    
                    if (_row_array == undefined)
                    {
                        _row_array = [];
                        _root_array[@ array_length(_root_array)] = _row_array;
                    }
                    
                    _row_array[@ array_length(_row_array)] = _string;
                
                    _string_cell = false;
                    _word_start = _tell;
                }
            
                if (_newline)
                {
                    _newline = false;
                    _row_array = undefined;
                }
            }
        }
    }
    
    buffer_delete(_buffer);
    
    #endregion
    
    var _db_array             = global.__input_sdl2_database.array;
    var _db_by_vendor_product = global.__input_sdl2_database.by_vendor_product;
    var _db_by_platform       = global.__input_sdl2_database.by_platform
    
    var _y = 0;
    repeat(array_length(_root_array))
    {
        var _row_array = _root_array[_y];
        if (is_array(_row_array))
        {
            //Ignore comments
            if (string_pos("#", _row_array[0]) <= 0)
            {
                //Add this definition to the main database array
                _db_array[@ array_length(_db_array)] = _row_array;
                
                //Figure out this definition's vendor+product name is
                var _result = __input_gamepad_guid_parse(_row_array[0], false);
                var _vendor_product = _result.vendor + _result.product;
                
                //Add this definition to the "by vendor+product" struct
                var _vp_array = variable_struct_get(_db_by_vendor_product, _vendor_product);
                if (!is_array(_vp_array))
                {
                    _vp_array = [];
                    variable_struct_set(_db_by_vendor_product, _vendor_product, _vp_array);
                }
                _vp_array[@ array_length(_vp_array)] = _row_array;
                
                //Find what platform this definition is for
                //We do this backwards for the sake of efficiency
                var _platform = undefined;
                var _x = array_length(_row_array)-1;
                repeat(array_length(_row_array))
                {
                    var _lower = string_lower(_row_array[_x]);
                    if (_lower == "platform:windows" ) { _platform = os_windows; break; }
                    if (_lower == "platform:mac os x") { _platform = os_macosx;  break; }
                    if (_lower == "platform:mac"     ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:macos"   ) { _platform = os_macosx;  break; }
                    if (_lower == "platform:linux"   ) { _platform = os_linux;   break; }
                    if (_lower == "platform:ubuntu"  ) { _platform = os_linux;   break; }
                    if (_lower == "platform:android" ) { _platform = os_android; break; }
                    if (_lower == "platform:ios"     ) { _platform = os_ios;     break; }
                    if (_lower == "platform:tvos"    ) { _platform = os_tvos;    break; }
                    --_x;
                }
                
                //If we found a platform...
                if (_platform != undefined)
                {
                    //Add the OS type to the end of the definition's array
                    _row_array[@ array_length(_row_array)] = _platform;
                    
                    //Add this definition to the "by platform" struct
                    var _os_array = variable_struct_get(_db_by_platform, _platform);
                    if (!is_array(_os_array))
                    {
                        _os_array = [];
                        variable_struct_set(_db_by_platform, _platform, _os_array);
                    }
                    _os_array[@ array_length(_os_array)] = _row_array;
                }
            }
        }
        
        ++_y;
    }
    
    __input_trace(array_length(_db_array), " gamepad definitions found");
    __input_trace("Loaded in ", (get_timer() - _t)/1000, "ms");
}

#endregion