// Feather disable all

/// Returns whether the given mouse button is currently held down.
/// 
/// @param {Constant.MouseButton,Real} [binding=mb_left]

function InputMouseCheck(_binding = mb_left)
{
    static _system = __InputSystem();
    if (INPUT_BLOCK_MOUSE_CHECKS || _system.__pointerBlocked) return false;
    
    return __InputMouseCheckRaw(_binding);
}

function __InputMouseCheckRaw(_binding)
{
    static _system = __InputSystem();
    
    if not ((_binding == mb_left) || (_binding == mb_any) || (_binding == mb_none))
    {
        //Extended mouse buttons
        return device_mouse_check_button(0, _binding);
    }
    
    var _left = (INPUT_ON_WINDOWS && _system.__tapClick)? true : device_mouse_check_button(0, mb_left);
    
    if (_binding == mb_left)
    {
        return _left;
    }
    else if (_binding == mb_any)
    {
        return (_left || device_mouse_check_button(0, mb_any));
    }
    else if (_binding == mb_none)
    {
        return ((not _left) && device_mouse_check_button(0, mb_none));
    }
    
    __InputError("Mouse button out of range (", _binding, ")");
    
    return false;
}
