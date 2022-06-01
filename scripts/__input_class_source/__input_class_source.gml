/// @param source
/// @param gamepad

function __input_class_source(_source, _gamepad = undefined) constructor
{
    __source  = _source;
    __gamepad = _gamepad;
    
    switch(__source)
    {
        case __INPUT_SOURCE.KEYBOARD: __name = INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER? "keyboard and mouse" : "keyboard"; break;
        case __INPUT_SOURCE.MOUSE:    __name = INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER? "keyboard and mouse" : "mouse";    break;
        case __INPUT_SOURCE.GAMEPAD:  __name = "gamepad " + string(_gamepad); break;
        
        default:
            __input_error("Source \"", __source, "\" not recognised");
        break;
    }
    
    static toString = function()
    {
        return __name;
    }
    
    static __is_connected = function()
    {
        switch(__source)
        {
            case __INPUT_SOURCE.KEYBOARD: return true;                                  break; //TODO - Should this check against whether bindings exist for this source?
            case __INPUT_SOURCE.MOUSE:    return true;                                  break; //TODO - Should this check against whether bindings exist for this source?
            case __INPUT_SOURCE.GAMEPAD:  return input_gamepad_is_connected(__gamepad); break;
            
            default:
                __input_error("Source \"", __source, "\" not recognised");
            break;
        }
    }
    
    static __equal_to = function(_other_source)
    {
        switch(_other_source.__source)
        {
            case __INPUT_SOURCE.KEYBOARD: return (__source == __INPUT_SOURCE.KEYBOARD); break;
            case __INPUT_SOURCE.MOUSE:    return (__source == __INPUT_SOURCE.MOUSE); break;
            case __INPUT_SOURCE.GAMEPAD:  return ((__source == __INPUT_SOURCE.GAMEPAD) && (__gamepad == _other_source.__gamepad)); break;
        }
        
        return false;
    }
    
    static __any_input = function()
    {
        return __input_source_any_input(__source, __gamepad);
    }
    
    static __scan_for_binding = function(_player_index = 0)
    {
        if (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && ((__source == __INPUT_SOURCE.KEYBOARD) || (__source == __INPUT_SOURCE.MOUSE)))
        {
            var _binding = __input_source_scan_for_binding(__INPUT_SOURCE.KEYBOARD, __gamepad, _player_index);
            if (_binding != undefined) return _binding;
            
            return __input_source_scan_for_binding(__INPUT_SOURCE.MOUSE, __gamepad, _player_index);
        }
        
        return __input_source_scan_for_binding(__source, __gamepad, _player_index);
    }
    
    static __validate_binding = function(_binding)
    {
        var _type  = _binding.type;
        var _value = _binding.value;
        
        if ((_type == __INPUT_BINDING_GAMEPAD_BUTTON) || (_type == __INPUT_BINDING_GAMEPAD_AXIS))
        {
            //Gamepad-specific validations
            if (__source == __INPUT_SOURCE.GAMEPAD)
            {
                var _gamepad = global.__input_gamepads[__gamepad];
                if (!is_struct(_gamepad) || (_gamepad.mapping_gm_to_raw[$ _value] == undefined))
                {
                    //Value not found in the mapping for the player's gamepad
                    return false;
                }
                
                //Get raw value from mapping
                var _mapping = _gamepad.mapping_gm_to_raw[$ _value];
                var _raw = ((_mapping.raw == undefined)? _mapping.raw_negative : _mapping.raw);
                if (_raw == undefined)
                {
                    //Raw value invalid
                    return false;
                }
                
                if (_gamepad.xinput && ((_raw == 4106) || (_raw == 4107)))
                {
                    //Except XInput trigger values from range checks
                    return true;
                }
                
                if (_raw == 0)
                {
                    var _hat_mask = ((_mapping.hat_mask == undefined)? _mapping.hat_mask_negative : _mapping.hat_mask);        
                    if (_hat_mask != undefined)
                    {
                        //Validate hat mappings
                        return ((_hat_mask == 1) || (_hat_mask == 2) || (_hat_mask == 4) || (_hat_mask == 8));
                    }
                }
            }
        }
        
        switch(_type)
        {            
            case __INPUT_BINDING_GAMEPAD_BUTTON: //Validate button range
                if (__source != __INPUT_SOURCE.GAMEPAD) return false;
                return (_raw < gamepad_button_count(__gamepad));
            break;
            
            case __INPUT_BINDING_GAMEPAD_AXIS: //Validate axis range
                if (__source != __INPUT_SOURCE.GAMEPAD) return false;
                return (_raw < gamepad_axis_count(__gamepad));
            break;
            
            case __INPUT_BINDING_KEY:
                if (!global.__input_keyboard_allowed)
                {
                    //Invalid per platform or configuration
                    return false;
                }
                
                if not ((__source == __INPUT_SOURCE.KEYBOARD) || (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (__source == __INPUT_SOURCE.MOUSE))) return false;
                
                if (os_type == os_android)
                {
                    if (((_value >= 16) && (_value <= 19))
                    ||  ((_value >= 96) && (_value <= 122)))
                    {
                        //Command keys that overlap alpha don't register on Android, are invalid binds
                        return false;
                    }
                    
                    var _lowercase = _binding.__android_lowercase;
                    if ((_lowercase != undefined) && !__input_key_is_ignored(_lowercase)
                    &&  (_lowercase >= __INPUT_KEYCODE_MIN) && (_lowercase <= __INPUT_KEYCODE_MAX))
                    {
                        //Lowercase key binding is valid
                        return true;
                    }
                }
                
                //Uppercase key binding
                return (!__input_key_is_ignored(_value) && (_value >= __INPUT_KEYCODE_MIN) && (_value <= __INPUT_KEYCODE_MAX));
            break;
            
            case __INPUT_BINDING_MOUSE_BUTTON:
                if (!global.__input_mouse_allowed)
                {
                    //Invalid per platform or configuration
                    return false;
                }
                
                if not ((__source == __INPUT_SOURCE.MOUSE) || (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (__source == __INPUT_SOURCE.KEYBOARD))) return false;
                
                switch(_value)
                {
                    case mb_left: //Invalid on Xbox
                        return !__INPUT_ON_XDK;
                    break;
                    
                    case mb_right: //Invalid on Xbox, Playstation, native Android or iOS
                        return !(__INPUT_ON_XDK || __INPUT_ON_PS || (!__INPUT_ON_WEB && ((os_type == os_ios) || (os_type == os_android))));
                    break;
                    
                    case mb_middle: //Invalid on console, Android or iOS
                        return !(__INPUT_ON_CONSOLE || (os_type == os_ios) || (os_type == os_android));
                    break;
                    
                    case mb_side1:
                    case mb_side2: //Invalid on console, OperaGX, mobile, Firefox or Mac browsers
                        return !(__INPUT_ON_CONSOLE || __INPUT_ON_OPERAGX || __INPUT_ON_MOBILE || (os_browser == browser_firefox) || (__INPUT_ON_WEB && (os_type == os_macosx)))
                    break;
                    
                    default:
                        return false;
                    break;
                }
            break;
            
            case __INPUT_BINDING_MOUSE_WHEEL_UP:
            case __INPUT_BINDING_MOUSE_WHEEL_DOWN:
                if (!global.__input_mouse_allowed)
                {
                    //Invalid per platform or configuration
                    return false;
                }
                
                if not ((__source == __INPUT_SOURCE.MOUSE) || (INPUT_ASSIGN_KEYBOARD_AND_MOUSE_TOGETHER && (__source == __INPUT_SOURCE.KEYBOARD))) return false;
                
                //Invalid on console or native mobile
                return !(__INPUT_ON_CONSOLE || (!__INPUT_ON_WEB && __INPUT_ON_MOBILE));        
            break;
            
            default:
                return false;
            break;
        }
        
        __input_error("Binding validity unhandled");
    }
}

function __input_source_scan_for_binding(_source, _gamepad, _player_index = 0)
{
    switch(_source)
    {
        case __INPUT_SOURCE.KEYBOARD:
            var _keyboard_key = __input_keyboard_key();
            
            if (global.__input_any_keyboard_binding_defined 
            && (_keyboard_key >= __INPUT_KEYCODE_MIN) && (_keyboard_key <= __INPUT_KEYCODE_MAX)
            && !__input_key_is_ignored(_keyboard_key))
            {
                //FIXME - Despite this class being implemented as a fluent interface, GMS2.3.3 has bugs when returning <self> on certain platforms
                var _binding = new __input_class_binding();
                _binding.__set_key(_keyboard_key, true);
                
                //On Mac we update the binding label to the actual keyboard character if it is a Basic Latin alphabetic character
                //This works around problems where a keyboard might be sending a character code for e.g. A but the OS is typing another letter
                if (os_type == os_macosx)
                {
                    __input_trace("Binding label for keycode ", string(ord(_binding.__label)), ", initially set to \"", _binding.__label, "\"");
                    var _keychar = string_upper(keyboard_lastchar);
                    
                    //Basic Latin only
                    if ((ord(_keychar) >= ord("A")) && (ord(_keychar) <= ord("Z")))
                    {
                        _binding.__set_label(_keychar);
                        __input_key_name_set(_keyboard_key, _keychar);    
                    }
                }
                
                return _binding;
            }
        break;
        
        case __INPUT_SOURCE.MOUSE:
            var _mouse_button = __input_mouse_button();
            
            if (global.__input_any_mouse_binding_defined)
            {
                if (global.__input_mouse_allowed && !global.__input_mouse_blocked
                        && (_mouse_button != mb_none)
                        && (!__INPUT_TOUCH_SUPPORT || (_mouse_button != mb_left))) //GM conflates LMB and touch. Don't rebind
                {
                    return input_binding_mouse_button(_mouse_button);
                }
                else if (mouse_wheel_up())
                {
                    return input_binding_mouse_wheel_up();
                }
                else if (mouse_wheel_down())
                {
                    return input_binding_mouse_wheel_down();
                }
            }
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            if (global.__input_any_gamepad_binding_defined)
            {
                //Gamepad buttons and axes
                var _check_array = [gp_face1,     gp_face2,     gp_face3,      gp_face4, 
                                    gp_padu,      gp_padd,      gp_padl,       gp_padr, 
                                    gp_shoulderl, gp_shoulderr, gp_shoulderlb, gp_shoulderrb,
                                    gp_start,     gp_select,    gp_stickl,     gp_stickr,
                                    gp_axislh,    gp_axislv,    gp_axisrh,     gp_axisrv,    ];
                
                //Extended buttons
                if (INPUT_SDL2_ALLOW_EXTENDED)
                {
                    array_push(_check_array, gp_guide, gp_misc1, gp_touchpad, gp_paddle1, gp_paddle2, gp_paddle3, gp_paddle4);
                }
                
                var _i = 0;
                repeat(array_length(_check_array))
                {
                    var _check = _check_array[_i];
                    if (input_gamepad_is_axis(_gamepad, _check))
                    {
                        var _value = input_gamepad_value(_gamepad, _check);
                        if (abs(_value) > input_axis_threshold_get(_check, _player_index).mini)
                        {
                            return (input_binding_gamepad_axis(_check, (_value < 0)).__gamepad_set(_gamepad));
                        }
                    }
                    else
                    {
                        if (input_gamepad_check(_gamepad, _check))
                        {
                            return (input_binding_gamepad_button(_check).__gamepad_set(_gamepad));
                        }
                    }
                
                    ++_i;
                }
            }
        break;
    }
    
    return undefined;
}

function __input_source_any_input(_source, _gamepad)
{
    switch(_source)
    {
        case __INPUT_SOURCE.KEYBOARD:
            return (global.__input_any_keyboard_binding_defined
                 && keyboard_check(vk_anykey)
                 && !__input_key_is_ignored(__input_keyboard_key()));
        break;
        
        case __INPUT_SOURCE.MOUSE:
            return (global.__input_any_mouse_binding_defined && (global.__input_pointer_moved || input_mouse_check(mb_any) || mouse_wheel_up() || mouse_wheel_down()));
        break;
        
        case __INPUT_SOURCE.GAMEPAD:
            if (!gamepad_is_connected(_gamepad)) return false;
            
            if (input_gamepad_check(_gamepad, gp_face1)
            ||  input_gamepad_check(_gamepad, gp_face2)
            ||  input_gamepad_check(_gamepad, gp_face3)
            ||  input_gamepad_check(_gamepad, gp_face4)
            ||  input_gamepad_check(_gamepad, gp_padu)
            ||  input_gamepad_check(_gamepad, gp_padd)
            ||  input_gamepad_check(_gamepad, gp_padl)
            ||  input_gamepad_check(_gamepad, gp_padr)
            ||  input_gamepad_check(_gamepad, gp_shoulderl)
            ||  input_gamepad_check(_gamepad, gp_shoulderr)
            ||  input_gamepad_check(_gamepad, gp_start)
            ||  input_gamepad_check(_gamepad, gp_select)
            ||  input_gamepad_check(_gamepad, gp_stickl)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  input_gamepad_check(_gamepad, gp_stickr)
            ||  (abs(input_gamepad_value(_gamepad, gp_shoulderlb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_shoulderrb)) > INPUT_DEFAULT_TRIGGER_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axislh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axislv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axisrh)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD)
            ||  (abs(input_gamepad_value(_gamepad, gp_axisrv)) > INPUT_DEFAULT_AXIS_MIN_THRESHOLD))
            {
                return true;
            }
            
            if (INPUT_SDL2_ALLOW_EXTENDED)
            {
                if (input_gamepad_check(_gamepad, gp_guide)
                ||  input_gamepad_check(_gamepad, gp_misc1)
                ||  input_gamepad_check(_gamepad, gp_touchpad)
                ||  input_gamepad_check(_gamepad, gp_paddle1)
                ||  input_gamepad_check(_gamepad, gp_paddle2)
                ||  input_gamepad_check(_gamepad, gp_paddle3)
                ||  input_gamepad_check(_gamepad, gp_paddle4))
                {
                    return true;
                }
            }
            
            return false;
        break;
        
        default:
            __input_error("Source \"", _source, "\" not recognised");
        break;
    }
}