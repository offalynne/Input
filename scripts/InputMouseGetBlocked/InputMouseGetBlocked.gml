// Feather disable all

/// Returns whether mouse input is blocked.

function InputMouseGetBlocked()
{
    static _system = __InputSystem();
    return _system.__pointerBlockedByUser;
}