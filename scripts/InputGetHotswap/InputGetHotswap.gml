// Feather disable all

/// Returns whether hotswapping for player 0 is turned on.

function InputGetHotswap()
{
    static _system = __InputSystem();
    
    return ((not INPUT_BAN_HOTSWAP) && _system.__hotswap);
}