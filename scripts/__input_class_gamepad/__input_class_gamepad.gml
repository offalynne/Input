/// @param index
function __input_class_gamepad(_index) constructor
{
    index             = _index;
    description       = gamepad_get_description(_index);
    guid              = gamepad_get_guid(_index);
    xinput            = undefined;
    raw_type          = undefined;
    simple_type       = undefined;
    sdl2_definition   = undefined;
    guessed_type      = false;
    blacklisted       = false;
    haptic_support    = false;
    
    vendor  = undefined;
    product = undefined;
    
    custom_mapping      = false;
    mac_cleared_mapping = false;
    
    button_count = undefined;
    axis_count   = undefined;
    hat_count    = undefined;
    
    __haptic_step           = 0;
    __haptic_steps_total    = 0;
    __haptic_strength_left  = 0;
    __haptic_strength_right = 0;
    __haptic_curve          = undefined;    
    
    mapping_gm_to_raw = {};
    mapping_raw_to_gm = {};
    mapping_array     = [];
    
    discover();
    
    static discover = function()
    {
        if (custom_mapping)
        {
            custom_mapping = false;
            
            __input_trace("Warning! Resetting Input's mapping for gamepad ", index);
            
            mapping_gm_to_raw = {};
            mapping_raw_to_gm = {};
            mapping_array     = [];
        }
        
        button_count = gamepad_button_count(index);
        axis_count   = gamepad_axis_count(index);
        hat_count    = gamepad_hat_count(index);
        
        haptic_support = __INPUT_GAMEPAD_VIBRATION_SUPPORT && (os_type != os_windows || index < 4);
        
        __input_gamepad_set_vid_pid();
        __input_gamepad_set_description();
        __input_gamepad_find_in_sdl2_database();
        __input_gamepad_set_type();
        __input_gamepad_set_blacklist();
        __input_gamepad_set_mapping();
        
        __input_trace("Gamepad ", index, " discovered, type = \"", simple_type, "\" (", raw_type, ", guessed=", guessed_type, "), description = \"", description, "\" (vendor=", vendor, ", product=", product, ")");
    }
    
    /// @param GMconstant
    static get_held = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check(index, _gm);
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.held;
    }
    
    /// @param GMconstant
    static get_pressed = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_pressed(index, _gm);
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.press;
    }
    
    /// @param GMconstant
    static get_released = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_released(index, _gm);
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.release;
    }
    
    /// @param GMconstant
    static get_value = function(_gm)
    {
        if (!custom_mapping)
        {
            if ((_gm == gp_axislh) || (_gm == gp_axislv) || (_gm == gp_axisrh) || (_gm == gp_axisrv))
            {
                return gamepad_axis_value(index, _gm);
            }
            else
            {
                return gamepad_button_check(index, _gm);
            }
        }
        
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.value;
    }
    
    /// @param GMconstant
    static is_axis = function(_gm)
    {
        if (!custom_mapping)
        {
            if ((_gm == gp_shoulderlb) || (_gm == gp_shoulderrb))
            {
                //XInput and platforms with analogue triggers
                return (xinput || __INPUT_ON_XBOX || __INPUT_ON_PS || (__INPUT_ON_APPLE && __INPUT_ON_MOBILE));
            }
            
            //Otherwise return true only for the thumbsticks
            return ((_gm == gp_axislh) || (_gm == gp_axislv) || (_gm == gp_axisrh) || (_gm == gp_axisrv));
        }
        
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return (_mapping.type == __INPUT_MAPPING.AXIS);
    }
    
    /// @param GMconstant
    /// @param rawIndex
    /// @param rawMappingType
    /// @param SDLname
    static set_mapping = function(_gm, _raw_index, _mapping_type, _sdl_name)
    {
        if (!custom_mapping)
        {
            custom_mapping = true;
            
            if (__INPUT_SDL2_SUPPORT)
            {
                //As of 2020-08-17, GameMaker has weird in-build remapping rules for gamepad on MacOS
                if (os_type == os_macosx)
                {
                    if ((gamepad_get_mapping(index) != "") && (gamepad_get_mapping(index) != "no mapping"))
                    {
                        __input_trace("Gamepad ", index, " has a custom mapping, clearing GameMaker's native mapping string");
                        mac_cleared_mapping = true;
                    }
                
                    //Additionally, gamepad_remove_mapping() doesn't seem to work. Setting the SDL string to something mostly blank does work though
                    gamepad_test_mapping(index, gamepad_get_guid(index) + "," + gamepad_get_description(index) + ",");
                }
                else
                {
                    __input_trace("Gamepad ", index, " has a custom mapping, clearing GameMaker's native mapping string");
                    gamepad_remove_mapping(index);
                }
            }
            else if (!__INPUT_ON_CONSOLE)
            {
                __input_trace("Gamepad ", index, " cannot remove GameMaker's native mapping string, this feature is not supported by Input on this platform");
            }
        }
        
        //Correct for weird input index offset on MacOS if the gamepad already had a native GameMaker mapping
        if (mac_cleared_mapping && (os_type == os_macosx))
        {
            if (_mapping_type == __INPUT_MAPPING.AXIS  ) _raw_index +=  6;
            if (_mapping_type == __INPUT_MAPPING.BUTTON) _raw_index += 17;
        }
        
        //Create a new mapping. It holds button state and definition information
        var _mapping = new __input_class_gamepad_mapping(_gm, _raw_index, _mapping_type, _sdl_name);
        
        mapping_gm_to_raw[$ _gm] = _mapping;
        if (_raw_index != undefined) mapping_raw_to_gm[$ _raw_index] = _mapping; //_raw_index can be undefined when setting up hat-on-axis
        array_push(mapping_array, _mapping);
        
        return _mapping;
    }
    
    static tick = function()
    {
        var _gamepad = index;
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            with(mapping_array[_i]) tick(_gamepad);
            ++_i;
        }        
        
        if (haptic_support)
        {
            __haptic_tick();
        }
    }
    
    /// @param   {Real} _lstrength 0-1
    /// @param   {Real} _rstrength 0-1
    /// @param   {Real} _time in frames
    static __haptic_vibrate = function(_strengthl, _strengthr, _frames)
    {
        __haptic_strength_left  = clamp(_strengthl, 0, 1);
        __haptic_strength_right = clamp(_strengthr, 0, 1);
        
        __haptic_step = 0;
        __haptic_steps_total = (__haptic_strength_left + __haptic_strength_right) > 0 ? _frames : 0;
        
        __haptic_curve = undefined;
    }
    /// @param {Asset.AnimCurve} _curve
    /// @param {Real} _frames
    static __haptic_vibrate_curve = function(_curve, _frames)
    {
        __haptic_vibrate(0, 0, 0);
        if ((_frames) > 0 && (_curve != undefined) || animcurve_exists(_curve))
        {
            __haptic_curve       = _curve;
            __haptic_steps_total = _frames;
        }
        
    }
    
    static __haptic_tick = function()
    {        
        if ((__haptic_steps_total == 0) || (__haptic_step >= __haptic_steps_total))
        {
            gamepad_set_vibration(index, 0, 0);
            __haptic_vibrate(0, 0, 0);
        }
        else
        {
            if (__haptic_curve != undefined)
            {
                var _struct = animcurve_get(__haptic_curve);
            
                __haptic_strength_left  = animcurve_channel_evaluate(_struct.channels[0], __haptic_step/__haptic_steps_total);
                __haptic_strength_right = animcurve_channel_evaluate(_struct.channels[((array_length(_struct.channels) > 1)? 1 : 0)], __haptic_step/__haptic_steps_total);
            }

            if (window_has_focus() && !os_is_paused())
            {
                gamepad_set_vibration(index, __haptic_strength_left, __haptic_strength_right);
            }
            else
            {
                gamepad_set_vibration(index, 0, 0);
            }

            if (INPUT_TIMER_MILLISECONDS)
            {
                __haptic_step += __input_get_time() - __input_get_previous_time();
            }
            else
            {
                __haptic_step++;
            }
        }
    }
}
