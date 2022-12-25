/// @desc    Returns the icon defined in __input_config_icons() for the given binding, taking into account the player's currently assigned source(s)
/// @param   binding
/// @param   [playerIndex=0]

function input_binding_get_icon(_binding, _player_index = 0)
{
    if (!input_value_is_binding(_binding))
    {
        var _category_data = global.__input_icons[$ "not a binding"];
        if (!is_struct(_category_data)) return "not a binding";
        var _icon = _category_data.__dictionary[$ string(all)];
        return _icon ?? "not a binding";
    }
    
    var _fallback_category_data = global.__input_icons[$ "gamepad fallback"];
    if (is_struct(_fallback_category_data))
    {
        var _fallback_icon_struct = _fallback_category_data.__dictionary;
    }
    else
    {
        __input_trace("Warning! \"gamepad fallback\" icon data not found");
        var _fallback_icon_struct = {};
    }
    
    var _type  = _binding.type;
    var _label = _binding.__label;
    
    if ((_type == undefined) || (_label == undefined))
    {
        var _category_data = global.__input_icons[$ "unknown"];
        if (!is_struct(_category_data)) return "unknown";
        var _icon = _category_data.__dictionary[$ string(all)];
        return _icon ?? "unknown";
    }
    
    switch(_type)
    {
        case __INPUT_BINDING_KEY:
        case __INPUT_BINDING_MOUSE_BUTTON:
        case __INPUT_BINDING_MOUSE_WHEEL_UP:
        case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
            var _category = "keyboard and mouse";
        break;
        
        case __INPUT_BINDING_GAMEPAD_BUTTON:
        case __INPUT_BINDING_GAMEPAD_AXIS:
            var _category = input_player_get_gamepad_type(_player_index, _binding);
        break;
        
        default:
            __input_error("\"", _type, "\" unsupported");
        break;
    }
    
    //Try to find the lookup table for this particular category
    var _category_data = global.__input_icons[$ _category];
    if (is_struct(_category_data))
    {
        var _icon_struct = _category_data.__dictionary;
    }
    else
    {
        __input_trace("Warning! \"", _category, "\" icon data not found");
        
        //Fall back to the "unknown" category
        var _icon_struct = _fallback_icon_struct;
    }
    
    //Try to find the icon from the source struct
    var _icon = is_struct(_icon_struct)? _icon_struct[$ _label] : undefined;
    
    //Most of the time keyboard and mouse labels don't need to be translated into icons
    if (_category == "keyboard and mouse") return _icon ?? _label;
    
    if (_icon == undefined)
    {
        __input_trace("Warning! Could not find valid icon for \"", _label, "\" using gamepad type \"", _category, "\"" + ((_category == "unknown")? " (player " + string(_player_index) + " may not have a recognised gamepad assigned)" : ""));
        
        _icon = is_struct(_fallback_icon_struct)? _fallback_icon_struct[$ _label] : undefined;
        if (_icon == undefined)
        {
            __input_trace("Warning! Could not find valid icon for \"", _label, "\" using \"gamepad fallback\"");
            _icon = _label;
        }
    }
    
    return _icon;
}
