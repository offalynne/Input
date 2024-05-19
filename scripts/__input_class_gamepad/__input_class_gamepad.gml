// Feather disable all
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
    
    vendor  = undefined;
    product = undefined;
    
    button_count = undefined;
    axis_count   = undefined;
    hat_count    = undefined;
    
    __mapping             = gamepad_get_mapping(_index);
    __custom_mapping      = false;
    __mac_cleared_mapping = false;
    
    __xinput_trigger_range = 1;
    __stadia_trigger_test  = false;
    __axis_calibrated      = false;
    
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
    
    __connection_time     = current_time;
    __scan_start_time     = __connection_time + 250; //Give GM some space before allowing gamepad mappings to return values
    __disconnection_frame = undefined;
    
    discover();
    
    
    
    static discover = function()
    {
        mapping_gm_to_raw = {};
        mapping_raw_to_gm = {};
        mapping_array     = [];
        
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
        
        __vibration_initialize();
        __disconnection_frame = undefined;
        __axis_calibrated     = !__INPUT_ON_ANDROID;

        if (__global.__gamepad_motion_support) __motion = new __input_class_gamepad_motion(index);
        if (!__INPUT_SILENT)__input_trace("Gamepad ", index, " discovered, type = \"", simple_type, "\" (", raw_type, ", guessed=", guessed_type, "), description = \"", description, "\" (vendor=", vendor, ", product=", product, ")");
    }

    static __get_any_pressed = function()
    {
        if (get_pressed(gp_face1)
        ||  get_pressed(gp_face2)
        ||  get_pressed(gp_face3)
        ||  get_pressed(gp_face4)
        ||  get_pressed(gp_padu)
        ||  get_pressed(gp_padd)
        ||  get_pressed(gp_padl)
        ||  get_pressed(gp_padr)
        ||  get_pressed(gp_shoulderl)
        ||  get_pressed(gp_shoulderr)
        ||  get_pressed(gp_start)
        ||  get_pressed(gp_select)
        ||  get_pressed(gp_stickl)
        ||  get_pressed(gp_stickr)
        ||  get_pressed(gp_guide)
        ||  get_pressed(gp_misc1)
        ||  get_pressed(gp_touchpad)
        ||  get_pressed(gp_paddle1)
        ||  get_pressed(gp_paddle2)
        ||  get_pressed(gp_paddle3)
        ||  get_pressed(gp_paddle4)
        ||  (!is_axis(gp_shoulderlb) && get_pressed(gp_shoulderlb))
        ||  (!is_axis(gp_shoulderrb) && get_pressed(gp_shoulderrb)))
        {
            return true;
        }
        
        return false;
    }
    
    /// @param GMconstant
    static get_held = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.held;
    }
    
    /// @param GMconstant
    static get_pressed = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.press;
    }
    
    /// @param GMconstant
    static get_released = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.release;
    }
    
    /// @param GMconstant
    static get_value = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.value;
    }
    
    /// @param GMconstant
    static get_delta = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.__value_delta;
    }
    
    /// @param GMconstant
    static is_axis = function(_gm)
    {
        var _mapping = mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return (_mapping.type == __INPUT_MAPPING.AXIS);
    }
    
    static __set_custom_mapping = function()
    {
        __custom_mapping = true;
            
        if (__INPUT_SDL2_SUPPORT)
        {
            //As of 2020-08-17, GameMaker has weird in-build remapping rules for gamepad on MacOS
            if (__INPUT_ON_MACOS)
            {
                if ((__mapping != "") && (__mapping != "no mapping"))
                {
                    if (!__INPUT_SILENT) __input_trace("Gamepad ", index, " has a custom mapping, clearing GameMaker's native mapping string");
                    __mac_cleared_mapping = true;
                }
                
                //Additionally, gamepad_remove_mapping() doesn't seem to work. Setting the SDL string to something mostly blank does work though
                gamepad_test_mapping(index, gamepad_get_guid(index) + "," + gamepad_get_description(index) + ",");
            }
            else
            {
                if (!__INPUT_SILENT) __input_trace("Gamepad ", index, (blacklisted? " is blacklisted" : " has a custom mapping"), ", clearing GameMaker's native mapping string");
                gamepad_remove_mapping(index);
            }
        }
    }
    
    /// @param GMconstant
    /// @param rawIndex
    /// @param rawMappingType
    /// @param SDLname
    /// @param [override=true]
    static set_mapping = function(_gm, _raw_index, _mapping_type, _sdl_name, _override = true)
    {
        if (_override)
        {
            //Override built-in mapping
            if (not __custom_mapping) __set_custom_mapping();
        
            //Correct for weird input index offset on MacOS if the gamepad already had a native GameMaker mapping
            if (__mac_cleared_mapping && __INPUT_ON_MACOS)
            {
                if (_mapping_type == __INPUT_MAPPING.AXIS  ) _raw_index +=  6;
                if (_mapping_type == __INPUT_MAPPING.BUTTON) _raw_index += (__global.__use_gp_extended? 28 : 17);
            }
        }
        
        //Create a new mapping. It holds button state and definition information
        var _mapping = new __input_class_gamepad_mapping(_gm, _raw_index, _mapping_type, _sdl_name);
        
        mapping_gm_to_raw[$ _gm] = _mapping;
        if (_raw_index != undefined) mapping_raw_to_gm[$ _raw_index] = _mapping; //_raw_index can be undefined when setting up hat-on-axis
        array_push(mapping_array, _mapping);
        
        return _mapping;
    }
    
    static set_dpad_and_thumbstick_mapping = function()
    {
        set_dpad_hat_mapping();
        set_thumbstick_axis_mapping();
    }
    
    static set_dpad_hat_mapping = function()
    {
        var _mapping = set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"); 
        _mapping.hat_mask = 1;
        
        _mapping = set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright"); 
        _mapping.hat_mask = 2;
        
        _mapping = set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown"); 
        _mapping.hat_mask = 4;
        
        _mapping = set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft"); 
        _mapping.hat_mask = 8;
    }
    
    static set_thumbstick_axis_mapping = function(_left_only = false)
    {
        var _mappings = [
            set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx"),
            set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty")
        ];
        
        if not (_left_only)
        {
            array_push(_mappings, set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx"));
            array_push(_mappings, set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty"));
        }
        
        if (__INPUT_ON_LINUX)
        {
            var _i = 0;
            repeat(array_length(_mappings))
            {
                _mappings[_i].limited_range = true;
                ++_i;
            }
        }
    }
    
    /// @param connected
    static tick = function(_connected)
    {   
        if not (_connected)
        {
            //Timeout disconnection
            if (__disconnection_frame == undefined)
            {
                __disconnection_frame = __global.__frame;
            }
        }
        else
        {
            __disconnection_frame = undefined;
            
            //Apply mapping settings that cannot be initially evaluated
            if (__INPUT_ON_WINDOWS)
            {
                //Recalibrate XInput triggers
                if (__xinput_trigger_range < 1)
                {
                    var _trigger_max = max(gamepad_axis_value(index, __XINPUT_AXIS_LT), gamepad_axis_value(index, __XINPUT_AXIS_RT));
                    if (_trigger_max > __xinput_trigger_range)
                    {
                        if (_trigger_max > 255/256)
                        {
                            if (!__INPUT_SILENT) __input_trace("Fully extending XInput trigger scale for gamepad ", index);
                            __xinput_trigger_range = 1;
                        }
                        else
                        {
                            if (!__INPUT_SILENT) __input_trace("Partially extending XInput trigger scale for gamepad ", index);
                            __xinput_trigger_range = 255/256;
                        }
                        
                        var _mapping = mapping_gm_to_raw[$ gp_shoulderlb];
                        _mapping.scale = 1/__xinput_trigger_range;
                        
                        _mapping = mapping_gm_to_raw[$ gp_shoulderrb];
                        _mapping.scale = 1/__xinput_trigger_range;
                    }
                }
        
                //Set up alternate Stadia mapping
                if (__stadia_trigger_test)
                && ((gamepad_axis_value(index, 1) != gamepad_axis_value(index, 2)) 
                 || (gamepad_axis_value(index, 4) != gamepad_axis_value(index, 5)))
                {
                    if (!__INPUT_SILENT) __input_trace("Setting Stadia controller to analogue trigger mapping for gamepad ", index);
                    __stadia_trigger_test = false;                    
                    
                    set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                    set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
                    
                    var _mapping = set_mapping(gp_shoulderrb, 4, __INPUT_MAPPING.AXIS, "righttrigger");
                    _mapping.extended_range = true;

                    _mapping = set_mapping(gp_shoulderlb, 5, __INPUT_MAPPING.AXIS, "lefttrigger");
                    _mapping.extended_range = true;
                }
            }
        }
        
        //Remove deadzone
        var _deadzone = gamepad_get_axis_deadzone(index);
        if (_deadzone != 0.0) gamepad_set_axis_deadzone(index, 0.0);
        
        //Tick mapping        
        var _scan = (_connected && (current_time > __scan_start_time));
        var _gamepad = index;
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            with(mapping_array[_i]) tick(_gamepad, _scan);
            ++_i;
        }
        
        //Restore deadzone
        if (_deadzone != 0.0) gamepad_set_axis_deadzone(index, _deadzone);
        
        //Handle uncalibrated axis
        if (_connected && !__axis_calibrated)
        {
            var _success = false;
            var _mapping = 0;
            repeat(array_length(mapping_array))
            {
                _success = mapping_array[_mapping].__calibrate(__axis_calibrated);
                if (_success)
                {
                    __input_trace("Axis calibration confirmed for gamepad ", index);
                    __axis_calibrated = true;
                }
                
                ++_mapping;
            }
        }
        
        //Handle disconnection
        if not (_connected)
        {
            //Flag for removal
            if (__global.__frame - __disconnection_frame >= __INPUT_GAMEPADS_DISCONNECTION_TIMEOUT)
            {
                return false;
            }
        }
        
        //Handle vibration
        if (__vibration_support)
        {
            if (_connected && __vibration_received_this_frame && input_game_has_focus())
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
        
        return true;
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
    
    static __vibration_initialize = function()
    {
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
