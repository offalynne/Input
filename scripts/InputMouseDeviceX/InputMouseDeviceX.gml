// Feather disable all

/// Returns the x coordinate of the mouse point in device-space.

function InputMouseDeviceX()
{
    static _system = __InputSystem();
    return _system.__pointerDeviceX;
}