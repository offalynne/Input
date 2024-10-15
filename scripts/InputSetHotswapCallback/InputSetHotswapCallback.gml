// Feather disable all

/// Sets a callback to execute when a hotswap occurs. The callback is executed with no parameters.
/// 
/// @param {Function, undefined} callback

function InputSetHotswapCallback(_callback)
{
    static _system = __InputSystem();
    
    if (INPUT_BAN_HOTSWAP) return;
    _system.__hotswapCallback = _callback;
}