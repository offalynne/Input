// Feather disable all

/// Returns the y coordinate of the mouse point in GUI-space.

function InputMouseGuiY()
{
    static _system = __InputSystem();
    return _system.__pointerGuiY;
}