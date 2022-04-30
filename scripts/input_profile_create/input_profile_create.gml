/// @param profileName
/// @param [keyboardProfile=false]
/// @param [mouseProfile=false]
/// @param [gamepadProfile=false]
/// @param [mixedProfile=false]

function input_profile_create(_profile_name, _keyboard_auto_profile = false, _mouse_auto_profile = false, _gamepad_auto_profile = false, _mixed_auto_profile = false)
{
    if (variable_struct_exists(global.__input_profile_dict, _profile_name))
    {
        __input_error("Profile \"", _profile_name, "\" has already been created");
    }
    
    global.__input_profile_dict[$ _profile_name] = true;
    array_push(global.__input_profile_array, _profile_name);
    
    if (global.__input_auto_profile_first == undefined) global.__input_auto_profile_first = _profile_name;
    
    if (_keyboard_auto_profile)
    {
        if (global.__input_auto_profile_keyboard == undefined)
        {
            global.__input_auto_profile_keyboard = _profile_name;
        }
        else
        {
            __input_error("Keyboard auto profile already defined (as profile \"", global.__input_auto_profile_keyboard, "\"");
        }
    }
    
    if (_mouse_auto_profile)
    {
        if (global.__input_auto_profile_mouse == undefined)
        {
            global.__input_auto_profile_mouse = _profile_name;
        }
        else
        {
            __input_error("Mouse auto profile already defined (as profile \"", global.__input_auto_profile_mouse, "\"");
        }
    }
    
    if (_gamepad_auto_profile)
    {
        if (global.__input_auto_profile_gamepad == undefined)
        {
            global.__input_auto_profile_gamepad = _profile_name;
        }
        else
        {
            __input_error("Gamepad auto profile already defined (as profile \"", global.__input_auto_profile_gamepad, "\"");
        }
    }
    
    if (_mixed_auto_profile)
    {
        if (global.__input_auto_profile_mixed == undefined)
        {
            global.__input_auto_profile_mixed = _profile_name;
        }
        else
        {
            __input_error("Mixed device auto profile already defined (as profile \"", global.__input_auto_profile_mixed, "\"");
        }
    }
        
    //Ensure profile for all players
    global.__input_default_player.__ensure_profile(_profile_name);
    
    var _p = 0;
    repeat(INPUT_MAX_PLAYERS)
    {
        global.__input_players[_p].__ensure_profile(_profile_name);
        ++_p;
    }
}