#macro INPUT_DEFAULT_PROFILES __input_initialize(); for(var _i = 0; _i < 2; _i++) if (_i == 1) __input_finalize_default_profiles() else if (is_struct(global.__input_default_profile_dict)) break else global.__input_default_profile_dict

function __input_finalize_default_profiles()
{
    if (global.__input_initialization_phase != "__input_finalize_default_profiles") return;
    
    if (!is_struct(global.__input_default_profile_dict))
    {
        __input_error("INPUT_DEFAULT_PROFILES must contain a struct (was ", typeof(global.__input_default_profile_dict), ")\nDocumentation on INPUT_DEFAULT_PROFILES can be found offline in __input_config_profiles_and_default_bindings()\nOnline documentation can be found at https://jujuadams.github.io/Input");
    }
    
    if (variable_struct_names_count(global.__input_default_profile_dict) <= 0)
    {
       __input_error("INPUT_DEFAULT_PROFILES must contain at least one profile");
    }
    
    //Put strict mode on, this'll cause Input to throw errors if the player does anything dumb
    global.__input_strict_binding_check = true;
    
    global.__input_profile_array = variable_struct_get_names(global.__input_default_profile_dict);
    global.__input_profile_dict  = {}; //We fill this in later..
    
    var _f = 0;
    repeat(array_length(global.__input_profile_array))
    {
        var _profile_name   = global.__input_profile_array[_f];
        var _profile_struct = global.__input_default_profile_dict[$ _profile_name];
        
        if (os_browser != browser_not_a_browser)
        {
            if (is_method(_profile_struct))
            {
                array_delete(global.__input_profile_array, _f, 1);
                continue;
            }
        }
        
        if (!is_struct(_profile_struct))
        {
            __input_error("Profile \"", _profile_name, "\" definition must be a struct (was ", typeof(_profile_struct), ")");
        }
        
        //Copy the default profile reference across to the volatile dictionary
        global.__input_profile_dict[$ _profile_name] = _profile_struct;
        
        global.__input_default_player.__profile_ensure(_profile_name);
        
        var _profile_verb_names = variable_struct_get_names(_profile_struct);
        var _v = 0;
        repeat(array_length(_profile_verb_names))
        {
            var _verb_name = _profile_verb_names[_v];
            
            if (!variable_struct_exists(global.__input_basic_verb_dict, _verb_name))
            {
                array_push(global.__input_basic_verb_array, _verb_name);
                global.__input_basic_verb_dict[$ _verb_name] = true;
                
                array_push(global.__input_all_verb_array, _verb_name);
                global.__input_all_verb_dict[$ _verb_name] = true;
            }
            
            var _verb_data = _profile_struct[$ _verb_name];
            if (!is_array(_verb_data)) _verb_data = [_verb_data];
            
            if (array_length(_verb_data) > INPUT_MAX_ALTERNATE_BINDINGS)
            {
                __input_error("Verb \"", _verb_name, "\" for default profile \"", _profile_name, "\" has too many alternate bindings (", array_length(_verb_data), " versus max ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nPlease increase INPUT_MAX_ALTERNATE_BINDINGS if you'd like to use more alternate bindings");
            }
            
            global.__input_default_player.__verb_ensure(_profile_name, _verb_name);
            
            var _a = 0;
            repeat(array_length(_verb_data))
            {
                var _binding = _verb_data[_a];
                
                if (_binding == undefined)
                {
                    _binding = input_binding_empty();
                }
                else if (!input_value_is_binding(_binding))
                {
                    __input_error("Binding for profile \"", _profile_name, "\", verb \"", _verb_name, "\", alternate ", _a, " is not a binding\nPlease use one of the input_binding_*() functions to create bindings");
                }
                else
                {
                    switch(_binding.__get_source_type())
                    {
                        case __INPUT_SOURCE.KEYBOARD: global.__input_any_keyboard_binding_defined = true; break;
                        case __INPUT_SOURCE.MOUSE:    global.__input_any_mouse_binding_defined    = true; break;
                        case __INPUT_SOURCE.GAMEPAD:  global.__input_any_gamepad_binding_defined  = true; break;
                    }
                }
                
                if (global.__input_swap_ab)
                {
                    if (_binding.type == __INPUT_BINDING_GAMEPAD_BUTTON)
                    {
                        if (_binding.value == gp_face1)
                        {
                            __input_trace("Swapping A/X -> B/O for profile \"", _profile_name, "\", verb \"", _verb_name, "\", alternate ", _a);
                            _binding.value = gp_face2;
                        }
                        else if (_binding.value == gp_face2)
                        {
                            __input_trace("Swapping B/O -> A/X for profile \"", _profile_name, "\", verb \"", _verb_name, "\", alternate ", _a);
                            _binding.value = gp_face1;
                        }
                    }
                }
                
                global.__input_default_player.__binding_set(_profile_name, _verb_name, _a, _binding);
                
                ++_a;
            }
            
            ++_v;
        }
        
        ++_f;
    }
    
    if (!variable_struct_exists(global.__input_profile_dict, INPUT_AUTO_PROFILE_FOR_KEYBOARD   )) __input_trace("Warning! Default profile for keyboard \"",    INPUT_AUTO_PROFILE_FOR_KEYBOARD,    "\" has not been defined in INPUT_DEFAULT_PROFILES");
    if (!variable_struct_exists(global.__input_profile_dict, INPUT_AUTO_PROFILE_FOR_MOUSE      )) __input_trace("Warning! Default profile for mouse \"",       INPUT_AUTO_PROFILE_FOR_MOUSE,       "\" has not been defined in INPUT_DEFAULT_PROFILES");
    if (!variable_struct_exists(global.__input_profile_dict, INPUT_AUTO_PROFILE_FOR_GAMEPAD    )) __input_trace("Warning! Default profile for gamepad \"",     INPUT_AUTO_PROFILE_FOR_GAMEPAD,     "\" has not been defined in INPUT_DEFAULT_PROFILES");
    if (!variable_struct_exists(global.__input_profile_dict, INPUT_AUTO_PROFILE_FOR_MIXED      )) __input_trace("Warning! Default profile for mixed \"",       INPUT_AUTO_PROFILE_FOR_MIXED,       "\" has not been defined in INPUT_DEFAULT_PROFILES");
    if (!variable_struct_exists(global.__input_profile_dict, INPUT_AUTO_PROFILE_FOR_MULTIDEVICE)) __input_trace("Warning! Default profile for multidevice \"", INPUT_AUTO_PROFILE_FOR_MULTIDEVICE, "\" has not been defined in INPUT_DEFAULT_PROFILES");
    
    global.__input_cursor_verbs_valid = true;
    if (!variable_struct_exists(global.__input_basic_verb_dict, INPUT_CURSOR_VERB_UP   )) { __input_trace("Warning! Default cursor up verb \"",    INPUT_CURSOR_VERB_UP,    "\" has not been defined for any profile"); global.__input_cursor_verbs_valid = false; }
    if (!variable_struct_exists(global.__input_basic_verb_dict, INPUT_CURSOR_VERB_DOWN )) { __input_trace("Warning! Default cursor down verb \"",  INPUT_CURSOR_VERB_DOWN,  "\" has not been defined for any profile"); global.__input_cursor_verbs_valid = false; }
    if (!variable_struct_exists(global.__input_basic_verb_dict, INPUT_CURSOR_VERB_LEFT )) { __input_trace("Warning! Default cursor left verb \"",  INPUT_CURSOR_VERB_LEFT,  "\" has not been defined for any profile"); global.__input_cursor_verbs_valid = false; }
    if (!variable_struct_exists(global.__input_basic_verb_dict, INPUT_CURSOR_VERB_RIGHT)) { __input_trace("Warning! Default cursor right verb \"", INPUT_CURSOR_VERB_RIGHT, "\" has not been defined for any profile"); global.__input_cursor_verbs_valid = false; }
    
    //Fix any missing verb definitions for default profiles
    var _f = 0;
    repeat(array_length(global.__input_profile_array))
    {
        var _profile_name   = global.__input_profile_array[_f];
        var _profile_struct = global.__input_default_profile_dict[$ _profile_name];
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            global.__input_players[_p].__profile_ensure(_profile_name);
            ++_p;
        }
        
        var _v = 0;
        repeat(array_length(global.__input_basic_verb_array))
        {
            var _verb_name = global.__input_basic_verb_array[_v];
            
            if (!variable_struct_exists(_profile_struct, _verb_name))
            {
                if (INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES)
                {
                    __input_trace("Warning! Default profile \"", _profile_name, "\" does not include a definition for basic verb \"", _verb_name, "\"");
                }
                else
                {
                    __input_error("Default profile \"", _profile_name, "\" does not include a definition for basic verb \"", _verb_name, "\"\n(To ignore this error set INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES to <true>)");
                }
                
                global.__input_default_player.__verb_ensure(_profile_name, _verb_name);
            }
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                global.__input_players[_p].__verb_ensure(_profile_name, _verb_name);
                ++_p;
            }
            
            ++_v;
        }
        
        ++_f;
    }
    
    //Make sure every player has a copy of the default profiles
    input_system_reset();
    
    //And turn strict checks off!
    global.__input_strict_binding_check = false;
}
