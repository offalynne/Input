// Feather disable all
/// @param index
function __input_class_gamepad(_index) constructor
{
    __INPUT_GLOBAL_STATIC_VARIABLE  //Set static __global
    
    __index           = _index;
    __description     = gamepad_get_description(_index);
    __guid            = gamepad_get_guid(_index);
    __xinput          = undefined;
    __raw_type        = undefined;
    __simple_type     = undefined;
    __sdl2_definition = undefined;
    __guessed_type    = false;
    __blacklisted     = false;

    __vendor  = undefined;
    __product = undefined;

    __button_count = undefined;
    __axis_count   = undefined;
    __hat_count    = undefined;
    
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
    
    __mapping_gm_to_raw = {};
    __mapping_raw_to_gm = {};
    __mapping_array     = [];
    
    __connection_time     = current_time;
    __scan_start_time     = __connection_time + 250; //Give GM some space before allowing gamepad mappings to return values
    __disconnection_frame = undefined;
    
    __discover();
    
    
    
    static __discover = function()
    {
        __mapping_gm_to_raw = {};
        __mapping_raw_to_gm = {};
        __mapping_array     = [];

        __button_count = gamepad_button_count(__index);
        __axis_count   = gamepad_axis_count(__index);
        __hat_count    = gamepad_hat_count(__index);
        
        __input_gamepad_set_vid_pid();
        __input_gamepad_set_description();
        __input_gamepad_find_in_sdl2_database();
        __input_gamepad_set_type();
        __input_gamepad_set_blacklist();
        __input_gamepad_set_mapping();
        
        __virtual_set();
        __led_set();
        __swap_ab();
        
        __vibration_initialize();
        __disconnection_frame = undefined;
        __axis_calibrated     = !__INPUT_ON_ANDROID;

        if (__global.__gamepad_motion_support) __motion = new __input_class_gamepad_motion(__index);
        if (!__INPUT_SILENT)__input_trace("Gamepad ", __index, " discovered, type = \"", __simple_type, "\" (", __raw_type, ", guessed=", __guessed_type, "), description = \"", __description, "\" (vendor=", __vendor, ", product=", __product, ")");
    }

    static __get_any_pressed = function()
    {
        if (__get_pressed(gp_face1)
        ||  __get_pressed(gp_face2)
        ||  __get_pressed(gp_face3)
        ||  __get_pressed(gp_face4)
        ||  __get_pressed(gp_padu)
        ||  __get_pressed(gp_padd)
        ||  __get_pressed(gp_padl)
        ||  __get_pressed(gp_padr)
        ||  __get_pressed(gp_shoulderl)
        ||  __get_pressed(gp_shoulderr)
        ||  __get_pressed(gp_start)
        ||  __get_pressed(gp_select)
        ||  __get_pressed(gp_stickl)
        ||  __get_pressed(gp_stickr)
        ||  __get_pressed(gp_guide)
        ||  __get_pressed(gp_misc1)
        ||  __get_pressed(gp_touchpad)
        ||  __get_pressed(gp_paddle1)
        ||  __get_pressed(gp_paddle2)
        ||  __get_pressed(gp_paddle3)
        ||  __get_pressed(gp_paddle4)
        ||  (!__is_axis(gp_shoulderlb) && __get_pressed(gp_shoulderlb))
        ||  (!__is_axis(gp_shoulderrb) && __get_pressed(gp_shoulderrb)))
        {
            return true;
        }
        
        return false;
    }
    
    /// @param GMconstant
    static __get_held = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.__held;
    }
    
    /// @param GMconstant
    static __get_pressed = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.__press;
    }
    
    /// @param GMconstant
    static __get_released = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return _mapping.__release;
    }
    
    /// @param GMconstant
    static __get_value = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.__value;
    }
    
    /// @param GMconstant
    static __get_delta = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return 0.0;
        return _mapping.__value_delta;
    }
    
    /// @param GMconstant
    static __is_axis = function(_gm)
    {
        var _mapping = __mapping_gm_to_raw[$ _gm];
        if (_mapping == undefined) return false;
        return (_mapping.__type == __INPUT_MAPPING.AXIS);
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
                    if (!__INPUT_SILENT) __input_trace("Gamepad ", __index, " has a custom mapping, clearing GameMaker's native mapping string");
                    __mac_cleared_mapping = true;
                }
                
                //Additionally, gamepad_remove_mapping() doesn't seem to work. Setting the SDL string to something mostly blank does work though
                gamepad_test_mapping(__index, gamepad_get_guid(__index) + "," + gamepad_get_description(__index) + ",");
            }
            else
            {
                if (!__INPUT_SILENT) __input_trace("Gamepad ", __index, (__blacklisted? " is blacklisted" : " has a custom mapping"), ", clearing GameMaker's native mapping string");
                gamepad_remove_mapping(__index);
            }
        }
    }
    
    /// @param GMconstant
    /// @param rawIndex
    /// @param rawMappingType
    /// @param SDLname
    /// @param [override=true]
    static __set_mapping = function(_gm, _raw_index, _mapping_type, _sdl_name, _override = true)
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
        
        __mapping_gm_to_raw[$ _gm] = _mapping;
        if (_raw_index != undefined) __mapping_raw_to_gm[$ _raw_index] = _mapping; //_raw_index can be undefined when setting up hat-on-axis
        array_push(__mapping_array, _mapping);
        
        return _mapping;
    }
    
    static __set_face_button_mapping = function()
    {
        __set_mapping(gp_face1, 0, __INPUT_MAPPING.BUTTON, "a");
        __set_mapping(gp_face2, 1, __INPUT_MAPPING.BUTTON, "b");      
        __set_mapping(gp_face3, 2, __INPUT_MAPPING.BUTTON, "x");
        __set_mapping(gp_face4, 3, __INPUT_MAPPING.BUTTON, "y");
    }
    
    static __set_dpad_and_thumbstick_mapping = function()
    {
        __set_dpad_hat_mapping();
        __set_thumbstick_axis_mapping();
    }
    
    static __set_dpad_hat_mapping = function()
    {
        var _mapping = __set_mapping(gp_padu, 0, __INPUT_MAPPING.HAT, "dpup"); 
        _mapping.__hat_mask = 1;
        
        _mapping = __set_mapping(gp_padr, 0, __INPUT_MAPPING.HAT, "dpright"); 
        _mapping.__hat_mask = 2;
        
        _mapping = __set_mapping(gp_padd, 0, __INPUT_MAPPING.HAT, "dpdown"); 
        _mapping.__hat_mask = 4;
        
        _mapping = __set_mapping(gp_padl, 0, __INPUT_MAPPING.HAT, "dpleft"); 
        _mapping.__hat_mask = 8;
    }
    
    static __set_thumbstick_axis_mapping = function(_left_only = false)
    {
        var _mappings = [
            __set_mapping(gp_axislh, 0, __INPUT_MAPPING.AXIS, "leftx"),
            __set_mapping(gp_axislv, 1, __INPUT_MAPPING.AXIS, "lefty")
        ];
        
        if not (_left_only)
        {
            array_push(_mappings, __set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx"));
            array_push(_mappings, __set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty"));
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
    static __tick = function(_connected)
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
                    var _trigger_max = max(gamepad_axis_value(__index, __XINPUT_AXIS_LT), gamepad_axis_value(__index, __XINPUT_AXIS_RT));
                    if (_trigger_max > __xinput_trigger_range)
                    {
                        if (_trigger_max > 255/256)
                        {
                            if (!__INPUT_SILENT) __input_trace("Fully extending XInput trigger scale for gamepad ", __index);
                            __xinput_trigger_range = 1;
                        }
                        else
                        {
                            if (!__INPUT_SILENT) __input_trace("Partially extending XInput trigger scale for gamepad ", __index);
                            __xinput_trigger_range = 255/256;
                        }
                        
                        var _mapping = __mapping_gm_to_raw[$ gp_shoulderlb];
                        _mapping.__scale = 1/__xinput_trigger_range;
                        
                        _mapping = __mapping_gm_to_raw[$ gp_shoulderrb];
                        _mapping.__scale = 1/__xinput_trigger_range;
                    }
                }
        
                //Set up alternate Stadia mapping
                if (__stadia_trigger_test)
                && ((gamepad_axis_value(__index, 1) != gamepad_axis_value(__index, 2)) 
                 || (gamepad_axis_value(__index, 4) != gamepad_axis_value(__index, 5)))
                {
                    if (!__INPUT_SILENT) __input_trace("Setting Stadia controller to analogue trigger mapping for gamepad ", __index);
                    __stadia_trigger_test = false;                    
                    
                    __set_mapping(gp_axisrh, 2, __INPUT_MAPPING.AXIS, "rightx");
                    __set_mapping(gp_axisrv, 3, __INPUT_MAPPING.AXIS, "righty");
                    
                    var _mapping = __set_mapping(gp_shoulderrb, 4, __INPUT_MAPPING.AXIS, "righttrigger");
                    _mapping.__extended_range = true;

                    _mapping = __set_mapping(gp_shoulderlb, 5, __INPUT_MAPPING.AXIS, "lefttrigger");
                    _mapping.__extended_range = true;
                }
            }
        }
        
        //Remove deadzone
        var _deadzone = gamepad_get_axis_deadzone(__index);
        if (_deadzone != 0.0) gamepad_set_axis_deadzone(__index, 0.0);
        
        //Tick mapping        
        var _scan = (_connected && (current_time > __scan_start_time));
        var _gamepad = __index;

        var _i = 0;
        repeat(array_length(__mapping_array))
        {
            with(__mapping_array[_i]) __tick(_gamepad, _scan);
            ++_i;
        }
        
        //Restore deadzone
        if (_deadzone != 0.0) gamepad_set_axis_deadzone(__index, _deadzone);
        
        //Handle uncalibrated axis
        if (_connected && !__axis_calibrated)
        {
            var _success = false;
            var _mapping = 0;
            repeat(array_length(__mapping_array))
            {
                _success = __mapping_array[_mapping].__calibrate(__axis_calibrated);
                if (_success)
                {
                    __input_trace("Axis calibration confirmed for gamepad ", __index);
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
                    if ((__raw_type == "SwitchJoyConLeft") || (__raw_type == "SwitchJoyConRight"))
                    {
                        //Documentation said to use switch_controller_motor_single for these two controller types but I'll be damned if I can feel any difference!
                        switch_controller_vibrate_hd(__index, switch_controller_motor_single, _vibration_high, 250, _vibration_low, 160);
                    }
                    else
                    {
                        switch_controller_vibrate_hd(__index, switch_controller_motor_left,  _vibration_high, 250, _vibration_low, 160);
                        switch_controller_vibrate_hd(__index, switch_controller_motor_right, _vibration_high, 250, _vibration_low, 160);
                    }
                }
                else
                {
                    gamepad_set_vibration(__index, _vibration_low, _vibration_high);
                }
            }
            else
            {
                gamepad_set_vibration(__index, 0, 0);
            }
            
            __vibration_received_this_frame = false;
        }
        
        return true;
    }
    
    static __swap_ab = function()
    {
        if (__input_gamepad_type_swap_ab(__simple_type) && is_struct(__mapping_gm_to_raw[$ string(gp_face1)]) && is_struct(__mapping_gm_to_raw[$ string(gp_face2)]))
        {
            if (__INPUT_DEBUG) __input_trace("  (Swapping A and B)");
            var _a_mapping = __mapping_gm_to_raw[$ string(gp_face1)].__raw;
            __set_mapping(gp_face1, __mapping_gm_to_raw[$ string(gp_face2)].__raw, __INPUT_MAPPING.BUTTON, "a");
            __set_mapping(gp_face2, _a_mapping, __INPUT_MAPPING.BUTTON, "b");
        }
    }
    
    static __virtual_set = function()
    {
        if not (__global.__using_steamworks) return;
    
        var _gamepad_is_virtual = (__INPUT_ON_WINDOWS && __xinput);
        var _slot = __index;
        if (__INPUT_ON_LINUX)
        {
            _gamepad_handle_index = -1;
            _gamepad_is_virtual = false;

            var _i = 0;
            repeat(__index + 1)
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

            __description = _description;
            __raw_type    = _raw_type;
            __simple_type = _simple_type;
        }
    }
    
    static __led_set = function()
    {
        __led_pattern = undefined;
        
        //Platform is unsupported, or lacks Steam Input handle
        if (!__INPUT_LED_PATTERN_SUPPORT || (__INPUT_ON_WINDOWS && (!is_numeric(__steam_handle)))) return;
        
        //Defaults
        var _led_offset = 0;
        var _led_layout = undefined;
        var _led_type   = INPUT_GAMEPAD_TYPE_XBOX_360;

        //Handle whether gamepad index 0 is used or reserved
        if (!INPUT_ON_WEB && (__INPUT_ON_IOS || __INPUT_ON_SWITCH))
        { 
            if (__index == 0) return;
            _led_offset = -1;
        }
        
        //MFi gamepad case
        if ((__raw_type == "AppleController") && __INPUT_ON_IOS) _led_layout = "horizontal";
        
        switch(__simple_type)
        {
            case INPUT_GAMEPAD_TYPE_PS5:
                _led_layout = "horizontal"; 
                _led_type   = INPUT_GAMEPAD_TYPE_PS5;
            break;
            
            case INPUT_GAMEPAD_TYPE_SWITCH:
            case INPUT_GAMEPAD_TYPE_JOYCON_LEFT:
            case INPUT_GAMEPAD_TYPE_JOYCON_RIGHT:
                if ((__raw_type == "SwitchJoyConPair") || (!INPUT_SWITCH_HORIZONTAL_HOLDTYPE && (__simple_type != INPUT_GAMEPAD_TYPE_SWITCH)))
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
                __value:   __index + _led_offset + 1,
                __pattern: __global.__gamepad_led_pattern_dict[$ _led_type][@ __index + _led_offset],
                __layout:  _led_layout,
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
                if (os_type == os_ps4) ps4_gamepad_reset_color(__index);
                if (os_type == os_ps5) ps5_gamepad_reset_color(__index);
                return;
            }
            
            gamepad_set_color(__index, _color);
        }
    }
    
    static __vibration_initialize = function()
    {
        __vibration_support = __global.__vibration_allowed && (__xinput || !__INPUT_ON_WINDOWS);        
        if (__vibration_support)
        {
            if (os_type == os_ps5)
            {
                ps5_gamepad_set_vibration_mode(__index, ps5_gamepad_vibration_mode_compatible);
            }            
            else
            {
                if ((__INPUT_ON_WINDOWS || __INPUT_ON_SWITCH) && __input_string_contains(__raw_type, "JoyCon", "SwitchHandheld"))
                {
                    __vibration_scale = INPUT_VIBRATION_JOYCON_STRENGTH;
                }
                else
                {
                    __vibration_scale = 1;
                }
            }
        
            gamepad_set_vibration(__index, 0, 0);
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

        if (os_type == os_ps5) return _effect.__apply_ps5(__index, _trigger, _strength);
        if (__global.__using_steamworks) return __input_steam_apply_trigger_effect(__steam_handle, _effect, _trigger_index, _strength)

        return false;
    }
}
