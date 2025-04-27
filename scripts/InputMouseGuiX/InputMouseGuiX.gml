// Feather disable all

/// Returns the x coordinate of the mouse point in GUI-space.

function InputMouseGuiX()
{
    static _system = __InputSystem();
    return _system.__pointerGuiX;
}