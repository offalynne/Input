// Feather disable all

/// Returns whether the mouse has moved between frames

function InputMouseMoved()
{
    static _system = __InputSystem();
    return _system.__pointerMoved;
}
