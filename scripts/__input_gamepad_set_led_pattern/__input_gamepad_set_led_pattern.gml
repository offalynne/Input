/// This function should be called in the scope of a gamepad class
function __input_gamepad_set_led_pattern()
{
    if not (__INPUT_LED_PATTERN_SUPPORT) return;
    
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    //Steam uses the Xbox 360 pattern for Switch gamepads
    static _switch_pattern_type = ((os_type == os_windows)? INPUT_GAMEPAD_TYPE_XBOX_360 : INPUT_GAMEPAD_TYPE_SWITCH);
    
    __led_pattern = undefined;
  
    //By default, gamepads enumerate 0-N
    var _value = index + 1;
    var _lookup_index = index;

    //Platform cases
    switch(os_type)
    {
        case os_switch:
            if (index == 0)
            {
                //Slot 0 is reserved for handheld mode on Switch, no LED indicator
                return;
            }
            else
            {
                //On Switch, gamepads enumerate 1-8
                _value = index;
                _lookup_index = index - 1;
            }
        break;
        
        case os_ios:
        case os_tvos:        
            if (!__INPUT_ON_WEB)
            {
                //On iOS native, gamepads enumerate 1-4
                _value = index;
                _lookup_index = index - 1;
            }
        break;
        
       case os_windows:
            if not (is_numeric(__steam_handle))
            {
                //Steam Input only
                return;
            }
        break;
    }

    //Gamepad device cases
    switch(simple_type)
    {
        case INPUT_GAMEPAD_TYPE_PS5:
            __led_pattern = {
                pattern: _global.__gamepad_led_pattern_dict[$ INPUT_GAMEPAD_TYPE_PS5][@ _lookup_index], 
                layout:  "horizontal",
            }
        break;

        case INPUT_GAMEPAD_TYPE_XBOX_360:
            __led_pattern = {
                pattern: _global.__gamepad_led_pattern_dict[$ INPUT_GAMEPAD_TYPE_XBOX_360][@ _lookup_index],
                layout:  "radial",
            }
            return;
        break;

        case INPUT_GAMEPAD_TYPE_XBOX_ONE:
            if ((os_type == os_ios) || (os_type == os_tvos) && (raw_type == "AppleController")) //MFi Controller
            {
                __led_pattern = {
                    pattern: _global.__gamepad_led_pattern_dict[$ INPUT_GAMEPAD_TYPE_XBOX_360][@ _lookup_index],
                    layout:  "horizontal",
                }
            }
            return;
        break;

        case INPUT_GAMEPAD_TYPE_JOYCON_LEFT:
        case INPUT_GAMEPAD_TYPE_JOYCON_RIGHT:
                __led_pattern = {
                    pattern: _global.__gamepad_led_pattern_dict[$ _switch_pattern_type][@ _lookup_index],
                    layout:  (INPUT_SWITCH_HORIZONTAL_HOLDTYPE? "horizontal" : "vertical"),
                }
            return;
        break;

        case INPUT_GAMEPAD_TYPE_SWITCH:
                __led_pattern = {
                    pattern: _global.__gamepad_led_pattern_dict[$ _switch_pattern_type][@ _lookup_index],
                    layout: ((raw_type == "SwitchJoyConPair")? "vertical" : "horizontal"),
                }         
        break;

        default: return; break;
    }

    if (__led_pattern != undefined)
    {
        __led_pattern.value = _value; 
    }
}
