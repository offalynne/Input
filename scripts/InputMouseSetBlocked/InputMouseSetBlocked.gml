// Feather disable all

/// Sets whether mouse input should be blocked.
/// 
/// @param state

function InputMouseSetBlocked(_state)
{
    static _system = __InputSystem();
    with(_system)
    {
        __pointerBlockedByUser = _state;
        __pointerBlockedByUserThisFrame = _state;
    }
}