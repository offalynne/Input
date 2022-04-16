/// @param keycode

function __input_key_get_name(_key)
{
    if ((_key >= ord("A")) && (_key <= ord("Z")))
    {
        //Latin letters
        return chr(_key);
    }
    else if (_key >= ord("0")) && (_key <= ord("9"))
    {
        //Top row numbers
        return chr(_key);
    }
    else 
    {
        //Universal non-UTF8 keycodes
        switch(_key)
        {             
            case vk_up:    return "arrow up";    break;
            case vk_down:  return "arrow down";  break;
            case vk_left:  return "arrow left";  break;
            case vk_right: return "arrow right"; break;
            
            case vk_escape:    return "escape";    break;
            case vk_backspace: return "backspace"; break;
            case vk_space:     return "space";     break;
            case vk_tab:       return "tab";       break;
            case vk_enter:     return "enter";     break;
        }
        
        //Apple Web exceptions
        if (__INPUT_ON_APPLE && __INPUT_ON_WEB)
        {
            switch(_key)
            {
                case 12: return "num lock";   break;
                case 92: return "left meta";  break;
                case 93: return "right meta"; break;
            }
        }
        
        //Switch exceptions
        if (os_type == os_switch)
        {
            switch(_key)
            {
                case 107: return "+"; break;
                case 109: return "-"; break;
                case 110: return "."; break;
            }
        }

        //Desktop platform non-UTF8 keycodes
        if (__INPUT_KEYBOARD_NORMATIVE)
        {
            //Common function row (F1 - F10)
            if ((_key >= vk_f1) && (_key <= vk_f10))
            {
                return ("F" + string(1 + _key - vk_f1));
            }

            switch(_key)
            {                 
                //Symbols
                case 186: return ";";  break;
                case 188: return ",";  break;
                case 190: return ".";  break;
                case 191: return "/";  break;
                case 219: return "[";  break;
                case 220: return "\\"; break;
                case 221: return "]";  break;
            
                //Control
                case  93: return "menu";        break;
                case 144: return "num lock";    break;
                case 145: return "scroll lock"; break;
                                                   
                //Command pairs
                case vk_ralt: return "right alt"; break;
                case vk_lalt: return "left alt";  break;
                case vk_alt:  return "alt";       break;

                case vk_rshift: return "right shift"; break;
                case vk_lshift: return "left shift";  break;
                case vk_shift:  return "shift";       break;
            
                case vk_rcontrol: return "right ctrl"; break;
                case vk_lcontrol: return "left ctrl";  break;
                case vk_control:  return "ctrl";       break;
                
                //Numpad
                case vk_numpad0:  return "numpad 0"; break;
                case vk_numpad1:  return "numpad 1"; break;
                case vk_numpad2:  return "numpad 2"; break;
                case vk_numpad3:  return "numpad 3"; break;
                case vk_numpad4:  return "numpad 4"; break;
                case vk_numpad5:  return "numpad 5"; break;
                case vk_numpad6:  return "numpad 6"; break;
                case vk_numpad7:  return "numpad 7"; break;
                case vk_numpad8:  return "numpad 8"; break;
                case vk_numpad9:  return "numpad 9"; break;
                case vk_divide:   return "numpad /"; break;
                case vk_decimal:  return "numpad ."; break;
                case vk_multiply: return "numpad *"; break;
                case vk_add:      return "numpad +"; break;
                case vk_subtract: return "numpad -"; break;            

                //Misc.
                case vk_capslock:    return "caps lock";    break;
                case vk_home:        return "home";         break;
                case vk_end:         return "end";          break;
                case vk_insert:      return "insert";       break;
                case vk_delete:      return "delete";       break;
                case vk_pagedown:    return "page down";    break;
                case vk_pageup:      return "page up";      break;
                case vk_printscreen: return "print screen"; break;
                case vk_pause:       return "pause break";  break;
            }
        }
        
        //Per platform non-UTF8
        var _platform = os_type;

        //Browsers normalize keycodes across platforms
        //See https://github.com/wesbos/keycodes/blob/gh-pages/scripts.js        
        if (__INPUT_ON_WEB) _platform = "browser";
        
        switch(_platform)
        {
            //UWP uses select keycodes to reflect gamepad input
            //by default this behaviour is ignored (INPUT_IGNORE_RESERVED_KEYS_LEVEL > 0)              
            case os_uwp:
               switch(_key)      
               {
                   case 195: return "gamepad face south"; break;
                   case 196: return "gamepad face east";  break;
                   case 197: return "gamepad face west";  break;
                   case 198: return "gamepad face north"; break;

                   case 200: return "gamepad shoulder l"; break;
                   case 199: return "gamepad shoulder r"; break;
                   case 201: return "gamepad trigger l";  break;
                   case 202: return "gamepad trigger r";  break;

                   case 208: return "gamepad select"; break;
                   case 207: return "gamepad start";  break;

                   case 209: return "gamepad thumbstick l click"; break;
                   case 210: return "gamepad thumbstick r click"; break;

                   case 203: return "gamepad dpad up";    break;
                   case 204: return "gamepad dpad down";  break;
                   case 205: return "gamepad dpad left";  break;
                   case 206: return "gamepad dpad right"; break;

                   case 214: return "gamepad thumbstick l left";  break;
                   case 213: return "gamepad thumbstick l right"; break;
                   case 211: return "gamepad thumbstick l up";    break;
                   case 212: return "gamepad thumbstick l down";  break;

                   case 218: return "gamepad thumbstick r left";  break;
                   case 217: return "gamepad thumbstick r right"; break;
                   case 215: return "gamepad thumbstick r up";    break;
                   case 216: return "gamepad thumbstick r down";  break;
               }
                
            //UWP also uses Windows case
            case os_windows:
            case "browser":
                //F11 - F32
                if ((_key >= vk_f11) && (_key <= vk_f1 + 31))
                {
                    return "F" + string(_key - vk_f1 + 1);
                }
            
                switch(_key)
                {
                    case 187: return "="; break;
                    case 189: return "-"; break;
                    case 192: return "`"; break;
                    case 222: return "'"; break;
            
                    case 12:  return "clear"; break;
                    
                    case vk_meta1: return "left meta";  break;
                    case vk_meta2: return "right meta"; break;
                }
            break;
            
            case os_macosx:
                switch(_key)      
                {
                    case 128: return "F11"; break;
                    case 129: return "F12"; break;
                    
                    case 24:  return "="; break;
                    case 109: return "-"; break;
                    case 222: return "'"; break;
                    
                    //Swapped on Mac
                    case vk_meta1:  return "right meta"; break;
                    case vk_meta2:  return "left meta";  break;
                }
            break;
            
            case os_linux:
                switch(_key)      
                {
                    case 128: return "F11"; break;
                    case 129: return "F12"; break;
                    
                    case 187: return "="; break;
                    case 189: return "-"; break;
                    case 192: return "'"; break;
                    case 223: return "`"; break;
                    
                    case vk_meta1:  return "left meta";  break;
                    case vk_meta2:  return "right meta"; break;
                }
            break;
            
            case os_android:
                switch(_key)      
                {
                    case 10: return "enter";
                }
            break;
            
            case os_switch:
                switch(_key)
                {
                    case 2: case 3: case 4: 
                    case 5: case 6: case 7:
                        return string(_key);
                    break;
                    
                    case 128: return "F11"; break;
                    case 129: return "F12"; break; 
                }
            break;
        }
        
        return chr(_key); //Default to UTF8 character
    }
}
