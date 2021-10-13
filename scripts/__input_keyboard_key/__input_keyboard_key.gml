function __input_keyboard_key()
{
    if (__INPUT_KEYBOARD_SUPPORT && (keyboard_check(vk_anykey)))
    {        
        switch (os_type)
        {
            //Android keyboard test
            case os_android:
                if (!INPUT_ANDROID_KEYBOARD_ALLOWED) return 0;

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
                if (!INPUT_SWITCH_KEYBOARD_ALLOWED) return 0;
                
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
                return keyboard_key;
            break;
        }
    }
    
    return 0;
}
