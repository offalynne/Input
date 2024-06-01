// Feather disable all
/// @desc    Returns the icon defined in __input_config_icons() for the given binding, taking into account the player's currently assigned source(s)
/// @param   binding
/// @param   [playerIndex=0]

function input_binding_get_icon(_binding, _player_index = 0)
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    __INPUT_VERIFY_PLAYER_INDEX
    
    //Find the correct fallback icon data
    //We'll use this if there's a problem resolving an icon otherwise
    static _fallback_icon_struct   = undefined;
    static _fallback_category_name = INPUT_GAMEPAD_TYPE_XBOX_ONE;
    
    if (_fallback_icon_struct == undefined)
    {
        switch(os_type)
        {
            case os_ps3:          _fallback_category_name = INPUT_GAMEPAD_TYPE_PSX;      break;
            case os_ps4:          _fallback_category_name = INPUT_GAMEPAD_TYPE_PS4;      break;
            case os_ps5:          _fallback_category_name = INPUT_GAMEPAD_TYPE_PS5;      break;
            case os_switch:       _fallback_category_name = INPUT_GAMEPAD_TYPE_SWITCH;   break;
            case os_xboxone:      _fallback_category_name = INPUT_GAMEPAD_TYPE_XBOX_ONE; break;
            case os_xboxseriesxs: _fallback_category_name = INPUT_GAMEPAD_TYPE_XBOX_ONE; break;
            default:              _fallback_category_name = INPUT_GAMEPAD_TYPE_XBOX_ONE; break;
        }
        
        var _fallback_category_data = _global.__icons[$ _fallback_category_name];
        if (is_struct(_fallback_category_data))
        {
            _fallback_icon_struct = _fallback_category_data.__dictionary;
        }
        else
        {
            __input_trace("Warning! \"", _fallback_category_name, "\" icon data not found");
            _fallback_icon_struct = {};
        }
    }
    
    //Check for invalid input value
    if (!input_value_is_binding(_binding))
    {
        var _category_data = _global.__icons[$ "not a binding"];
        if (!is_struct(_category_data)) return "not a binding";
        var _icon = _category_data.__dictionary[$ string(all)];
        return _icon ?? "not a binding";
    }
    
    var _type  = _binding.type;
    var _label = _binding.__label;
    
    //If this is an empty binding...
    if ((_type == undefined) || (_label == undefined))
    {
        var _category_data = _global.__icons[$ "empty"];
        if (!is_struct(_category_data)) return "empty";
        var _icon = _category_data.__dictionary[$ string(all)];
        return _icon ?? "empty";
    }
    
    //If this is a touch binding...
    if (_type == __INPUT_BINDING_VIRTUAL_BUTTON)
    {
        var _category_data = _global.__icons[$ "virtual button"];
        if (!is_struct(_category_data)) return "virtual button";
        var _icon = _category_data.__dictionary[$ string(all)];
        return _icon ?? "virtual button";
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
            var _category = _global.__players[_player_index].__gamepad_type_override ?? input_player_get_gamepad_type(_player_index, _binding);
        break;
        
        default:
            __input_error("\"", _type, "\" unsupported");
        break;
    }
    
    //Try to find the lookup table for this particular category
    var _category_data = _global.__icons[$ _category];
    var _icon_struct = is_struct(_category_data)? _category_data.__dictionary : _fallback_icon_struct;
    
    //Try to find the icon from the source struct
    var _icon = is_struct(_icon_struct)? _icon_struct[$ _label] : undefined;
    
    //Most of the time keyboard and mouse labels don't need to be translated into icons
    if (_category == "keyboard and mouse") return _icon ?? _label;
    
    if (_icon == undefined)
    {
        _icon = _fallback_icon_struct[$ _label];
        if (_icon == undefined)
        {
            __input_trace("Warning! Could not find valid icon for \"", _label, "\" using \"", _fallback_category_name, "\"");
            _icon = _label;
        }
    }
    
    return _icon;
}
