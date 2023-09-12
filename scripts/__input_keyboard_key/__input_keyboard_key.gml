// Feather disable all
function __input_keyboard_key()
{
    __INPUT_GLOBAL_STATIC_LOCAL  //Set static _global
    
    if (_global.__keyboard_allowed && keyboard_check(vk_anykey))
    {        
        switch(os_type)
        {
            //Android keyboard test
            case os_android:

                //Android UTF8
                if (keyboard_check(ord(keyboard_lastchar))) return ord(keyboard_lastchar);

                //Android control
                if (keyboard_check(vk_left     )) return vk_left;
                if (keyboard_check(vk_up       )) return vk_up;
                if (keyboard_check(vk_down     )) return vk_down;
                if (keyboard_check(vk_right    )) return vk_right;
                if (keyboard_check(vk_backspace)) return vk_backspace;

                return 0;
            break;
            
            //Switch keyboard test
            case os_switch:
                
                //Switch UTF8
                if (keyboard_check(ord(keyboard_lastchar))) return ord(keyboard_lastchar);
                
                //Switch control
                var _i = 254;
                repeat(248)
                {
                    if (keyboard_check(_i)) return _i;
                    --_i;
                }

                return 0;
            break;
            
            default:

                //Don't return "any" (key is out of range)
                if (keyboard_key == 1) 
                {
                    return 0;
                }

                return keyboard_key;
            break;
        }
    }
    
    return 0;
}
