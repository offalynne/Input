/// @param index
function __input_class_gamepad(_index) constructor
{
    index           = _index;
    description     = gamepad_get_description(_index);
    guid            = gamepad_get_guid(_index);
    xinput          = undefined;
    raw_type        = undefined;
    simple_type     = undefined;
    sdl2_definition = undefined;
    guessed_type    = false;
    blacklisted     = false;
    scale_trigger   = false;
    
    vendor  = undefined;
    product = undefined;
    
    custom_mapping      = false;
    mac_cleared_mapping = false;
    
    button_count = undefined;
    axis_count   = undefined;
    hat_count    = undefined;
    
    __vibration_support = false;
    __vibration_left    = 0;
    __vibration_right   = 0;
    __vibration_received_this_frame = false;
    
    mapping_gm_to_raw = {};
    mapping_raw_to_gm = {};
    mapping_array     = [];
    
    __connection_time = current_time;
    __scan_start_time = __connection_time + 250; //Give GM some space before allowing gamepad mappings to return values
    
    discover();
    
    
    
    static discover = function()
    {
        //Discard deadzone, we use axis thresholds
        gamepad_set_axis_deadzone(index, 0);
        
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
        
        __input_gamepad_set_vid_pid();
        __input_gamepad_set_description();
        __input_gamepad_find_in_sdl2_database();
        __input_gamepad_set_type();
        __input_gamepad_set_blacklist();
        __input_gamepad_set_mapping();
        
        __vibration_support = global.__input_vibration_allowed_on_platform && ((os_type != os_windows) || xinput);        
        if (__vibration_support)
        {
            if (os_type == os_ps5)
            {
                ps5_gamepad_set_vibration_mode(index, ps5_gamepad_vibration_mode_compatible);
            }
        
            gamepad_set_vibration(index, 0, 0);
        }
        
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
    static get_delta = function(_gm)
    {
        if (!custom_mapping) return get_value(_gm);
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.__value_delta;
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
    
    static tick = function(_clear = false)
    {
        //Recalibrate XInput triggers
        if (scale_trigger && ((gamepad_axis_value(index, __XINPUT_AXIS_LT) > 0.25) || (gamepad_axis_value(index, __XINPUT_AXIS_RT) > 0.25)))
        {
            //Trigger value exceeds limited range, set range to "normal" scale (0 to 255/256)
            with mapping_gm_to_raw[$ gp_shoulderlb] scale = 255;
            with mapping_gm_to_raw[$ gp_shoulderrb] scale = 255;
            scale_trigger = false;
            __input_trace("Recalibrated XInput trigger scale for gamepad ", index);
        }
        
        var _scan = (current_time > __scan_start_time);
        var _gamepad = index;
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            with(mapping_array[_i]) tick(_gamepad, _clear, _scan);
            ++_i;
        }
        
        if (__vibration_support)
        {
            if (__vibration_received_this_frame && input_window_has_focus())
            {
                if (os_type == os_switch)
                {
                    var _lowStrength  = INPUT_VIBRATION_SWITCH_OS_STRENGTH*__vibration_left;
                    var _highStrength = INPUT_VIBRATION_SWITCH_OS_STRENGTH*__vibration_right;
                    
                    if ((raw_type == "SwitchJoyConLeft") || (raw_type == "SwitchJoyConRight"))
                    {
                        //Documentation said to use switch_controller_motor_single for these two controller types but I'll be damned if I can feel any difference!
                        switch_controller_vibrate_hd(index, switch_controller_motor_single, _highStrength, 250, _lowStrength, 160);
                    }
                    else
                    {
                        switch_controller_vibrate_hd(index, switch_controller_motor_left,  _highStrength, 250, _lowStrength, 160);
                        switch_controller_vibrate_hd(index, switch_controller_motor_right, _highStrength, 250, _lowStrength, 160);
                    }
                }
                else
                {
                    gamepad_set_vibration(index, __vibration_left, __vibration_right);
                }
            }
            else
            {
                gamepad_set_vibration(index, 0, 0);
            }
            
            __vibration_received_this_frame = false;
        }
    }
    
    static __vibration_set = function(_left, _right)
    {
        __vibration_left  = _left;
        __vibration_right = _right;
        
        __vibration_received_this_frame = true;
    }
}
