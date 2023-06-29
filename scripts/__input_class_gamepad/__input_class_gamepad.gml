/// @param index
function __input_class_gamepad(_index) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
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
    test_trigger    = false;
    
    vendor  = undefined;
    product = undefined;
    
    custom_mapping      = false;
    mac_cleared_mapping = false;
    
    button_count = undefined;
    axis_count   = undefined;
    hat_count    = undefined;
    
    __steam_handle_index = undefined;
    __steam_handle       = undefined;
    
    __vibration_support = false;
    __vibration_scale   = 1;
    __vibration_left    = 0;
    __vibration_right   = 0;
    __vibration_received_this_frame = false;
    
    __led_pattern = undefined;
    __motion      = undefined;
    
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
            
            if (!__INPUT_SILENT) __input_trace("Warning! Resetting Input's mapping for gamepad ", index);
            
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
        
        virtual_set();
        led_set();
        swap_ab();
        
        __vibration_support = __global.__vibration_allowed && (xinput || !__INPUT_ON_WINDOWS);        
        if (__vibration_support)
        {
            if (os_type == os_ps5)
            {
                ps5_gamepad_set_vibration_mode(index, ps5_gamepad_vibration_mode_compatible);
            }            
            else
            {
                if ((__INPUT_ON_WINDOWS || __INPUT_ON_SWITCH) && __input_string_contains(raw_type, "JoyCon", "SwitchHandheld"))
                {
                    __vibration_scale = INPUT_VIBRATION_JOYCON_STRENGTH;
                }
                else
                {
                    __vibration_scale = 1;
                }
            }
        
            gamepad_set_vibration(index, 0, 0);
        }

        if (__global.__gamepad_motion_support) __motion = new __input_class_gamepad_motion(index);
        if (!__INPUT_SILENT)__input_trace("Gamepad ", index, " discovered, type = \"", simple_type, "\" (", raw_type, ", guessed=", guessed_type, "), description = \"", description, "\" (vendor=", vendor, ", product=", product, ")");
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
                return (!__INPUT_ON_SWITCH);
            }
            else
            {
                return ((_gm == gp_axislh) || (_gm == gp_axislv) || (_gm == gp_axisrh) || (_gm == gp_axisrv));
            }
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
                if (__INPUT_ON_MACOS)
                {
                    if ((gamepad_get_mapping(index) != "") && (gamepad_get_mapping(index) != "no mapping"))
                    {
                        if (!__INPUT_SILENT) __input_trace("Gamepad ", index, " has a custom mapping, clearing GameMaker's native mapping string");
                        mac_cleared_mapping = true;
                    }
                
                    //Additionally, gamepad_remove_mapping() doesn't seem to work. Setting the SDL string to something mostly blank does work though
                    gamepad_test_mapping(index, gamepad_get_guid(index) + "," + gamepad_get_description(index) + ",");
                }
                else
                {
                    if (!__INPUT_SILENT) __input_trace("Gamepad ", index, " has a custom mapping, clearing GameMaker's native mapping string");
                    gamepad_remove_mapping(index);
                }
            }
            else if (!INPUT_ON_CONSOLE)
            {
                __input_trace("Gamepad ", index, " cannot remove GameMaker's native mapping string, this feature is not supported by Input on this platform");
            }
        }
        
        //Correct for weird input index offset on MacOS if the gamepad already had a native GameMaker mapping
        if (mac_cleared_mapping && __INPUT_ON_MACOS)
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
        //Apply mapping settings that cannot be initially evaluated
        if (__INPUT_ON_WINDOWS)
        {        
            //Recalibrate XInput triggers
            if (scale_trigger 
            && ((gamepad_axis_value(index, __XINPUT_AXIS_LT) > 0.25) 
             || (gamepad_axis_value(index, __XINPUT_AXIS_RT) > 0.25)))
            {
                //Trigger value exceeds limited range, set range to "normal" scale (0 to 255/256)
                with mapping_gm_to_raw[$ gp_shoulderlb] scale = 255;
                with mapping_gm_to_raw[$ gp_shoulderrb] scale = 255;
                scale_trigger = false;
                if (!__INPUT_SILENT) __input_trace("Recalibrated XInput trigger scale for gamepad ", index);
            }
        
            //Set up alternate Stadia mapping
            if (test_trigger 
            && ((gamepad_axis_value(index, 1) != gamepad_axis_value(index, 2)) 
             || (gamepad_axis_value(index, 4) != gamepad_axis_value(index, 5))))
            {
                //Analogue trigger value found, reset right thumbstick and trigger mappings
                set_mapping(gp_axisrh,     2, __INPUT_MAPPING.AXIS, "rightx");
                set_mapping(gp_axisrv,     3, __INPUT_MAPPING.AXIS, "righty");            
                set_mapping(gp_shoulderrb, 4, __INPUT_MAPPING.AXIS, "righttrigger").extended_range = true;
                set_mapping(gp_shoulderlb, 5, __INPUT_MAPPING.AXIS, "lefttrigger" ).extended_range = true;
                test_trigger = false;                
                if (!__INPUT_SILENT) __input_trace("Setting Stadia controller to analogue trigger mapping for gamepad ", index);
            }
        }
        
        var _scan = (current_time > __scan_start_time);
        var _gamepad = index;
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            with(mapping_array[_i]) tick(_gamepad, _scan);
            ++_i;
        }
        
        if (__vibration_support)
        {
            if (__vibration_received_this_frame && input_window_has_focus())
            {
                var _vibration_low  = __vibration_scale * __vibration_left;
                var _vibration_high = __vibration_scale * __vibration_right;
                
                if (__INPUT_ON_SWITCH)
                {
                    if ((raw_type == "SwitchJoyConLeft") || (raw_type == "SwitchJoyConRight"))
                    {
                        //Documentation said to use switch_controller_motor_single for these two controller types but I'll be damned if I can feel any difference!
                        switch_controller_vibrate_hd(index, switch_controller_motor_single, _vibration_high, 250, _vibration_low, 160);
                    }
                    else
                    {
                        switch_controller_vibrate_hd(index, switch_controller_motor_left,  _vibration_high, 250, _vibration_low, 160);
                        switch_controller_vibrate_hd(index, switch_controller_motor_right, _vibration_high, 250, _vibration_low, 160);
                    }
                }
                else
                {
                    gamepad_set_vibration(index, _vibration_low, _vibration_high);
                }
            }
            else
            {
                gamepad_set_vibration(index, 0, 0);
            }
            
            __vibration_received_this_frame = false;
        }
    }
    
    static swap_ab = function()
    {
        if (__input_gamepad_type_swap_ab(simple_type) && is_struct(mapping_gm_to_raw[$ string(gp_face1)]) && is_struct(mapping_gm_to_raw[$ string(gp_face2)]))
        {
            if (__INPUT_DEBUG) __input_trace("  (Swapping A and B)");
            var _a_mapping = mapping_gm_to_raw[$ string(gp_face1)].raw;
            set_mapping(gp_face1, mapping_gm_to_raw[$ string(gp_face2)].raw, __INPUT_MAPPING.BUTTON, "a");
            set_mapping(gp_face2, _a_mapping, __INPUT_MAPPING.BUTTON, "b");
        }
    }
    
    static virtual_set = function()
    {
        if not (__global.__using_steamworks) return;
    
        var _gamepad_is_virtual = (__INPUT_ON_WINDOWS && xinput);
        var _slot = index;
        if (__INPUT_ON_LINUX)
        {
            _gamepad_handle_index = -1;
            _gamepad_is_virtual = false;

            var _i = 0;
            repeat(index + 1)
            {
                if ((gamepad_get_description(_i) == "Valve Streaming Gamepad") || __input_string_contains(gamepad_get_guid(_i), "03000000de280000fc11", "03000000de280000ff11"))
                {
                    _gamepad_handle_index++;
                    _gamepad_is_virtual = true;
                }
                ++_i;
            }

            _slot = _gamepad_handle_index;
        }

        __steam_handle = steam_input_get_controller_for_gamepad_index(_slot);
        if not (_gamepad_is_virtual && is_numeric(__steam_handle) && (__steam_handle > 0))
        {
            __steam_handle = undefined;
        }
        else
        {
            __steam_handle_index = steam_input_get_gamepad_index_for_controller(__steam_handle);
            if (__steam_handle_index == -1) return;
                
            var _handle_type = steam_input_get_input_type_for_handle(__steam_handle);
            if not (is_numeric(_handle_type) && (_handle_type >= 0)) return;

            var _description = __global.__steam_type_to_name[$ _handle_type];
            if (_description == undefined) return;
        
            var _raw_type = __global.__steam_type_to_raw[$ _handle_type];
            if (_raw_type == undefined) return;
        
            var _simple_type = __global.__simple_type_lookup[$ _raw_type];
            if (_simple_type == undefined) return;

            description = _description;
            raw_type    = _raw_type;
            simple_type = _simple_type;
        }
    }
    
    static led_set = function()
    {
        __led_pattern = undefined;
        
        //Platform is unsupported, or lacks Steam Input handle
        if (!__INPUT_LED_PATTERN_SUPPORT || (__INPUT_ON_WINDOWS && (!is_numeric(__steam_handle)))) return;
        
        var _led_offset = 0;
        var _led_layout = undefined;
        var _led_type   = INPUT_GAMEPAD_TYPE_XBOX_360;

        //Handle whether gamepad index 0 is used or reserved
        if (!INPUT_ON_WEB && (__INPUT_ON_IOS || __INPUT_ON_SWITCH))
        { 
            if (index == 0) return;
            _led_offset = -1;
        }
        
        //MFi gamepad case
        if ((raw_type == "AppleController") && __INPUT_ON_IOS) _led_layout = "horizontal";
        
        switch(simple_type)
        {
            case INPUT_GAMEPAD_TYPE_PS5:
                _led_layout = "horizontal"; 
                _led_type   = INPUT_GAMEPAD_TYPE_PS5;
            break;
            
            case INPUT_GAMEPAD_TYPE_SWITCH:
            case INPUT_GAMEPAD_TYPE_JOYCON_LEFT:
            case INPUT_GAMEPAD_TYPE_JOYCON_RIGHT:
                if ((raw_type == "SwitchJoyConPair") || (!INPUT_SWITCH_HORIZONTAL_HOLDTYPE && (simple_type != INPUT_GAMEPAD_TYPE_SWITCH)))
                {
                     _led_layout = "vertical";
                }
                else
                {
                    _led_layout = "horizontal";
                }
                
                //Steam sets Xbox 360 pattern on Switch gamepad LEDs
                if not (is_numeric(__steam_handle)) _led_type = INPUT_GAMEPAD_TYPE_SWITCH;
            break;     
            
            case INPUT_GAMEPAD_TYPE_XBOX_360:
                _led_layout = "radial";
            break;
        }
        
        if (_led_layout != undefined)
        {
            __led_pattern = {
                value:   index + _led_offset + 1,
                pattern: __global.__gamepad_led_pattern_dict[$ _led_type][@ index + _led_offset],
                layout:  _led_layout,
            }
        }
    }
    
    static __color_set = function(_color)
    {   
        if (__global.__using_steamworks)
        {
            var _led_flag = steam_input_led_flag_set_color;
            if (_color == undefined)
            {
                _color = 0;
                _led_flag = steam_input_led_flag_restore_user_default;
            }           
            
            if (is_numeric(__steam_handle))
            {
                steam_input_set_led_color(__steam_handle, _color, _led_flag);
            }

            return;
        }
        
        if (__INPUT_ON_PS)
        {
            if (_color == undefined)
            {
                if (os_type == os_ps4) ps4_gamepad_reset_color(index);
                if (os_type == os_ps5) ps5_gamepad_reset_color(index);
                return;
            }
            
            gamepad_set_color(index, _color);
        }
    }
    
    static __vibration_set = function(_left, _right)
    {
        __vibration_left  = _left;
        __vibration_right = _right;        
        __vibration_received_this_frame = true;
    }
    
    static __trigger_effect_apply = function(_trigger, _effect, _strength)
    {
        var _trigger_index = 1;
        if (_trigger == gp_shoulderlb)
        {
            _trigger_index = 0;
        }
        else if (_trigger != gp_shoulderrb)
        {
            __input_error("Value ", _trigger ," not a gamepad trigger");
            return false;
        }

        if (os_type == os_ps5) return _effect.__apply_ps5(index, _trigger);

        //Steam Input uses libScePad for DualSense trigger effects, Windows native only
        if (__global.__using_steamworks && !__global.__on_wine && __INPUT_ON_WINDOWS)
        {
            var _command_array = [{ mode: steam_input_sce_pad_trigger_effect_mode_off, command_data: {} }, { mode: steam_input_sce_pad_trigger_effect_mode_off, command_data: {} }];
            _command_array[_trigger_index].mode = __global.__steam_trigger_mode[$ _effect.__mode];
            _command_array[_trigger_index].command_data[$ string(_effect.__mode_name) + "_param"] = _effect.__params;
            
            if (_effect.__params[$ "strength"] != undefined)
            {
                _effect.__params.strength *= _strength;
            }
            else if (_effect.__params[$ "amplitude"] != undefined)
            {
                _effect.__params.amplitude *= _strength;                
            }
            
            var _steam_trigger_params = { command: _command_array, trigger_mask: steam_input_sce_pad_trigger_effect_trigger_mask_l2 };
            if (_trigger_index) _steam_trigger_params.trigger_mask = steam_input_sce_pad_trigger_effect_trigger_mask_r2;
            
            if not (is_numeric(__steam_handle)) return false;
            
            return steam_input_set_dualsense_trigger_effect(__steam_handle, _steam_trigger_params);
        }

        return false;
    }
}
