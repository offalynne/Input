/// @param index
function __input_class_gamepad(_index) constructor
{
    index             = _index;
    description       = "Unknown";
    guid              = gamepad_get_guid(_index);
    xinput            = undefined;
    type              = undefined;
    guessed_type      = false;
    blacklisted       = false;
    sdl2_definition   = undefined;
    
    vendor            = undefined;
    product           = undefined;
    
    custom_mapping    = false;
    mapping_gm_to_raw = {};
    mapping_raw_to_gm = {};
    mapping_array     = [];
    
    /// @param GMconstant
    get_held = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.held;
    }
    
    /// @param GMconstant
    get_pressed = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_pressed(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.press;
    }
    
    /// @param GMconstant
    get_released = function(_gm)
    {
        if (!custom_mapping) return gamepad_button_check_released(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.release;
    }
    
    /// @param GMconstant
    get_value = function(_gm)
    {
        if (!custom_mapping) return gamepad_axis_value(index, _gm);
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return 0.0;
        return _mapping.value;
    }
    
    /// @param GMconstant
    is_axis = function(_gm)
    {
        if (!custom_mapping)
        {
            if ((_gm == gp_shoulderlb) || (_gm == gp_shoulderrb))
            {
                //If this is an XInput controller, the triggers are *usually* analogue
                return xinput;
            }
            
            //Otherwise return true only for the thumbsticks
            return ((_gm == gp_axislh) || (_gm == gp_axislv) || (_gm == gp_axisrh) || (_gm == gp_axisrv));
        }
        
        var _mapping = variable_struct_get(mapping_gm_to_raw, _gm);
        if (_mapping == undefined) return false;
        return (_mapping.type == "a");
    }
    
    /// @param GMconstant
    /// @param raw
    /// @param rawType
    /// @param SDLname
    set_mapping = function(_gm, _raw, _type, _sdl_name)
    {
        if (!custom_mapping)
        {
            __input_trace("Gamepad ", index, " has a custom mapping, clearing GM's internal mapping string");
            
            if (os_type == os_macosx)
            {
                if ((gamepad_get_mapping(index) != "") && (gamepad_get_mapping(index) != "no mapping"))
                {
                    __input_trace("Warning! Performing remapping of MacOS controller that already has a remapping. This may well cause glitches and errors (mapping was \"", gamepad_get_mapping(index), "\")");
                }
                
                //As of 2020-08-17, GameMaker has weird in-build remapping rules for gamepad on MacOS
                //Additionally, gamepad_remove_mapping() doesn't seem to work. Setting the SDL string to something mostly blank does work though
                gamepad_test_mapping(index, gamepad_get_guid(index) + "," + gamepad_get_description(index) + ",");
            }
            else
            {
                gamepad_remove_mapping(index);
            }
            
            custom_mapping = true;
        }
        
        //Correct for weird input index offset on MacOS
        if (os_type == os_macosx)
        {
            if (_type == "a") _raw +=  6;
            if (_type == "b") _raw += 17;
        }
        
        var _mapping = {
            gm            : _gm,
            raw           : _raw,
            type          : _type,
            sdl_name      : _sdl_name,
            
            invert        : false,
            negative      : false,
            positive      : false,
            reverse       : false,
            limit_range   : false,
            hat_mask      : undefined,
            
            held_previous : false,
            value         : 0.0,
            held          : false,
            press         : false,
            release       : false,
        };
        
        variable_struct_set(mapping_gm_to_raw, _gm , _mapping);
        variable_struct_set(mapping_raw_to_gm, _raw, _mapping);
        mapping_array[@ array_length(mapping_array)] = _mapping;
        
        return _mapping;
    }
    
    tick = function()
    {
        var _index = index;
        
        var _i = 0;
        repeat(array_length(mapping_array))
        {
            with(mapping_array[_i])
            {
                held_previous = held;
                value         = 0.0;
                held          = false;
                press         = false;
                release       = false;
                
                switch(type)
                {
                    case "b": value = gamepad_button_check(_index, raw); break;
                    case "a": value = gamepad_axis_value(  _index, raw); break;
                    case "h":
                        value = gamepad_hat_value(_index, raw);
                        value = value & hat_mask;
                    break;
                }
                
                if (limit_range) value = 0.5 + 0.5*value;
                if (negative) value = clamp(value, -1, 0);
                if (positive) value = clamp(value,  0, 1);
                if (invert) value = 1 - value;
                if (reverse) value = -value;
                
                held = (abs(value) > 0.2);
                
                if (held_previous != held)
                {
                    if (held)
                    {
                        press = true;
                    }
                    else
                    {
                        release = true;
                    }
                }
            }
            
            ++_i;
        }
    }
    
    __input_gamepad_set_vid_pid(self);
    __input_gamepad_find_in_sdl2_database(self); //Also sets gamepad description
    __input_gamepad_set_type(self);
    __input_gamepad_set_mapping(self);
    
    __input_trace("Gamepad ", index, " discovered, type = \"", type, "\", description = \"", description, "\" (vendor=", vendor, ", product=", product, ")");
}