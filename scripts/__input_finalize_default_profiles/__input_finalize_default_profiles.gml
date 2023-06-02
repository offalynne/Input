function __input_finalize_default_profiles()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    _global.__default_profile_dict = __input_config_verbs();
    
    if (!is_struct(_global.__default_profile_dict))
    {
        __input_error("__input_config_verbs() must contain a struct (was ", typeof(_global.__default_profile_dict), ")\nDocumentation on __input_config_verbs() can be found offline in __input_config_verbs_and_bindings()\nOnline documentation can be found at https://jujuadams.github.io/Input");
    }
    
    if (variable_struct_names_count(_global.__default_profile_dict) <= 0)
    {
       __input_error("__input_config_verbs() must contain at least one profile");
    }
    
    //Put strict mode on, this'll cause Input to throw errors if the player does anything dumb
    _global.__strict_binding_check = true;
    
    _global.__profile_array = variable_struct_get_names(_global.__default_profile_dict);
    _global.__profile_dict  = {}; //We fill this in later..
    
    var _f = 0;
    repeat(array_length(_global.__profile_array))
    {
        var _profile_name   = _global.__profile_array[_f];
        var _profile_struct = _global.__default_profile_dict[$ _profile_name];
        
        if (os_browser != browser_not_a_browser)
        {
            if (is_method(_profile_struct))
            {
                array_delete(_global.__profile_array, _f, 1);
                continue;
            }
        }
        
        if (!is_struct(_profile_struct))
        {
            __input_error("Profile \"", _profile_name, "\" definition must be a struct (was ", typeof(_profile_struct), ")");
        }
        
        //Copy the default profile reference across to the volatile dictionary
        _global.__profile_dict[$ _profile_name] = _profile_struct;
        
        _global.__default_player.__profile_ensure(_profile_name);
        
        var _profile_verb_names = variable_struct_get_names(_profile_struct);
        var _v = 0;
        repeat(array_length(_profile_verb_names))
        {
            var _verb_name = _profile_verb_names[_v];
            
            if (!variable_struct_exists(_global.__basic_verb_dict, _verb_name))
            {
                array_push(_global.__basic_verb_array, _verb_name);
                _global.__basic_verb_dict[$ _verb_name] = true;
                
                array_push(_global.__all_verb_array, _verb_name);
                _global.__all_verb_dict[$ _verb_name] = true;
            }
            
            var _verb_data = _profile_struct[$ _verb_name];
            if (!is_array(_verb_data)) _verb_data = [_verb_data];
            
            if (array_length(_verb_data) > INPUT_MAX_ALTERNATE_BINDINGS)
            {
                __input_error("Verb \"", _verb_name, "\" for default profile \"", _profile_name, "\" has too many alternate bindings (", array_length(_verb_data), " versus max ", INPUT_MAX_ALTERNATE_BINDINGS, ")\nPlease increase INPUT_MAX_ALTERNATE_BINDINGS if you'd like to use more alternate bindings");
            }
            
            _global.__default_player.__verb_ensure(_profile_name, _verb_name);
            
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
                        case __INPUT_SOURCE.KEYBOARD: _global.__any_keyboard_binding_defined = true; break;
                        case __INPUT_SOURCE.MOUSE:    _global.__any_mouse_binding_defined    = true; break;
                        case __INPUT_SOURCE.TOUCH:    _global.__any_touch_binding_defined    = true; break;
                        case __INPUT_SOURCE.GAMEPAD:  _global.__any_gamepad_binding_defined  = true; break;
                    }
                }
                
                _global.__default_player.__binding_set(_profile_name, _verb_name, _a, _binding);
                
                ++_a;
            }
            
            ++_v;
        }
        
        ++_f;
    }
    
    if (!__INPUT_SILENT)
    {
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_KEYBOARD   )) __input_trace("Warning! Default profile for keyboard \"",    INPUT_AUTO_PROFILE_FOR_KEYBOARD,    "\" has not been defined in __input_config_verbs()");
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_MOUSE      )) __input_trace("Warning! Default profile for mouse \"",       INPUT_AUTO_PROFILE_FOR_MOUSE,       "\" has not been defined in __input_config_verbs()");
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_GAMEPAD    )) __input_trace("Warning! Default profile for gamepad \"",     INPUT_AUTO_PROFILE_FOR_GAMEPAD,     "\" has not been defined in __input_config_verbs()");
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_MIXED      )) __input_trace("Warning! Default profile for mixed \"",       INPUT_AUTO_PROFILE_FOR_MIXED,       "\" has not been defined in __input_config_verbs()");
        if (!variable_struct_exists(_global.__profile_dict, INPUT_AUTO_PROFILE_FOR_MULTIDEVICE)) __input_trace("Warning! Default profile for multidevice \"", INPUT_AUTO_PROFILE_FOR_MULTIDEVICE, "\" has not been defined in __input_config_verbs()");
    }
    
    _global.__cursor_verbs_valid = true;
    if (!variable_struct_exists(_global.__basic_verb_dict, INPUT_CURSOR_VERB_UP   )) { if (!__INPUT_SILENT) __input_trace("Warning! Default cursor up verb \"",    INPUT_CURSOR_VERB_UP,    "\" has not been defined for any profile"); _global.__cursor_verbs_valid = false; }
    if (!variable_struct_exists(_global.__basic_verb_dict, INPUT_CURSOR_VERB_DOWN )) { if (!__INPUT_SILENT) __input_trace("Warning! Default cursor down verb \"",  INPUT_CURSOR_VERB_DOWN,  "\" has not been defined for any profile"); _global.__cursor_verbs_valid = false; }
    if (!variable_struct_exists(_global.__basic_verb_dict, INPUT_CURSOR_VERB_LEFT )) { if (!__INPUT_SILENT) __input_trace("Warning! Default cursor left verb \"",  INPUT_CURSOR_VERB_LEFT,  "\" has not been defined for any profile"); _global.__cursor_verbs_valid = false; }
    if (!variable_struct_exists(_global.__basic_verb_dict, INPUT_CURSOR_VERB_RIGHT)) { if (!__INPUT_SILENT) __input_trace("Warning! Default cursor right verb \"", INPUT_CURSOR_VERB_RIGHT, "\" has not been defined for any profile"); _global.__cursor_verbs_valid = false; }
    
    //Fix any missing verb definitions for default profiles
    var _f = 0;
    repeat(array_length(_global.__profile_array))
    {
        var _profile_name   = _global.__profile_array[_f];
        var _profile_struct = _global.__default_profile_dict[$ _profile_name];
        
        var _p = 0;
        repeat(INPUT_MAX_PLAYERS)
        {
            _global.__players[_p].__profile_ensure(_profile_name);
            ++_p;
        }
        
        var _v = 0;
        repeat(array_length(_global.__basic_verb_array))
        {
            var _verb_name = _global.__basic_verb_array[_v];
            
            if (!variable_struct_exists(_profile_struct, _verb_name))
            {
                if (INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES)
                {
                    if (!__INPUT_SILENT) __input_trace("Warning! Default profile \"", _profile_name, "\" does not include a definition for basic verb \"", _verb_name, "\"");
                }
                else
                {
                    __input_error("Default profile \"", _profile_name, "\" does not include a definition for basic verb \"", _verb_name, "\"\n(To ignore this error set INPUT_ALLOW_ASSYMMETRIC_DEFAULT_PROFILES to <true>)");
                }
                
                _global.__default_player.__verb_ensure(_profile_name, _verb_name);
            }
            
            var _p = 0;
            repeat(INPUT_MAX_PLAYERS)
            {
                _global.__players[_p].__verb_ensure(_profile_name, _verb_name);
                ++_p;
            }
            
            ++_v;
        }
        
        ++_f;
    }
    
    //Make sure every player has a copy of the default profiles
    input_system_reset();
    
    //And turn strict checks off!
    _global.__strict_binding_check = false;
}
