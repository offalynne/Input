// Feather disable all

function __InputGetKeyboardActive()
{
    if (INPUT_BAN_KBM) return false;
    
    return (__InputGetKeyboardOutput() != undefined);
}