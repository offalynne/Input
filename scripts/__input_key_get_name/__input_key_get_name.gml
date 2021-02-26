/// @param keycode

function __input_key_get_name(_key)
{
    if ((_key >= ord("A")) && (_key <= ord("Z")))
    {
        //Latin letters
        return chr(_key);
    }
    else if ((_key >= vk_f1) && (_key <= vk_f1 + 23))
    {
        //Function keys
        return ("F" + string(1 + _key - vk_f1));
    }
    else if (_key >= ord("0")) && (_key <= ord("9"))
    {
        //Top row number keys
        return chr(_key);
    }
    else 
    {
        switch(_key)
        {
            //Symbols
            case 108: return "|";  break;
            case 186: return ";";  break;
            case 187: return "=";  break;
            case 188: return ",";  break;
            case 189: return "-";  break;
            case 190: return ".";  break;
            case 191: return "/";  break;
            case 192: return "'";  break;
            case 219: return "[";  break;
            case 220: return "\\"; break;
            case 221: return "]";  break;
            case 222: return "#";  break;
            case 223: return "`";  break;
            
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
            
            //Command keys
            case vk_rshift: return "right shift"; break;
            case vk_lshift: return "left shift";  break;
            case vk_shift:  return "shift";       break;
            
            case vk_rcontrol: return "right ctrl"; break;
            case vk_lcontrol: return "left ctrl";  break;
            case vk_control:  return "ctrl";       break;
            
            case vk_ralt: return "right alt"; break;
            case vk_lalt: return "left alt";  break;
            case vk_alt:  return "alt";       break;
            
            case vk_up:    return "arrow up";    break;
            case vk_down:  return "arrow down";  break;
            case vk_left:  return "arrow left";  break;
            case vk_right: return "arrow right"; break;
            
            case vk_escape:    return "escape";    break;
            case vk_backspace: return "backspace"; break;
            case vk_space:     return "space";     break;
            case vk_tab:       return "tab";       break;
            case vk_enter:     return "enter";     break;
            
            case vk_home:        return "home";         break;
            case vk_end:         return "end";          break;
            case vk_insert:      return "insert";       break;
            case vk_delete:      return "delete";       break;
            case vk_pagedown:    return "page down";    break;
            case vk_pageup:      return "page up";      break;
            case vk_printscreen: return "print screen"; break;
            case vk_pause:       return "pause break";  break;
            
            //Weirdo keys
            case  12: return "clear";       break; //Numpad 5 key, but with numlock off. Did you know this key existed? I didn't
            case  20: return "capslock";    break;
            case  47: return "help";        break;
            case  91: return "left meta";   break; // Windows/Command/Search key
            case  92: return "right meta";  break;
            case  93: return "menu";        break; // Apps key
            case 144: return "numlock";     break;
            case 145: return "scroll lock"; break;
        }
        
        return chr(_key); //Fallback
    }
}