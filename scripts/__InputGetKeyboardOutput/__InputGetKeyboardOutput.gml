// Feather disable all

function __InputGetKeyboardOutput()
{
    static _system = __InputSystem();
    
    if ((not INPUT_BAN_KBM) && keyboard_check(vk_anykey))
    {
        //Don't return "any" (key is out of range)
        if (keyboard_key <= 1) return undefined;
        return __InputKeyIsIgnored(keyboard_key)? undefined : keyboard_key;
    }
    
    return undefined;
}
